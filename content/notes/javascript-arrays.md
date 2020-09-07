---
title: "JavaScript"
type: "note"
description: "Some JS nuggets for future reference"
---

# Convert JavaScript Number to Number Array

When splitting a string to an array, you get an array of strings. When splitting a number to an array, you still get an array of strings unless you do the following:

```js
const theNumber = 432375;
const output = Array.from(theNumber.toString()).map(Number);
console.log(output); // [4, 3, 2, 3, 7, 5]
```

-----
