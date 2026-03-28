---
layout: post
title: "APIs Are Just Contracts"
date: 2026-08-01
---

# Week 19: Technical

## The Promise

```python
response = requests.get(
    "https://api.perplexity.ai/chat/completions",
    headers={"Authorization": f"Bearer {API_KEY}"},
    json={"model": "llama-3.1-sonar-small-128k-online", "messages": [...]}
)
```

The API promises: send this, get that.

## The Breach

```
perplexity.BadRequestError: country must be provided as a valid 2-digit ISO country code, got MN
```

Mongolia's code is MN. The API says MN is invalid. The contract is broken.

## The Reality

APIs aren't contracts. They're negotiations. The server can:
- Change the schema
- Deprecate endpoints
- Go down
- Lie

## The Lesson

I wrote about this in September 2025. The API still doesn't support Mongolia. Or Cameroon. Some countries aren't on the list.

## The Code

```python
def fetch_news(country_code):
    try:
        return api.get_news(country_code)
    except UnsupportedCountryError:
        # The contract was a lie
        return None
```

## The Philosophy

Every API is a small act of trust. You trust the endpoint will be there. You trust the schema won't change. You trust the country codes are complete.

Trust is always provisional.

---

*Week 19 of ∞. Next: Multilingual*
