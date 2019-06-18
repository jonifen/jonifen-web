---
author: "Jon"
date: "2015-11-12T20:34:00Z"
description: "We had a requirement at work to display some tabular data that is retrieved from a web service as a JSON object. As we have recently started using React, it made sense to find a decent component that suited what we needed and after a bit of browsing, we found Griddle."
tags: ["programming", "javascript", "reactjs", "griddle"]
title: "Griddle - A Grid/Table Component for React"
type: "post"

---

We had a requirement at work to display some tabular data that is retrieved from a web service as a JSON object. As we have recently started using React, it made sense to find a decent component that suited what we needed and after a bit of browsing, we found Griddle.

Unfortunately, their documentation; while it wasn't bad, it's not the best I've seen so I thought I'd throw something together to show how to get it working quickly and using a publicly available API, so anyone should be able to follow.

First of all, you need to install the usual React suspects:

	$ npm install --save react react-dom

And you also need to install Griddle, and Underscore.js (a pre-requisite of Griddle). I've also installed jquery to make the API call quicker:

	$ npm install --save underscore griddle-react jquery

And now we can start!

I've used the UK Police Data API (as it currently doesn't require any authentication, which removes faff), and I've picked an area in Manchester as the location to check for data at.

I created an index.html file and added references to the javascript files needed (I've referenced a CDN hosted version of babel-core to do the auto-translation):

	<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script>
	<script src="/node_modules/react/dist/react.js"></script>
	<script src="/node_modules/react-dom/dist/react-dom.js"></script>
	<script src="/node_modules/underscore/underscore.js"></script>
	<script src="/node_modules/griddle-react/build/griddle.js"></script>

So now we need to make an ajax call to the API to get the data, so we'll create a function for that. As we've included a reference to babel-core, we can do this in the page like so:

	<script type="text/babel">
	    var apiResults = function() {
	        var json = null;

	        $.ajax({
	            url: "https://data.police.uk/api/stops-street?lat=53.4848179&lng=-2.2437719&date=2015-05",
	            dataType: 'json',
	            async: false,
	            data: null,
	            success: function(data) {
	                json = data;
	            }
	        });

	        return json;
	    };
	</script>

Note: we needed the function to block the processing thread, so the page would wait for the API call to complete. It's a bit sweaty (as it locks the page from doing anything while we wait for the API to return), but to suit the easiness of this post, I've done it by setting async to false in the ajax call as per this StackOverflow thread.

Ok, so now we'll have data. Let's make the component that builds up the Griddle table.

In the `<script>` tag, add the following code (below the apiResults function):

	var ExampleGrid = React.createClass({
		render: function() {
			return (
				<Griddle results={this.props.theData} />
			);
		}
	});

	ReactDOM.render(<ExampleGrid theData={apiResults()} />, document.getElementById("example"));

And finally, add a div placeholder:

	<div id="example"></div>

And we run the page, and we should get a populated table! Oh... it looks squashed though, like there's too many columns. We can cherry-pick the columns (I picked "datetime", "type" and "self_defined_ethnicity" - mainly because these returned data for every record!) by changing the Griddle tag as follows:

	<Griddle results={this.props.theData} columns={["datetime", "type", "self_defined_ethnicity" ]} />

and reload the page and voila! The 3 columns should be displayed with the data in.

Having problems? Drop us a tweet on Twitter, or take a glance at the Griddle documentation (hopefully the above mini-tutorial has given you a rough understanding).
