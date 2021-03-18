---
title: "Stop your font sizes differing between Landscape and Portrait mode on iOS"
description: "Have you ever had the problem where you're styling some content but when you rotate the device to change between landscape and portrait modes on an iOS device, the font size changes?"
date: "2021-03-18T21:59:32+01:00"
author: "Jon"
tags: [
  "programming",
  "css",
  "web",
  "ios"
]
type: "blog"
---

Have you ever had the problem where you're styling some content but when you rotate the device to change between landscape and portrait modes on an iOS device, the font size changes?

The simplest way to resolve it is to include this in one of your primary css rules such as `html` or `body`:

```css
-webkit-text-size-adjust: 100%;
```
