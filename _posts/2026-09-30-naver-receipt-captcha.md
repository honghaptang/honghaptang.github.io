---
layout: post
title: "A Laptop VLM Solves 44% of Naver's Receipt CAPTCHAs"
date: 2026-09-30 12:01:00
categories: machine-learning
---

If you log in to Naver often enough, you'll eventually see a receipt instead of a login form.
It's photographed at an angle, torn into strips, and covered in scribbled letters, and underneath is a question:

> *What is the unit price of the least bought item per unit?*

This is Naver's receipt CAPTCHA. The idea is clever: instead of asking you to decode wavy letters, it asks you to
**read a messy document and reason about it**. The catch is that reading messy documents and reasoning about them is
exactly what vision–language models (VLMs) are trained to do.

So I measured it. The short version:

- An **unmodified, open-weight 7B model on a 16 GB laptop** answers **43.8%** of real challenges correctly.
- The 7B model gets **~62% of the "just read it off the receipt" questions** right, despite the tears and scribbles.
- It fails mainly on **multi-step arithmetic**, such as totals and "unit price of the least bought item".
- If failed attempts can be retried on fresh challenges, 43.8% per attempt means a **~94% chance of passing within five tries**.

A longer write-up with confidence intervals and significance tests is coming as a preprint.
This post is the readable version.

---

## What the challenge looks like

![An example Naver receipt CAPTCHA: two torn receipt strips at an angle over a textured background, with handwritten letters scattered over the text.](/blog/assets/2026/naver-captcha/example_challenge.png)

*A real challenge from April 2026. Question: "How many kinds of items did the customer purchase?"*

Every challenge is a 670×320 image plus one English question. The defenses are all about **layout, not lettering**:

- the receipt is torn into two or three strips, rotated and bent in perspective;
- handwritten letter/digit strings are scattered on top, sometimes right over the prices;
- parts of the receipt are cut off or hidden in the tear;
- the column order (Price / Qty / Sum / Name) changes from receipt to receipt.

The printed text itself is a clean, ordinary font. A model that can locate the right row can read it.

### The questions are surprisingly repetitive

I collected **1,100 challenges** on 9 April 2026. Across all of them there were only **295 distinct question strings**,
and nine fixed templates account for most of them:

| Question type | Share of challenges |
|---|---|
| Counting / quantity ("How many items cost 370 won per unit?") | 43.8% |
| Unit price of the most expensive / most bought item | 14.2% |
| Unit price of a named item ("…of frozen Skate?") | 10.2% |
| Unit price of the cheapest item | 7.5% |
| Unit price of the least bought item | 7.4% |
| Receipt total | 5.8% |
| Address fill-in-the-blank | 4.9% |
| A digit of the store's phone number | 3.9% |
| Rare types | 2.0% |

These split into two kinds:

- **Lookup questions**, where the answer is printed on the receipt (a named item's price, the address, a phone digit).
- **Aggregate questions**, where the answer has to be computed by counting, comparing, summing, or dividing a line total by its quantity.

That distinction turns out to explain almost everything.

---

## The experiment

I hand-labeled **128** of the collected challenges and asked three open-weight models from the Qwen VL family to answer
them **zero-shot**: no examples, no fine-tuning, no step-by-step prompting. The prompt was just the image, the question,
and "return only the answer". Everything ran locally on an M1 Pro laptop with 16 GB of memory.

| Model | Correct | Accuracy (95% CI) |
|---|---|---|
| Qwen2-VL-2B | 20 / 128 | 15.6% (10.3–22.9) |
| Qwen2.5-VL-3B | 34 / 128 | 26.6% (19.7–34.8) |
| **Qwen2.5-VL-7B** | **56 / 128** | **43.8% (35.5–52.4)** |

Both jumps (2B→3B and 3B→7B) are statistically significant on paired tests (p = 0.024 and p < 0.001).
My labeled set slightly over-represents the easy named-item price questions. Reweighting to the real question mix
brings the 7B model to about **37%**, still roughly three in eight.

![Per-question-type accuracy for the 2B, 3B and 7B models. The 7B model is strongest on address blanks and named-item prices and scores zero on receipt totals.](/blog/assets/2026/naver-captcha/per_type.png)

### Where the 7B model succeeds, and where it doesn't

| | 7B accuracy |
|---|---|
| **Lookup** questions (47 items) | **61.7%** |
| **Aggregate** questions (81 items) | **33.3%** |

The torn strips and scribbles didn't stop it from reading: it got **8 of 10 address blanks** and **16 of 27
named-item prices**. What it can't do yet is the arithmetic:

- **Receipt totals: 0 of 8.** It answers with a plausible amount of the right size (7,000 for 6,800; 12,000 for
  10,300) but never the exact total.
- **"Least bought item" unit price: 0 of 4.** It often returns a price from the wrong row, or a line sum instead of a unit price.
- **Counting shortcuts.** For "How many items cost N won per unit?" it often just says `1`, and for "total number of
  products" it often says `10` or `100`. It isn't really attempting the count.

In other words, the model **reads the receipt fine and skips the procedure**. That gap is the one that step-by-step
prompting, tool use, and task-specific fine-tuning are known to close.

I also screened five other open models on a small 17-item pilot. MiniCPM-V was about as good as Qwen-7B, while LLaVA-7B
and BakLLaVA barely registered. Llama 3.2-Vision 11B scored 15% over 60 items, mostly because it kept answering in full
sentences. **Parameter count alone doesn't predict success here.**

---

## What 44% means in practice

A CAPTCHA doesn't have to be unbeatable; it has to make automation expensive. If each failure brings a fresh,
independent challenge, per-attempt accuracy compounds quickly:

![Probability of passing within k attempts for each model. The 7B curve passes 80% at three attempts and 94% at five.](/blog/assets/2026/naver-captcha/retry.png)

| Attempts | Chance the 7B model has passed |
|---|---|
| 1 | 43.8% |
| 3 | 82.2% |
| 5 | 94.4% |
| 10 | 99.7% |

Three things stand out:

1. **The visual defenses don't block reading.** The torn, scribbled receipt stopped the 7B model on only about 40% of lookup questions.
2. **The remaining margin is arithmetic,** which is the capability current models are improving fastest at.
3. **It all runs on the attacker's own laptop.** There's no per-query cost and no third-party solving service, so API
   pricing and similar controls don't apply.

**Important caveats.** This is a per-challenge accuracy, **not** an end-to-end bypass rate. I didn't test Naver's rate
limits, lockouts, or risk scoring, and I never submitted an answer to the live site. Any of those could cut the number of
retries an attacker actually gets. I also didn't measure how well *people* do. Anecdotally, the least-bought-unit-price
questions are a chore for humans too, and that deserves a proper user study.

---

## Correcting the record on fine-tuning

An earlier draft of this project claimed that a LoRA adapter on the 2B model "didn't help". When I audited the saved
files, that experiment turned out to be broken rather than negative:

- the adapter's trained weights (its `B` matrices) were **exactly zero**, meaning it never learned anything;
- its "results" matched the untrained model's answers on **all 120 items**;
- the evaluation step in the pipeline was a placeholder;
- and it trained on the same items it was tested on.

So that claim is withdrawn.

**A corrected run is in progress now:** Qwen2.5-VL-7B (4-bit, MLX) with a LoRA adapter, evaluated by 4-fold
cross-validation. Each adapter trains on 96 labeled challenges and is scored only on the 32 it never saw. The same 4-bit
model with the same prompt scores **59 / 128 (46.1%)** zero-shot, which is the baseline to beat.

*The fine-tuning run is still going. I'll update this post with the held-out results, gain or no gain, when it finishes.*

---

## What Naver could do

- **Don't rely on this challenge alone.** Pair it with server-side risk signals and per-account / per-IP attempt limits,
  so the retry math above stops working.
- **Re-test regularly against current open models.** A defense that holds against last year's models won't necessarily hold against next year's.
- **Make questions easy for people and hard for models, not just harder.** Harder arithmetic mostly burdens legitimate
  users. Any change should be validated with a human study.

## Limitations

- **Small sample.** 128 labeled items give roughly ±8-point intervals overall, and most per-type numbers rest on a handful of items.
- **Confounded 7B comparison.** The 7B zero-shot run used a different runtime, quantization and prompt from the 2B/3B runs.
  The 4-bit MLX rerun (59/128) lands in the same place, which is reassuring.
- **Labels.** One annotator, with no confirmation from Naver's server. A spot-check of 18 labels found 2 errors, and
  neither changes any score.
- **Single snapshot.** All data come from one day in April 2026, and the challenge may have changed since.

## Ethics

I collected challenge images only, never submitted answers, never touched anyone else's account, and I'm not releasing a
ready-to-use solver or trained adapter.

