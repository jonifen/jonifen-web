---
type: "blog"
title: "Basic Setup for React Projects 2020"
description: ""
date: 2020-12-26T11:26:44Z
author: "Jon"
tags: ["programming", "javascript"]
---

I've seen a lot of people using project initialisation tools to create their new React projects over the years, in particular `create-react-app`. While I do see there are some benefits to these tools (in particular for newcomers), these tools do have their disadvantages.

I cloned a repository the other day which was using create-react-app, and an `npm i` installed over 2000 packages! This is a hell of a lot to download just to be able to run some code locally. Yes, these packages will be cached, but if you take into account the time it takes for one dev, multiply that across a team of devs (also accounting for devs trashing their local repos and re-cloning), this could be a reasonable bit of time lost. This time is often lost at times where developers are feeling most productive too.

I've been using React for many years now, and I've ended up with a few things that I always use in my base project setup. This post is to share those things with you, and try to explain a few of the things along the way.

We're going to start from complete scratch here, you should be able to modify in accordance to your current position in the journey though.

## Create the directory

```bash
mkdir new-project
cd new-project
```

## Create the base package.json file

```bash
npm init -y
```

## Install the required packages

```bash
npm i -S react react-dom
npm i -SD webpack webpack-cli webpack-dev-server copy-webpack-plugin @babel/core @babel/preset-env @babel/preset-react babel-loader jest @testing-library/react
```

Something to note: `npm i -S` is shorthand for `npm install --save`. Likewise, `npm i -SD` is shorthand for `npm install --save-dev`.

### So what are these packages, and why do I install them how I do?

`react` and `react-dom` are required at runtime, hence they are installed as `dependencies`. However, everything else is used as part of a developer's journey (i.e. testing, building, transpiling etc.) hence they are `devDependencies`. If you open your package.json file _after_ the npm install steps are completed, you will see those packages are split up into those named sections of the config.

### What are these packages then?

React probably needs no introduction, you've probably done your own reading on this before deciding to read this blog post! But `react-dom` is the library that performs the actual render stage of your JavaScript code that uses the `react` library.

Anything referring to webpack, in particular the `webpack` and `webpack-cli`, are what orchestrates the building/transpiling of your code into a bundle that can be deployed/hosted for users to consume. `webpack-dev-server` is a local server which supports hot-reloading, and is an extremely useful tool for developers, as it causes the page to be refreshed after the code is changed in your preferred editor. `copy-webpack-plugin` is just a plugin that supports the copying of files from elsewhere into your build directory. Webpack has its own config file, but we'll look at that later.

`babel-loader` is a plugin that is used by webpack, and this essentially orchestrates the `@babel/core` package and any presets that are referenced (in our case, `@babel/preset-env` which offers ES6+ support and `@babel/preset-react` which supports React and JSX syntax).

Finally, `jest` is a testing library that is created by the same team that created React. It is very simple to Mocha or Jasmine (if you've used those before), and it's quite easy to work with. However, it does require some extras to test React components better, and that's the job of `@testing-library/react`.

So let's get Webpack configured!

## Webpack config

Webpack is an orchestration tool that runs the steps that we specify in a config file, and provides us with an output which is typically deployable to an environment for consumption by end users.

Webpack's config should be placed in the root of your project (next to your package.json) and should be named `webpack.config.js`.

```js
var CopyWebpackPlugin = require("copy-webpack-plugin");
var path = require("path");

module.exports = {
  entry: "./src/app.js",
  output: {
    path: path.resolve(__dirname, "./dist"),
    filename: "js/todo-app.js"
  },
  module: {
    rules: [
      {
        test: /(\.js$|\.jsx$)/,
        loader: "babel-loader",
        exclude: /node_modules/,
      }
    ],
  },
  plugins: [
    new CopyWebpackPlugin({
      patterns: [
        { from: "./public" }
      ]
    })
  ],
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    compress: true,
    port: 9000
  }
};
```

So you will notice first of all that it uses `require()` rather than `import` syntax, and this is because webpack still uses ES5 syntax. Something to bear in mind when you start making changes in the future.

| property | description |
|----------|-------------|
| entry | This is the relative path to your "main" JS file (i.e. the base file which starts your whole project). |
| output.path | This is the directory where the output will be placed. This path is used by any webpack plugins etc. too. |
| output.filename | This is where the JavaScript bundle will be stored, with everything bundled into one file |
| module.rules | This is an array of objects which specifies any loaders which will be used by webpack in the build process. You can see we are using `babel-loader` for any files with the `.js` or `*.jsx` extensions. |
| plugins | This is an array of plugin references. There are loads of plugins available, and you can even create your own if you need to! We're just using the `copy-webpack-plugin` package. We only specify the "from" path though, as by default it will copy it all into the output.path specified already. |
| devServer | This is an object that configures the `webpack-dev-server`, so we can specify what port it's using etc. |

If you want to read a bit more about these properties, the webpack documentation is very good, and can be found here: https://webpack.js.org/concepts/.

## Set up npm scripts

NPM scripts are commands that can be run in the context of the project's "environment", and can be started by typing `npm run {script_name}` at your choice of prompt. Let's look at the basics that I use:

```js 
  "scripts": {
    "build": "webpack --mode production",
    "dev": "set NODE_ENV=development&& webpack serve",
    "start": "webpack serve",
    "test": "jest"
  },
```

To explain the scripts above:

| script name | description |
| build | This one should be what creates your production build, and should be run by any CI/CD system if you go that route |
| dev | This one is a developer specific script that will set the Node environment to `development` and serves the content via webpack (i.e. using webpack-dev-server). Once it's up and running, you will be able to browse to the URL specified in your prompt window. |
| start | This just serves the content through webpack using the default settings |
| test | This will run any tests via `jest` |

### While we're here...

We should update the main script path in our package.json, so update it to the same path that you set in your webpack.config.js earlier.

## "Tweaks" for Jest

We will undoubtedly find that Jest isn't a fan of ES6 syntax if we run `npm test` at this stage. This is because we need to configure things so that it can use the relevant babel preset (in particular `@babel/preset-env`).

Create a new file in the root of your project called `.babelrc` and paste the following content into it:

```js
{
  "presets": [
    "@babel/preset-react",
    "@babel/preset-env"
  ]
}
```

This will configure Babel to support both React/JSX syntax and also any ES6+ specific syntax too, which allows Jest to test this code too.

## .gitignore (optional)

If you choose to use Git as your source control, you should create a `.gitignore` file so that it doesn't try to include any node modules or any build artifacts (i.e. anything created by webpack etc.) in our commits. To do this, create a new file in the root of the project called `.gitignore` and paste the following into it:

```
node_modules/
dist/
```

The first line is just to ignore the node modules directory (where `npm i` stores all of the packages that it fetches), and the second line is what was specified in the `output.path` property in the `webpack.config.js` file, so if you changed that, you should change this to match.

## Final notes

You should be ready to go at this stage! You should notice that things install a lot quicker on fresh machines, and hopefully you have more knowledge of the surrounding parts of the whole build process. You will be able to make adjustments to your configuration as you go, and this can become your "base" setup for future projects too!

Any questions? Give me a shout on the contact methods below. Alternatively, have I missed anything? Please consider raising a PR!