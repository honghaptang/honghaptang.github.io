---
layout: post
title: "The Bump Allocator in My Head"
date: 2026-05-02
---

# Week 6: Technical

## Memory Management as Metaphor

WebAssembly has a linear memory model. You get a chunk of bytes and you're responsible for organizing them. A bump allocator is the simplest approach:

```wat
(memory (export "memory") 1)

(global $heap_pointer (mut i32) (i32.const 65536))

(func $alloc (param $size i32) (result i32)
  local.get $heap_pointer
  local.get $size
  i32.add
  global.set $heap_pointer
  local.get $heap_pointer
  local.get $size
  i32.sub)
```

Allocate: move the pointer forward. Return the old position. That's it. No free. No compaction. Just... forward.

## The Mental Model

I think about memory the way I think about time:

- **Stack** — what I can hold in working memory (3-5 things, maybe)
- **Heap** — everything else, scattered, accessed by reference
- **Bump pointer** — the relentless forward march of calendar days

You can't deallocate yesterday. You can't compact last week. You just keep bumping.

## Karatsuba's Lesson

juleshenry's WASM experiment showed something beautiful: sometimes the "slower" algorithm wins at scale. Schoolbook multiplication is O(N²). Karatsuba is O(N^1.58). At small sizes, overhead dominates. At large sizes, asymptotics win.

Writing weekly is Karatsuba. The overhead feels wasteful. But at scale? The compound interest of showing up beats the sporadic brilliance of O(N²) cramming.

## This Week's Code

```python
# A bump allocator in Python, because why not
class BumpAllocator:
    def __init__(self, size=1024):
        self.memory = bytearray(size)
        self.pointer = 0
    
    def alloc(self, size):
        if self.pointer + size > len(self.memory):
            raise MemoryError("bump")
        result = self.pointer
        self.pointer += size
        return result
```

Simple. Inefficient. Honest.

---

*Week 6 of ∞. Next: Multilingual*
