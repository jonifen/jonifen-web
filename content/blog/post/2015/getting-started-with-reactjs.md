+++
author = "Jon"
date = "2015-11-06T22:08:00Z"
description = "I've been following the \"Getting Started\" tutorials on the ReactJS website. It's a bit... errr... bizarre to be honest! It does say that the way it does things is a little odd, and to give it 5 minutes and then make a decision. Despite this \"odd-ness\" though, it's become really popular, so it's well worth having a look at."
tags = ["programming", "javascript", "reactjs"]
title = "Getting Started with React.js"
type = "post"

+++

I've been following the "[Getting Started](https://facebook.github.io/react/docs/getting-started.html)" tutorials on the ReactJS website. It's a bit... errr... bizarre to be honest! It does say that the way it does things is a little odd, and to give it 5 minutes and then make a decision. Despite this "odd-ness" though, it's become really popular, so it's well worth having a look at.

I've been having a few problems with the tutorial though. I'll explain where things haven't gone well and what I did to fix it.

Although it's not essential to have npm, it looks like it'd make things easier in the long run, so I set about getting that first. It turns out the best/easiest way to get it installed is to install [node.js](https://www.nodejs.org) - which is what I did.

Once this was done, I followed the tutorial by creating my first JSX file (main.js):

	// main.js
	var React = require('react');
	var ReactDOM = require('react-dom');

	ReactDOM.render(
	  <h1>Hello, world!</h1>,
	  document.getElementById('example')
	);

And then ran the following commands to convert the JSX to raw Javascript:

	$ npm install --save react react-dom babelify babel-preset-react

and then

	$ browserify -t [ babelify --presets [ react ] ] main.js -o bundle.js

but the second line failed.

	C:\Users\jon\Source\Learning\React\HelloWorld>browserify
	'browserify' is not recognized as an internal or external command,
	operable program or batch file.

Bugger. This clearly meant that it couldn't see the browserify app from the folder I was in. Maybe this was because the tutorial never told me to install it first! So I tried this:

	$ npm install --save browserify

and tried again but to no avail.

Luckily, I'm not alone in learning React, and a friend at work has also been looking into it too, and he suggested installing the packages globally. So off I set!

	$ npm install --save -g react react-dom babelify babel-preset-react browserify

But it still couldn't find browserify. Which meant it must be down to the PATH environment variable, but I didn't know where globally installed node packages were installed. Enter [Ash Kyd](http://getcontext.net) and his [blog entry](http://getcontext.net/read/installing-npm-packages-globally-on-windows) where he details how to get the PATH variable updated. Following this sorted the problem out! :-)

(Content copied in below in case of dead links in the future)

	For some reason (per­haps in multi-user envir­on­ments) a default install of Node on Windows may not put the cor­rect NPM global pack­age loc­a­tion in the path.

	If you’re hav­ing issues like the following:

	'grunt' is not recognized as an internal or external command,
	operable program or batch file.

	Where Grunt might be any global pack­age, such as Browserify, add the fol­low­ing loc­a­tion to your path:

	Windows 7: C:\Users\{username}\AppData\Roaming\npm

	Replace {username} with your cur­rently logged in user.

	This should make global Node mod­ules dis­cov­er­able and usable on your system.

For info, I found after installing the packages globally, I was able to run

	$ npm list -g

and the location on my computer was at the top of the output:

	C:\Users\jon\Source\Learning\React\HelloWorld>npm list -g
	C:\Users\jon\AppData\Roaming\npm
