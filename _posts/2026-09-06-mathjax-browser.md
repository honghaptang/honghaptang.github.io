---
layout: post
title: "MathJax in the Browser: Rendering the Infinite"
date: 2026-09-06
---

# Week 24: Technical

## The Setup

```html
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
```

One script tag. Infinite equations.

## The Syntax

```tex
$$
O(N^{1.58}) \text{ vs } O(N^2)
$$
```

Renders as: $O(N^{1.58}) \text{ vs } O(N^2)$

## The Karatsuba Connection

juleshenry's WASM experiment uses this exact formula. Karatsuba multiplication is $O(N^{1.58})$. Schoolbook is $O(N^2)$. At scale, Karatsuba wins.

## The Rendering Pipeline

1. Browser loads HTML
2. MathJax scans for `$$...$$` and `\[...\]`
3. MathJax converts TeX to HTML/CSS
4. User sees pretty math

## The Async Problem

MathJax loads asynchronously. The page renders. Then the math renders. The flash of unrendered equations.

```javascript
MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']],
    displayMath: [['$$', '$$'], ['\\[', '\\]']]
  }
};
```

Configuration before load. Order matters.

## The Blog's Math

This blog uses MathJax. Not for complex proofs. For beauty. For precision. For the occasional prime number theorem about souls.

---

*Week 24 of ∞. Next: Multilingual*
