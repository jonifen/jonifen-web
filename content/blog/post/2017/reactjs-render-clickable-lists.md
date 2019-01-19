+++
type = "post"
title = "Rendering an array of data as a clickable list using React.js"
author = "Jon"
description = "React.js is great for quickly rendering arrays of data in a tabular format, and there's loads of grid-like packages out there in npm, but sometimes you just need to hand-crank something yourself. Which is fine, until you want the row to be clickable..."
tags = [
  "programming",
  "javascript",
	"reactjs"
]
date = "2017-04-13T21:55:37+01:00"
+++

React.js is great for quickly rendering arrays of data in a tabular format, and there's loads of grid-like packages out there in npm, but sometimes you just need to hand-crank something yourself. Which is fine, until you want the row to be clickable...

So how would you usually render a page from an array of data? Well, I'd probably start with some form of iterating the array and building up the content that way. I'll explain how I'd go about doing this now.

So for the example, I have an array of objects containing some basic information:

	const dummyData = [
		{ id: 1, firstName: "Joe", surname: "Bloggs" },
		{ id: 2, firstName: "Jane", surname: "Doe" },
		{ id: 3, firstName: "Bob", surname: "Bobsson" },
		{ id: 4, firstName: "John", surname: "Smith" }
	]

And I want to create a list of the user information, with a link to perform an action based on the id value in the associated object. So let's begin!

We're going to work with the following assumptions:

 * this will be part of a new component that is being added to an existing React application.
 * the data (shown above) will be injected into the new component as a property.

We need a function that will contain the logic that will be called when a row is clicked. For this example, we'll just display an alert containing the id of the clicked item:

	doListItemAction(item) {
		alert(item.id)
	}

And now we need to build up the render function to iterate the array:

	render() {
		let component = this

		return(
			<div>
			{
				this.props.dummyData.map(function(item, i) {
					return(
						<div key={i}>
							<span onClick={component.doListItemAction.bind(this, item)}>{item.firstName} {item.surname}</span>
						</div>
					)
				})
			}
			</div>
		)
	}

So how does it work?

We include a code block into the main `<div>` tags, and in there, we iterate dummyData using the `map` function, and for each item inside the array, we return a div that contains a span which when clicked, will call the `doListItemAction` function, passing the item into it for processing.

Any questions? As always, give me a shout on Twitter @jonifen and I'll respond as soon as I can :)
