---
layout: post
title: "Automating the Weekly Muse: A Blogging Pipeline"
date: 2026-03-28
---

# Why Weekly?

Consistency beats intensity. A weekly cadence is frequent enough to build momentum, rare enough to avoid burnout. 

But here's the problem: **friction**. The gap between "I should write" and "I actually wrote" is filled with:
- What should I write about?
- How do I format this?
- Did I already publish something this week?

## The Solution: Rotate Themes, Automate the Boring Stuff

Inspired by technical blogs like [juleshenry's](https://github.com/juleshenry/juleshenry.github.io) — which dive deep into WASM, algorithms, and performance engineering — I'm adopting a **themed rotation**:

| Week | Theme |
|------|-------|
| 1 | **Technical** — code, APIs, algorithms, experiments |
| 2 | **Multilingual** — language learning, translations, cultural notes |
| 3 | **Music** — reviews, theory, artist spotlights |
| 4 | **Books & Philosophy** — reviews, essays |
| 5 | **Wildcard** — whatever caught my attention |

This way, the question isn't "What should I write?" but "What caught my attention in the *technical* realm this week?"

## The Automation Script

Here's the shell script that creates a dated, front-matter-ready post:

```bash
#!/bin/bash
title="${1// /-}"  # Replace spaces with hyphens in the title
date=$(date +%Y-%m-%d)
filename="${date}-${title}.md"
touch "$filename"
header="---\nlayout: post\ntitle: \"$1\"\ndate: $(date +%Y-%m-%d)\n---\n\n"
echo -e $header > "$filename"
```

Usage: `./make_post.sh "My Brilliant Idea"` → `2026-03-28-my-brilliant-idea.md`

## The Real Challenge

Automation solves the *mechanical* friction. The *creative* friction remains. But that's okay. The goal isn't to eliminate resistance — it's to show up despite it.

See you next week for **Multilingual Monday** (or whatever day I actually publish).

---

*This post is Week 1 of 5 in the inaugural cycle. Next up: something in at least two languages.*
