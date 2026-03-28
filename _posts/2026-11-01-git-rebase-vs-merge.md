---
layout: post
title: "Git Rebase vs. Merge: A Commit History Story"
date: 2026-11-01
---

# Week 32: Technical

## The Two Paths

```
# Merge: preserves history
git merge feature

# Rebase: rewrites history
git rebase main
```

## The Merge Commit

```
*   Merge branch 'feature'
|\
| * feature commit 3
| * feature commit 2
| * feature commit 1
* | main commit 5
* | main commit 4
|/
* main commit 3
```

Honest. Messy. Shows what actually happened.

## The Rebase

```
* feature commit 3 (rebased)
* feature commit 2 (rebased)
* feature commit 1 (rebased)
* main commit 5
* main commit 4
* main commit 3
```

Clean. Linear. Lies about when things happened.

## The Philosophy

Merge says: "History is messy. Embrace it."

Rebase says: "History should be clean. Edit it."

## The Blog Analogy

This blog is a merge. Every post is a commit. The history shows:
- When I wrote
- What I wrote
- The gaps (no commits in some weeks)

I could delete the gaps. Rewrite the dates. Rebase the blog.

But the merge is honest. The gaps are part of the story.

## The Command

```bash
git log --oneline --graph
```

Look at the history. It tells the truth.

---

*Week 32 of ∞. Next: Multilingual*
