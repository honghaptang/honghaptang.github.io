---
layout: post
title: "The Perplexity of Country Codes"
date: 2026-08-30
---

# Week 23: Wildcard

## The Bug That Isn't

September 2025: Perplexity API rejects "MN" for Mongolia. I file it away as a bug.

August 2026: Still broken. Not a bug — a feature. Some countries aren't supported.

## The List

Supported (probably):
- US, GB, CA, AU, DE, FR...

Not supported (definitely):
- MN (Mongolia)
- CM (Cameroon)
- ...?

## The Question

Why? Technical limitation? Business decision? Geopolitics?

The API doesn't say. The error message lies: "valid 2-digit ISO country code." MN *is* valid. The real error: "your country isn't important enough."

## The Blog Post as Bug Report

I wrote about this 11 months ago. Nothing changed. The blog post didn't fix the bug. It fixed... something else. My understanding, maybe.

## The Code

```python
SUPPORTED_COUNTRIES = {"US", "GB", "CA", ...}  # MN not in list

def get_news(country):
    if country not in SUPPORTED_COUNTRIES:
        raise BadRequestError("valid 2-digit ISO country code")  # Lie
```

## The Lesson

APIs encode values. The values aren't always stated. Sometimes you learn them by being excluded.

---

*Week 23 of ∞. Next: Technical*
