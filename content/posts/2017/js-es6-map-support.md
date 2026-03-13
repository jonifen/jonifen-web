---
date: "2017-06-20T22:47:06+01:00"
type: "post"
title: "Map() support in JavaScript ES6/ES2015"
author: "Jon"
description: "ECMAScript 6/2015 has brought a lot of new things to the world of JavaScript, and Map() is one of them. However, not all browsers are too keen on particular ways of using it..."
tags: [
	"programming",
	"javascript"
]

---

ECMAScript 6/2015 has brought a lot of new things to the world of JavaScript, and Map() is one of them. However, not all browsers are too keen on particular ways of using it.

I've been working on a UI project at work this week and encountered a weird issue with some code written by a colleague. We have some scenarios in our React app where we need to translate/map some values from an integer to a string (for textual display in the rendered screen). We tend to use `Map()` to do this and for the most part it works fine, until today!

We've had some issues surrounding Internet Explorer 11 support in a few of our React pages which I've been investigating, and it turned out to be a missing polyfill for `Object.assign()` (although I replaced it with the spread operator instead), however I also found that Internet Explorer was complaining about where we initialised one of our `Map()` objects.

	var map = new Map().set(0, "Unknown").set(1, "Something").set(2, "Nothing")

Now, this goes through the Babel transpiler without any issues, and works fine in Google Chrome. Internet Explorer doesn't like it at all, and says it cannot find the set function in undefined. So I did some research into it and found a few reference points around the Internet which suggested that the syntax used above is perfectly valid, as the `set` function does indeed return the Map object containing the new item.

After a while, I came across http://exploringjs.com/es6/ch_maps-sets.html which pointed at an alternative way to initialise a `Map()` object:

	var map = new Map([
		[0, "Unknown"],
		[1, "Something"],
		[2, "Nothing"]
	])

At first I thought it was a bit cleaner to look at, but thought it was nothing more than syntactic sugar although I gave it a go anyway, and surprisingly, it transpiled through Babel fine, and worked perfectly in Internet Explorer 11! So, it might be worthwhile trying this out if you encounter the same issue.

Good luck!