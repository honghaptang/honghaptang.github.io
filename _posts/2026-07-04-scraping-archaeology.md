---
layout: post
title: "Web Scraping as Archaeology"
date: 2026-07-04
---

# Week 15: Technical

## The Dig Site

```python
import requests
from bs4 import BeautifulSoup

url = "https://example.com/ancient-text"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

artifacts = soup.find_all('div', class_='artifact')
```

## The Layers

| Stratum | Era | Technology |
|---------|-----|------------|
| Surface | 2026 | React, Tailwind |
| Middle | 2015 | jQuery, Bootstrap |
| Deep | 2005 | Tables, inline CSS |
| Bedrock | 1995 | Plain HTML |

## The Preservation Problem

You scrape a site today. Tomorrow it changes. The Wayback Machine captures snapshots. But the *feeling* of using Geocities in 1997? That's gone.

## The Ethics

- Robots.txt says "don't scrape"
- You scrape anyway
- Is it theft? Archaeology? Both?

## The Personal Connection

This blog will be scraped someday. Or it will vanish. Either way, someone will try to recover what was here.

I'm writing for the archaeologists of 2050. Hi, future people. We tried our best.

---

*Week 15 of ∞. Next: Multilingual*
