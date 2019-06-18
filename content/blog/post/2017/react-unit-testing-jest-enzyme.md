---
date: "2017-12-07T22:34:37Z"
title: "React.js Unit Testing with Jest and Enzyme"
type: "post"
author: "Jon"
description: "I've written loads of unit tests in my lifetime for C# and JavaScript, but never gotten around to writing any for testing the actual React components because there's always been something more pressing. Time to put that right and take the plunge."
tags: [
    "programming",
    "javascript",
    "reactjs",
    "testing"
]

---

I've written loads of unit tests in my lifetime for C# and JavaScript, but never gotten around to writing any for testing the actual React components because there's always been something more pressing. Time to put that right and take the plunge.

So I've picked up the project which resulted from the [React.js Continued... State!](/blog/post/2017/reactjsstate/) tutorial as a starter for ten as it already has a lot of the boilerplate stuff in place.

I need to point out at this point that I've updated the npm packages so I'm using React 16 as well as the latest versions of other things:
 * babel-preset-es2015 has been deprecated and replaced with babel-preset-env so I've made the following change to the webpack.config.js in the rule I created for .js files:

    options: {
        presets: ["react", "env"]
    }

So now that's done, I need to install the required packages:

    npm install --save-dev jest enzyme enzyme-adapter-react-16

These packages are for [Jest](https://facebook.github.io/jest/), [Enzyme](https://github.com/airbnb/enzyme) and the Adapter so Enzyme can support React 16 - notice that I mentioned I upgraded the npm packages earlier? ;)

As Jest and Enzyme don't use Webpack to get the Babel options, I have to create a .babelrc file in the root of the project folder, which will contain the following:

    {
        "presets": ["react", "env"]
    }

to enable support for React and the "env" plugin (that superceded the es2015 plugin).

So with all that set up, let's create our first test!

Create a directory in the project root called "\_\_tests\_\_" (yes, this is a double underscore before and after) and inside there, create a new file called "comments.js" and inside there, dump the following content:

    import React from "react"
    import Enzyme from "enzyme"
    import Adapter from "enzyme-adapter-react-16"
    import { mount } from "enzyme"
    import Comments from "./../components/comments.jsx"

    Enzyme.configure({ adapter: new Adapter() })

    describe("Comments", () => {
        const props

        beforeEach(() => {
            props = {
                heading: "Previous comments:"
            }
        })

        //--- All tests go below this line ---
        it("always renders a div", () => {
            const divs = mount(<Comments {...props} />).find("div")
            expect(divs.length).toBeGreaterThan(0)
        })
    })

Ok, so let me explain a little about what this is trying to do.

 * You've got the normal imports at the top which are bringing in the bits and pieces that are needed within the rest of the code
 * We have to configure Enzyme to use the adapter for React 16
 * We now instruct Jest that we're about to be describing the Comments component and create an arrow function for the tests to reside.
 * We create a "beforeEach" function which will run before each and every test within the container.
 * We then declare a test, that we expect the Comments component to contain at least one div element within it (yes, it's a really simple test, but we have to start somewhere... right?)

I'll be spending a bit more time over the next couple of weeks looking at unit testing React components so may update this post if I find a better way of doing things.
