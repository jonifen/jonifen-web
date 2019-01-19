+++
author = "Jon"
description = "Visual Studio 2015 (by default) isn't exactly crash hot for editing JavaScript, especially JSX/ES6 for React etc."
date = "2017-01-13T20:02:39Z"
title = "JSX/ES6 Syntax Highlighting in Visual Studio 2015"
type = "post"
tags = [
  "programming",
  "javascript",
	"reactjs",
	"visualstudio"
]

+++

Visual Studio 2015 (by default) isn't exactly crash hot for editing JavaScript, especially JSX/ES6 for React etc.

A lot of developers seem to opt for alternative IDEs/editors for writing JavaScript code instead of staying in Visual Studio, however it's often more effort to manage multiple IDEs for one project. I've tried a few things myself to get things working, some of the steps below are courtesy of Nick Dewitt on [this StackOverflow post](http://stackoverflow.com/questions/34097915/visual-studio-2015-jsx-es2015-syntax-highlighting/36321109#36321109).

First of all, we use the .jsx file extension for JSX files, and the .es6 file extension for our es6 files. We do this so we're fully aware of which files require transpiling to "Vanilla JS" prior to release.

Disclaimer: The steps below is how I configured my installation of Visual Studio 2015 Enterprise to show syntax highlighting in my code. The steps have worked on multiple machines of mine, so should work for you too, but I can't guarantee it, so perform the following at your own discretion.

First of all, we configure Visual Studio to use the JavaScript editor for our .es6 files by adding the extension into the IDE, by doing the following:

* Open Visual Studio 2015
* Go to Tools > Options
* Go to Text Editor > File Extension
* Enter in "es6" (without quotes) into the Extension field, and select "JavaScript Editor" in the editor dropdown.
* Click "Add".

And while you're still in the Options screen...

* Go to Text Editor > JavaScript > IntelliSense
* Uncheck the "Show syntax errors" checkbox as this stops (false positive) errors from being highlighted in the code window.


Now, close Visual Studio, and open a Command Prompt/Powershell window as an Admin account.
Navigate to C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\Extensions\Microsoft\Web Tools\External\react-server
Run the following commands (to install babel packages):

	npm install babel-core --save-dev
	npm install babel-preset-es2015 --save-dev
	npm install babel-preset-react --save-dev
	npm install babel-preset-stage-1 --save-dev

Before you continue, back up your server.js file (contained within the above directory), we will edit this file next to introduce Babel.
You will need to open the server.js file in a text editor as an Administrator (as it is stored within Program Files).
Add the following to the top of the file (below where it refers to childProcess):

	var babel = require('babel-core');
	var es2015 = require('babel-preset-es2015');
	var react = require('babel-preset-react');
	var stage1 = require('babel-preset-stage-1');

Now amend the try/catch section in the transformJsxFromPost function so it reads as follows:

	try {
		var transformed = babel.transform(code, {sourceMaps: "inline", presets: [es2015, react, stage1]});
		result = { elementMappings: transformed.map };
	}
	catch (e) {
		result = e;
		result.errorMessage = e.message;
	}

Reload your project into Visual Studio. You *should* now see the syntax highlighting working fine, but you can easily reverse the steps above to get back to how things were :)

## Did you mess things up?
Hopefully, you will have backed things up before performing the above, but if you didn't, then below is the original try/catch section you changed in the server.js file, so you can revert back in case you need to go back to how it was before. All other steps are easily reversed:

	try {
		var transformed = reactTools.transformWithDetails(code, { elementMap: true });
		result = { elementMappings: transformed.elementMappings };
	}
	catch (e) {
		result = e;
		result.errorMessage = e.message;
	}
