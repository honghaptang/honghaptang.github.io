---
layout: post
title: "CSS as a Second Language"
date: 2026-06-06
---

# Week 11: Technical

## The Grammar of Styles

CSS has syntax but no semantics. You can write valid CSS that does nothing. You can write invalid CSS that works in Safari.

```css
.container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}
```

This is a sentence. It says: "Make a grid. Fit as many columns as you can. Each column at least 300px. Space them 2rem apart."

## The Vocabulary

| Property | Meaning | Example |
|----------|---------|---------|
| `display` | How to lay out | `grid`, `flex`, `block` |
| `position` | Where to place | `absolute`, `relative`, `fixed` |
| `margin` | Space outside | `1rem`, `auto`, `0` |
| `padding` | Space inside | `1rem`, `50%`, `inherit` |

## The Fluency Test

You know CSS when you can:
1. Center a div (the meme)
2. Center a div *and know why it works* (the reality)
3. Center a div *without looking it up* (the mastery)

I'm at stage 2. Maybe stage 1.5.

## The Polyglot Advantage

Knowing multiple spoken languages helps with CSS. You learn:
- There are multiple ways to say the same thing
- Some ways are more idiomatic
- The "right" way depends on context

`margin: 0 auto` is the CSS equivalent of *"¿Cómo estás?"* — basic, essential, universally understood.

---

*Week 11 of ∞. Next: Multilingual*
