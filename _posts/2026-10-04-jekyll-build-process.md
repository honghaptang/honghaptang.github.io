---
layout: post
title: "The Jekyll Build Process: Static Site Alchemy"
date: 2026-10-04
---

# Week 28: Technical

## The Pipeline

```
Markdown + Front Matter + Layouts → HTML
```

## The Front Matter

```yaml
---
layout: post
title: "My Post"
date: 2026-10-04
---
```

Three lines. Jekyll reads them. Knows what to do.

## The Layout

```html
---
layout: default
---
{{ content }}
```

The layout wraps the content. Like a present. Like a shell.

## The Build

```bash
$ jekyll build
Configuration file: /path/to/_config.yml
            Source: /path/to/source
       Destination: /path/to/_site
 Incremental build: disabled
       Generating... 
                     done in 0.5 seconds.
```

Half a second. 50 posts. Static site generation is fast.

## The `future: true` Flag

```yaml
future: true
```

Added in April 2026. Lets me write posts dated in the future. Jekyll renders them anyway.

## The Magic

No database. No server-side rendering. Just files. Just text. Just git.

The alchemy: text becomes HTML becomes website becomes... something real.

---

*Week 28 of ∞. Next: Multilingual*
