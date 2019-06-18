---
type: "post"
title: "React.js Revisited"
author: "Jon"
description: "It's been a while since I wrote up my beginner guide to React.js and I've been thinking it's time to revisit it."
tags: [
  "programming",
  "javascript",
  "reactjs"
]
date: "2017-02-09T21:06:50Z"

---

**Edit 05/03/2017** - My son has kindly followed this mini tutorial and has pointed out a few areas where I didn't make much sense. All part of learning! But I've updated those areas below.


It's been a while since I wrote up my [beginner guide to React.js](/blog/post/2015/getting-started-with-reactjs) and I've been thinking it's time to revisit it as things have changed since then with better tooling and ES6 support etc. so here I am!

Since I started using React, I've used many different tools to "convert" JSX to vanilla JavaScript that a web browser can understand. I started with Browserify (which I use on my first post), we use Webpack at work, and I've also tried using Gulp in the meantime. However, I've finally settled on using Webpack, so this time I'll be using that.

So, chances are you'll be starting from scratch here, so you'll need to create a directory on your machine to store everything in. Make sure the directory name doesn't include spaces, so try using the name `jonifen-react-tutorial` for uniqueness :)

You'll also need to install Node.js from http://nodejs.org - either the LTS or latest versions will do.

Once you've installed Node.js and created the directory, open a command prompt window to that directory, and type in:

	npm init -y

to create a package.json file. This file is specific to Node, as it includes the details about the npm packages referenced by the project and also you can configure scripts (which we may cover in a future tutorial) which can batch commands into one to make things easier for building etc.

So let's start with our JavaScript code. Last time I was using ECMAScript 5 (ES5), but since that time we've been using ECMAScript 6 (ES6) instead which needs to be transpiled to vanilla JS using Babel which is "triggered" by Webpack. So, create a new file in your new directory called "main.js" and copy and paste (or type manually) the following into it:

	// main.js
	import React from 'react';
	import ReactDOM from 'react-dom';

	ReactDOM.render(
		<h1>Hello World!</h1>,
		document.getElementById("example")
	);

Ok, so if you've read my 1st page, you'll notice that while the code is pretty much the same, there is a noticeable difference where the references to `React` and `ReactDOM` are created. ES5 uses `require` to "include" objects into the code, whereas ES6 uses `import` to do the same thing.

Now we have the main.js file in place, let's look at the "build" process to transpile ES6 into vanilla ES5 JavaScript that your web browser will be able to understand.

We'll need to get the npm packages downloaded which are needed to make things happen, so let's start there.

	npm install --save react react-dom
	npm install --save-dev webpack babel-core babel-loader babel-preset-react babel-preset-es2015

The above commands will download the react and react-dom packages (which is essential, as we've referenced them in our main.js file just above!) and then also the packages for webpack and Babel which we'll get around to next, but we'll start with Webpack.

Webpack needs a configuration file in order to work, so I'll start there. Copy and paste the following into a new file in the root of your project directory called "webpack.config.js":

	module.exports = {
		entry: "./main.js",
		output: {
			path: "dist",
			filename: "js/bundle.js"
		},
		module: {
			rules: [
				{
					test: /\.js?$/,
					loader: "babel-loader",
					exclude: /node_modules/,
					options: {
						presets: ["react", "es2015"]
					}
				}
			]
		}
	};

Now you've saved the above to disk, I'll quickly explain what a few parts of this file means...

 * `entry` is where the main JavaScript file is located. If you end up with many JS files (which you definitely will do as your projects grow) then this will always be the main file in the project.
 * `output` is where the built JS file is created to. We specify the `path` and then the `filename`. Note how I've included "js/" in the filename, we'll get around to that later on.
 * `module` `rules` is where you can specify what rules will be applied to file extensions detected by the `test` regex. We `exclude` anything in the node_modules directory as this can cause problems with some packages.
 * `options` `presets` is where you can specify additional presets to the loader. We use it to instruct Babel to recognise React code and also to recognise ES2015/ES6 code.

Ok, so now you should have a directory structure like this:

	/
		node_modules/
			// all the node modules will sit in here //
		main.js
		webpack.config.js

The main.js and webpack.config.js files should have the content I provided above. Now you can run Webpack (use the command below) and let it build!

If you use Linux (and probably on a Mac too), you can do:

	node_modules/.bin/webpack

Else you'll be on Windows, so you would do:

	node_modules\.bin\webpack

This should run Webpack and give the following output on the command window:

	$ node_modules/.bin/webpack
	Hash: d03994fd25295637818e
	Version: webpack 2.2.1
	Time: 6014ms
	       Asset    Size  Chunks                    Chunk Names
	js/bundle.js  725 kB       0  [emitted]  [big]  main
	   [5] ./~/react-dom/lib/ReactDOMComponentTree.js 6.27 kB {0} [built]
	   [6] ./~/fbjs/lib/ExecutionEnvironment.js 1.06 kB {0} [built]
	   [8] ./~/react-dom/lib/ReactInstrumentation.js 601 bytes {0} [built]
	  [10] ./~/react-dom/lib/ReactUpdates.js 9.53 kB {0} [built]
	  [19] ./~/react/lib/React.js 2.69 kB {0} [built]
	  [79] ./~/react-dom/index.js 59 bytes {0} [built]
	  [80] ./~/react/react.js 56 bytes {0} [built]
	 [108] ./~/react-dom/lib/ReactDOM.js 5.14 kB {0} [built]
	 [168] ./~/react/lib/ReactChildren.js 6.19 kB {0} [built]
	 [169] ./~/react/lib/ReactClass.js 26.5 kB {0} [built]
	 [170] ./~/react/lib/ReactDOMFactories.js 5.53 kB {0} [built]
	 [171] ./~/react/lib/ReactPropTypes.js 15.8 kB {0} [built]
	 [172] ./~/react/lib/ReactPureComponent.js 1.32 kB {0} [built]
	 [173] ./~/react/lib/ReactVersion.js 350 bytes {0} [built]
	 [177] ./main.js 420 bytes {0} [built]
	    + 163 hidden modules

All going according to plan, we should now have a `dist` directory too:

	/
		dist/
			js/
				bundle.js
		node_modules/
			// all the node modules will sit in here //
		main.js
		webpack.config.js

The bundle.js file will contain the converted code as well as any dependencies from the React and ReactDOM packages too.

### So how do we use this JavaScript file in a webpage? ###

Now you have a .js file that your browser can understand, you can just reference it within your existing HTML file like this (we also create a `<div>` tag to use at runtime):

	<div id="example"></div>
	<script src="/js/bundle.js"></script>

If you're happy with this, then you can finish now. But if your React application will be the only thing on your website (and therefore you don't have a HTML file already), then you can create a HTML file during the webpack process using a plugin called [html-webpack-plugin](https://github.com/jantimon/html-webpack-plugin). I'll include this in my project now, so I need to get the html-webpack-plugin from npm:

	npm install --save-dev html-webpack-plugin

Update the `webpack.config.js` file as follows (changes are wrapped in comments for clarity):

	// ------ add the reference to the plugin
	var HtmlWebpackPlugin = require('html-webpack-plugin');
	// ------

	module.exports = {
		entry: "./main.js",
		output: {
			path: "dist",
			filename: "js/bundle.js"
		},
		module: {
			rules: [
				{
					test: /\.js?$/,
					loader: "babel-loader",
					exclude: /node_modules/,
					options: {
						presets: ["react", "es2015"]
					}
				}
			]
		}

		// ------and add it as a plugin
		,
		plugins: [new HtmlWebpackPlugin()]
		// ------
	};

Running webpack again causes an index.html file to be created in your `dist` directory. But hang on a minute... it doesn't actually work if I run it. This is because your React code in `main.js` is looking to create your component in a predefined `<div>` and the generated HTML file doesn't contain it. We fix that by creating a template which the plugin will use to build the HTML file:

	<!DOCTYPE html>
	<html>
		<head>
			<meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
			<title>React Tutorial for jonifen.co.uk</title>
		</head>
		<body>
			<div id="example">
			</div>
		</body>
	</html>

And then editing our `webpack.config.js` file again (I've only included the `plugins` section for clarity, you just replace your existing `plugins` section with that below):

	plugins: [
		new HtmlWebpackPlugin(
			{
				filename: 'index.html',
				template: 'index.ejs'
			}
		)
	]

And now we run Webpack again. It should create the files again but on this occasion, opening the `dist/index.html` file in your browser should show the "Hello World!" message you were hoping for!

Enjoy!
