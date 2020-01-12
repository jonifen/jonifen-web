---
type: "blog"
title: "React.js Continued... State!"
author: "Jon"
description: "This time I'll be looking at State. What it is and how to use it..."
tags: [
  "programming",
  "javascript",
	"reactjs"
]
date: "2017-02-14T22:13:37Z"

---

This time I'll be looking at State. What it is and how to use it... Like last time, we'll be continuing with the code from the [previous post](/blog/post/2017/reactjscontinued/).

Last time we created 2 components, `home` (which was a stateful component) and `header` (which was a stateless component). This time we're going to handle state within the `home` component by calling an API. As in previous posts, I'll be using the UK Police API as it doesn't require any authentication (or at least it doesn't at the moment, that could change!) which cuts down on fluff.

We'll open the `home.js` file and amend it as follows:

	import React from 'react';
	import Header from '../components/header';

	export default class Home extends React.Component {
		constructor() {
			super();
			this.state = {
				results: []
			};
		}

		componentWillMount() {
			var xhr = new XMLHttpRequest();
			var component = this;
			xhr.open("GET", "https://data.police.uk/api/stops-street?lat=53.4848179&lng=-2.2437719&date=2015-05");
			xhr.onload = function() {
				component.setState({ results: xhr.response });
			};
			xhr.send();
		}

		render() {
			return(
				<div>
					<Header HeaderText="This is your header speaking!" />
					<div>
						Number of records returned from the API: {this.state.results.length}
					</div>
				</div>
			);
		}
	}

To start with, there's more code this time. Let me explain things a little:

 * In the constructor (`constructor()`), we're setting the value of `this.state` to an object that contains an empty array (`results`).
 * We have a new function in the class: `componentWillMount()`. React has many "lifecycle methods" and this is one of them. In particular, this function will be run when the component is _about to_ mount (i.e. come to life on the page). In our example, we will be calling the Police API for some data and storing it in the `results` array in state.
 * In the `render()` function, we removed the Hello message but added a new `<div>` that contains some text and then includes the output of the length of the `results` array (that we've got contained in state).

Save your file and run webpack to re-generate the files. Open it up in your browser and you should get the following:

	This is your header speaking!
	Number of records returned from the API: 26102

So now you've used `state` in your React app. It is as simple as that! However, there are some things to be aware of:

 * You can't set state in the `render()` function, only read from it.
 * You get and set state using `this` which is the keyword to access the component/function you're currently in. In the example above, you see we use `component.setState(...)` within the `xhr.onload` function. This is because `this` within the function is a different `this` to the one we expect it to be, so an exception would be thrown in the browser. We get around it by creating a variable (in our case "component") which is available within the `xhr.onload` function as it's declared in the same level of scope.

Let's look at state a different way. What if we have some form controls on our page like a comments section on a website?

We need a new component then. Add `comments.js` to your `components` directory with the following code:

	import React from 'react';

	export default class Comments extends React.Component {
		constructor() {
			super();
			this.state = {
				comments: [],
				currentComment: ""
			};
		}

		onFormChange(event) {
			this.setState({ currentComment: event.target.value });
		}

		addComment() {
			this.state.comments.push({
				date: new Date().toLocaleDateString(),
				comment: this.state.currentComment
			});
			this.setState({ currentComment: "" });
		}

		render() {
			return(
				<div>
					<hr />
					Enter your comment here:<br />
					<input type="textarea" onChange={this.onFormChange.bind(this)} value={this.state.currentComment} />
					<button onClick={this.addComment.bind(this)}>Add Comment</button>
					<br />
					Previous comments:<br />
					{
						this.state.comments.map(function(comment, i) {
							return(
								<div key={i}>
									Posted on {comment.date}<br/>
									{comment.comment}<br />
									-----
								</div>
							);
						})
					}
				</div>
			);
		}
	}

Woah, more code in this one isn't there? As always, I'll explain a few bits...

 * We import React (as always), and create a new class that is made public (so it can be imported in other class files).
 * We set initial values in state within the constructor.
 * We've created 2 functions (`onFormChange` and `addComment`) which have fairly self-explanatory names...
 * We're rendering a mini form containing a textarea to enter a comment and a button to submit it. We then render any comments added below.

So when we view this page, we expect that as a user enters text into the comment box, the `onFormChange()` function will run on every textbox change and will update the value of `currentComment` in state. Once the user clicks the button to submit the comment, the `addComment()` function will run which takes the `currentComment` from `state` and adds a new object into the comments array with the typed comment and the current date. It then empties `currentComment` which clears the textbox too.

Inside the `render()` function, where we display previous comments, we use the `map` function (available in arrays) to iterate through each item and then return some markup to be rendered in the page.

Ok, now we need to consume this component, so let's import it to our `home.js` file:

	import Comments from '../components/comments';

and now let's render it (I've included the whole `render()` function from `home.js` to make it easier):

	render() {
		return(
			<div>
				<Header HeaderText="This is your header speaking!" />
				<div>
					Number of records returned from the API: {this.state.results.length}
				</div>
				<Comments />
			</div>
		);
	}

So now we've used state to hold data retrieved from an API, and we've used it to hold data which is manipulated during the lifetime of the component.

As always, questions/comments are welcomed on [Twitter](https://twitter.com/jonifen) or [one of my other contact options](/contact).
