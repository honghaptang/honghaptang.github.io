---
layout: post
title: "Korean Particles Are API Parameters"
date: 2026-09-13
---

# Week 25: Multilingual

## The Function Signature

```python
def shine(subject, topic=False):
    if topic:
        return f"{subject}는 빛났다"
    else:
        return f"{subject}가 빛났다"

shine("수")  # 수가 빛났다 — The move (subject) shone
shine("수", topic=True)  # 수는 빛났다 — As for the move, it shone
```

## The Particle System

| Particle | Function | Example |
|----------|----------|---------|
| 이/가 | Subject marker | 수가 (the move, subject) |
| 을/를 | Object marker | 돌을 (the stone, object) |
| 는/은 | Topic marker | 수는 (as for the move) |
| 에 | Location/time | 집에 (at home) |
| 와/과 | With | 친구와 (with friend) |

## The Lojban Comparison

Lojban doesn't have particles. It has sumti (arguments) and selbri (predicates):

```
lo stonu cu blabi
the stone is-white
```

Korean marks relationships. Lojban structures arguments. Both are precise. Both feel different.

## The Portuguese Comparison

Portuguese uses prepositions:

```
O movimento brilhou.
The move shone.
```

No particle. Just word order and context.

## The Insight

Korean forces you to mark every relationship explicitly. You can't say "move shone" — you must say "move-SUBJECT shone" or "move-TOPIC shone."

The language won't let you be vague about who's doing what.

---

*Week 25 of ∞. Next: Music*
