---
title: "Configuring NGINX to work with React Router"
description: "When using the `BrowserRouter` that's provided by React Router, you'll find that if you're navigating within the site to the various URLs, they will work. However if you bookmarked one of those URLs, or refreshed the browser on a URL, it will return a 404."
date: "2021-02-06T12:53:32+01:00"
author: "Jon"
tags: [
  "programming",
  "javascript",
  "nginx",
  "tech"
]
type: "blog"
---

When using the `BrowserRouter` that's provided by React Router, you'll find that if you're navigating within the site to the various URLs, they will work. However if you bookmarked one of those URLs, or refreshed the browser on a URL, it will return a 404.

If you're using Webpack's devserver, then you can get around it with a setting in the webpack.config.js file:

```bash
devServer: {
  // your other webserver settings
  historyApiFallback: true
}
```

This setting makes webpack aware of the historyApi that is used by React Router and essentially just redirects any unknown URLs back to the root.

So that covers the development side of things, but what about in production when it's hosted behind NGINX?

You would need to change your NGINX config as follows (obviously, your location may vary but if it does, make sure you configure the base URL in React Router accordingly!):

```bash
location / {
  root /usr/share/nginx/html;
  index index.html;
  try_files $uri $uri/ /index.html =404;
}
```
