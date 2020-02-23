---
type: "blog"
title: "Convert JavaScript Number to Number Array"
description: "I had a number which I wanted converting into an array where each digit of the number was an item in the array. I tried a few different ways of doing this but always ended up with a string array which wasn't what I wanted."
date: 2019-11-16T22:32:35Z
author: "Jon"
tags: ["programming", "javascript"]
---

I had a number which I wanted converting into an array where each digit of the number was an item in the array. I tried a few different ways of doing this but always ended up with a string array which wasn't what I wanted.

To get around this, you can use some of the new features introduced in ES6 as follows:

```js
const theNumber = 432375;
const output = Array.from(theNumber.toString()).map(Number);
console.log(output); // [4, 3, 2, 3, 7, 5]
```
