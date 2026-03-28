---
layout: post
title: "Portuguese Verb Conjugation as State Machine"
date: 2026-06-13
---

# Week 12: Multilingual

## The States

Portuguese verbs have states. You transition between them based on:
- Who is acting (eu, tu, ele, nós, vós, eles)
- When they act (presente, pretérito, futuro)
- Whether they act (indicativo, subjuntivo, imperativo)

## The Transition Table

Take *falar* (to speak):

| Person | Presente | Pretérito | Futuro |
|--------|----------|-----------|--------|
| eu | falo | falei | falarei |
| tu | falas | falaste | falarás |
| ele | fala | falou | falará |
| nós | falamos | falámos | falaremos |
| vós | falais | falastes | falareis |
| eles | falam | falaram | falarão |

## The Implementation

```python
def conjugate(verb, person, tense):
    # This is a lie. Portuguese is too irregular.
    # But the idea is sound: state → transformation → output
    pass
```

## The Lojban Comparison

Lojban doesn't conjugate. It has tense particles that float freely:
- *pu* — past
- *ca* — present  
- *ba* — future

*mi pu klama* — I went. *mi ba klama* — I will go.

Portuguese bakes time into the verb. Lojban adds it as a modifier. Both work. Both feel different.

## The Lesson

Language design is API design. Do you bake state into the object (Portuguese verbs) or pass it as a parameter (Lojban particles)?

There's no right answer. Only tradeoffs.

---

*Week 12 of ∞. Next: Music*
