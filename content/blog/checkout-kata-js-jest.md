---
type: "blog"
description: "I've always been of the opinion that Code Katas are useful for pushing you to think of ways of solving common problems. They could make you (as the developer) look at things very differently to the way you would normally tackle things in your day to day job, because Katas are an opportunity to try something new, and I will usually aim to tackle a Kata using a different way every time I work on it."
date: "2019-04-20T20:46:00Z"
title: "Checkout kata in JavaScript using Jest"
author: "Jon"
tags: [
  "programming",
  "testing",
  "jest"
]
draft: "true"
---

I've always been of the opinion that Code Katas are useful for pushing you to think of ways of solving common problems. They could make you (as the developer) look at things very differently to the way you would normally tackle things in your day to day job, because Katas are an opportunity to try something new, and I will usually aim to tackle a Kata using a different way every time I work on it.

Because we've made a shift to using Jest as our preferred JavaScript testing mechanism at work, I thought it would be worthwhile me revisiting some old Katas so I could get a bit of extra practice in, but also so I could write a blog post about it, as I've been a bit slow updating things as of late (I'm hoping to write a further post giving some insight into why I've been so quiet, but I digress...)

For the sake of this post though, I'll look at the well-known Checkout Kata. You may have come across this before, possibly at a job interview. I first saw the Checkout problem on Dave Thomas' ([Code Kata](http://codekata.com/kata/kata09-back-to-the-checkout/)) website, but it may not be a Dave Thomas original.

The details of the Kata are on the link above, but for the sake of completeness, I'll recap here. We have 4 products, which we will call `A`, `B`, `C` and `D` and they are priced as follows:

|  Product  |  Price  |  Special Offer  |
|-----------|---------|-----------------|
|  A  |  50  |  3 for 130  |
|  B  |  30  |  2 for 45  |
|  C  |  20  ||
|  D  |  15  ||

So the products above all have an individual price, but products `A` and `B` also have special offers to be applied to them, but we'll get to that in a bit. For starters, let's just get things set up and working.

A while back, I created an archetype project on Github which would get me up and running fast using Jest with Babel and Webpack, so I'll start by cloning that. If you're following along, get into your usual source code directory, and let's go...

```
git clone https://github.com/jonifen/archetype-vanilla-js-es6-jest checkout-kata-jest
cd checkout-kata-jest
npm i
```

Now once all that is complete, you can test that things are working correctly:

```
npm test
```

All going well, you should get the following output:

```
 PASS  __tests__/index.spec.js
  Dummy tests
    √ expect true to be true (6ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        3.188s
Ran all test suites.
```

Now I know that my dummy test works, I know that my testing setup is working properly, so I'll move on.

Let's start with product `A`. I expect that scanning 1x `A` will give me a checkout total of 50. So we'll start with this.

Go to `__tests__/index.spec.js` and remove the existing dummy test; replacing it with the following:

```
describe('Checkout', () => {
  it('Scanning 1x A will give checkout total of 50', () => {
    const checkout = new checkout();
    checkout.scan('A');
    expect(checkout.total).toEqual(50);
  });
});
```

and re-run with `npm test` which should result in the following:

```
 FAIL  __tests__/index.spec.js
  Checkout
    × Scanning 1x A will give checkout total of 50 (10ms)

  ● Checkout › Scanning 1x A will give checkout total of 50

    TypeError: checkout is not a constructor

      1 | describe('Checkout', () => {
      2 |   it('Scanning 1x A will give checkout total of 50', () => {
    > 3 |     const checkout = new checkout();
        |                      ^
      4 |     checkout.scan('A');
      5 |     expect(checkout.total).toEqual(50);
      6 |   });

      at Object.<anonymous> (__tests__/index.spec.js:3:22)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 1 total
Snapshots:   0 total
Time:        3.424s, estimated 4s
Ran all test suites.
npm ERR! Test failed.  See above for more details.
```

Which confirms that the test failed. D'oh! So let's get the test passing.

