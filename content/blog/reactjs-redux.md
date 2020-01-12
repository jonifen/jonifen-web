---
draft: true
type: "blog"
title: "React.js - Redux"
author: "Jon"
description: "It's been a while since I last posted anything. As I've covered State, it's time to look at Redux and how it can help get a hold of State when it's being updated in many places within a component."
tags: [
  "programming",
  "javascript",
	"reactjs"
]
date: "2017-04-11T19:54:34+01:00"
---

It's been a while since I last posted anything. As I've covered State, it's time to look at Redux and how it can help get a hold of State when it's being updated in many places within a component.

So last time we were looking at using `state` to manage our data which we can refer to later on in our components and re-render our components automatically. This time, we're going to look at Redux, which was created to avoid potential problems with many areas of a component all updating state at the same time which could be causing side effects to our components.

___
**Important**: Before we start, you may be encountering problems with the webpack process raising an exception. This appears to be a new issue introduced in Webpack 2.3.0 which affects Windows users and is related to how it parses the current directory path. To resolve this, you would update your webpack.config.js so that your output section is as follows:

	`output: {
		path: path.resolve(__dirname, "./dist"),
		filename: "js/bundle.js"
	}`

Once this is done, you should find things will build fine again.
___

So let's continue from where we left off last time, and introduce Redux into the equation. First of all, we need to install the `redux` and `react-redux` modules:

	npm install --save redux react-redux

Once that's done, let's crack on.

.
