---
type: person
met: <% tp.date.now("YYYY-MM-DD") %>
role: "<% tp.file.cursor(1) %>"
org: "<% tp.file.cursor(2) %>"
tags: [person, <% tp.file.cursor(3) %>]
---

# <% tp.file.title %>

## Who

<% tp.file.cursor(4) %>

## Context

How we work together / how I know them:

<% tp.file.cursor(5) %>

## Notes

- 
