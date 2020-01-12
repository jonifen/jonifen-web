---
author: "Jon"
date: "2017-01-16T22:38:50Z"
description: "Sometimes the version of an npm package has some functionality you want, but it has issues which break other stuff. What do you do? Pull the repo and build it yourself and shoehorn it in?"
title: "npm package.json - Package From a Github Commit"
type: "blog"
tags: [
	"programming",
	"javascript",
	"reactjs",
	"npm"
]

---

Sometimes the version of an npm package has some functionality you want, but it has issues which break other stuff. What do you do? Pull the repo and build it yourself and shoehorn it in? Let's see...

For my example, I'll use the griddle-react package.

I quite like the Griddle component (griddle-react), I've posted about it in the past, and use it both at work and in side-projects at home whenever tabular data needs to be displayed as it's quick and simple. However, I've had it occur twice where a bug is present in the current npm package version, but since the package was pushed to npm, the bug has been fixed in the Github repository. How do I get this version into my project!?

It's actually very simple.

* Open the package.json in the root of your project.
* Find the package which is causing you grief.
* Edit the version string to include the link to the Github commit in the format `"git+{github-project-url}#{commit-guid}"`:

Example:

	"griddle-react": "git+https://github.com/GriddleGriddle/Griddle.git#d8f7ee8"

Once you've done that, do an `npm install` to update the package to the version needed, regenerate your .js (with webpack or whatever other fancy tool you use) and enjoy!

### Disclaimer
I feel that I really should add a brief disclaimer to this... while this does fix a potential problem scenario, it is essential that you check the changes made within the commit to ensure there's no "nasties" in there which could come back to bite you on the butt. This is particularly important if you're pulling from a project fork, as there's less policing of commits. There could be a perfectly valid reason why it hasn't been merged back into the master project and pushed to npm.
