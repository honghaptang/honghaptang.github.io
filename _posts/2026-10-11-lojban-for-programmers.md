---
layout: post
title: "Lojban for Programmers: A Primer"
date: 2026-10-11
---

# Week 29: Multilingual

## The Predicate Language

Lojban has no nouns. Only predicates. Every word is a function waiting for arguments.

```
mi klama
I go
-- x1 goes to x2 from x3 via x4 using x5
```

`klama` isn't "go" — it's "x1 goes to x2 from x3 via x4 using x5." You can fill in any argument. Or leave it implicit.

## The Type System

```
lo mlatu -- a cat (x1 is a cat of breed x2)
lo gerku -- a dog (x1 is a dog of breed x2)
lo prenu -- a person (x1 is a person with property x2)
```

Every word has a type signature. Like Rust. Like TypeScript. But for natural language.

## The Logic Operators

| Lojban | Meaning | Code Equivalent |
|--------|---------|-----------------|
| `.e` | and | `&&` |
| `.a` | and/or | `\|\|` |
| `.onai` | if and only if | `===` |
| `naku` | not | `!` |

## The Example

```
mi prami do .e do prami mi
I love you and you love me
```

Symmetric love. The logic is sound. The emotion is... complicated.

## The Programmer's Appeal

Lojban is unambiguous. Parseable. Testable. It's the Haskell of natural languages.

But can it express poetry? That's the question.

---

*Week 29 of ∞. Next: Music*
