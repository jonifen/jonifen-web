---
author: "Jon"
date: "2015-11-12T20:46:00Z"
description: "While working on the Griddle functionality at work, we needed to throw in some inline styling (just to test something out quickly). Unfortunately, with React, this isn't as straightforward as just throwing in a style attribute with a few values."
tags: ["programming", "javascript", "reactjs"]
title: "Inline styles with React"
type: "blog"
draft: true
---

While working on the Griddle functionality at work, we needed to throw in some inline styling (just to test something out quickly). Unfortunately, with React, this isn't as straightforward as just throwing in a style attribute with a few values.

The React documentation does explain this, but I'm not impressed with having to create a variable just for a quick sweaty test of something. Instead, you can do this:

	<div style={{"height":"100%"}}></div>

By putting the style markup inside double curly braces, it does away with the requirement for another variable, which makes it ideal for quickly testing a new style.