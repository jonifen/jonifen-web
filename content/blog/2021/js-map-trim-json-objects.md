---
title: "Reduce a large JSON object down to only what you need"
description: "Sometimes you need to use an API that returns a large payload, but you may only need to use a small number of fields from that payload. Rather than try storing that data, or hand-balling the data yourself, there is an alternative solution."
date: "2021-03-18T21:59:32+01:00"
author: "Jon"
tags: [
  "programming",
  "javascript",
  "json",
  "web"
]
type: "blog"
---

Sometimes you need to use an API that returns a large payload, but you may only need to use a small number of fields from that payload. Rather than try storing that data, or hand-balling the data yourself, there is an alternative solution.

In various other languages, such as C#, you can serialise and deserialise data and strip out what data you don't want (by not declaring those properties in the models). This post explains how you can achieve the same thing in JavaScript with a little help from a pre-defined model, and some recursion:

```js
const mapToModel = (item, model) => {
  return Object.keys(model).reduce((acc, key) => {
    if (typeof item[key] !== "object") {
      acc[key] = item[key];
    } else {
      acc[key] = mapToModel(item[key], model[key]);
    }
    return acc;
  });
};
```

So in the above code, you have a function that will do the leg work of iterating over a pre-defined model and building a new object containing only those properties, populated with the matching property data stored in `input`.

So what would our model look like?

```js
const exampleModel = {
  name: "",
  age: "",
  address: {
    street: "",
    town: "",
    postCode: ""
  }
};
```

So we now know that all we need out of a payload is the properties specified in the example model above, so let's take a look at our example payload:

```js
const exampleData = {
  name: "Bob Smith",
  age: "28",
  gender: "Prefer not to say",
  address: {
    street: "1 Random Street",
    lineTwo: "",
    town: "Randopolis",
    county: "",
    postCode: "RA12 8QA",
    country: "Randomia"
  },
  phone: {
    mobile: "07123456789",
    home: "01234567890"
  },
  emailAddress: "bob.smith@randopolis-mail.com"
};
```

When we call the aforementioned function, providing our data and our model, we get the output with only the properties we want:

```js
const requiredData = mapToModel(exampleData, exampleModel);
```

And all should be working fine, and we get the following output:

```js
{
  name: "Bob Smith",
  age: "28",
  address: {
    street: "1 Random Street",
    town: "Randopolis",
    postCode: "RA12 8QA"
  }
};
```

Great!

### So this will work for _every_ scenario won't it?

I'm afraid not, this is just a basic example of how you can achieve what you want. This works great if you have (at most) a nested object similar to my example above. If you have arrays etc, things can get messy so you'd need to look into that further. But this is a good starting point that solves most scenarios.
