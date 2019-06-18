---
type: "post"
title: "React.js Continued... Components!"
author: "Jon"
description: "It's time to continue on from my React.js Revisited post that I made a few days ago. This time we'll look at creating some components..."
tags: [
  "programming",
  "javascript",
	"reactjs"
]
date: "2017-02-13T22:36:58Z"

---

It's time to continue on from my [React.js Revisited](/blog/post/2017/reactjsrevisited) post that I made a few days ago. This time we'll look at creating some components...

So what exactly is a "Component" in the context of React.js? In my head, I visualise React.js a little like Web UI Lego. The idea is you build your web application in blocks which are then built in a way which suits you and your application. A component is therefore like your Lego brick. They can be the bigger 4x2 stud ones, or those tiny 1 stud ones that cripple you when you stand on it with bare feet at night :'(

If you followed along with my Revisited post, I hope you've kept the code safe as we're going to continue on from that point.

Our application is getting bigger now, so we should consider a directory structure to keep the source files in. I'm going to create a 'screens' directory to keep my page container components in, and a 'components' directory which will contain individual components that will sit within one or more screen(s). Which makes our directory structure like this (the dist and node_modules directories will be omitted from now on for clarity):

	/
		components/
		screens/
		index.ejs
		main.js
		package.json
		webpack.config.js

So we'll create a 'home.js' file within the screens directory:

	import React from 'react';

	export default class Home extends React.Component {
		render() {
			return(
				<div>
					Hello from the Home component!
				</div>
			);
		}
	}

So to quickly explain this... (as best as I can)

 * We import React as we'll be using it in the code, just like we did in the main.js file.
 * We create a class (courtesy of ES6) called Home, and set it to inherit from `React.Component` which basically makes our class become a React component. The `export default` syntax sets the class to be the default class exported by the file when imported (I guess it's similar to how you would make a class to be `public` in C# or Java).
 * Inside of the class we have our `render()` function from which we will "return" the markup which we want to be rendered in the browser.

Ok, so now we have our Home component, we need to consume it. So back to the `main.js` file we go!

We need to import our newly created Home component before we can use it. So we import it like we do with React, but as it's not a package, we have to provide a path to the `home.js` file which is relative to the `main.js` file. So looking back at the directory layout earlier, we will end up with something like this:

	import Home from './screens/home';

Which will go at the bottom of the imports at the top of the `main.js` page. Now we can use the Home component by amending our rendering as per the following:

	ReactDOM.render(
		<Home />,
		document.getElementById("example")
	);

You can see that we refer to React components using markup tags named after the component. Run webpack and load up the page in your browser. You should now see the message "Hello from the Home component!". If not, follow through the steps above to make sure you've not missed anything.

The type of component we created above is capable of holding `state` which is like a temporary memory which is resident for the lifetime of the component (i.e. while it's "active" in your browser). We don't hold state yet, but we will do later on. Now we're going to continue on and create a component which is not capable of holding `state`. These kinds of components are useful for "dumb" parts of the application.

Create a file called `header.js` within the 'components' directory and dump the following code into it:

	import React from 'react';

	const Header = (props) => {
		return(
			<div>{props.HeaderText}</div>
		);
	}

	export default Header;

Now we're starting to add a bit more "good stuff" to things. In the `<div>` tags, we have `{props.HeaderText}` - when we want to render the value of a variable to screen, we wrap it in curly braces. And we can see that we're passing `props` into the arrow function. But where does `props` come from? And how do we populate it?

We go back to the `home.js` file and update it as follows:

	import React from 'react';
	import Header from '../components/header';

	export default class Home extends React.Component {
		constructor() {
			super();
		}

		render() {
			return(
				<div>
					<Header HeaderText="This is your header speaking!" />
					Hello from the Home component!
				</div>
			);
		}
	}

So what's changed? We're importing the `Header` component that we just created (notice that we are using `../` to traverse directories to consume it from a sibling directory). And you can see we reference it in the `render()` function lower down, but we have specified an attribute as well called HeaderText which is a property (and one of those `props` that we referred to earlier) and is how we pass data etc. from a parent component into a child component.

So now when you run webpack and load up the page in your browser, you should see:

	This is your header speaking!
	Hello from the Home component!

So you now have the `Header` component rendering text which was passed into it as a property, but also the text inside the Home component too.

In my next React.js themed post, I'll look at `state` and explain how to use it.
