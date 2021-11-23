---
type: "blog"
title: "Storybook JS: 'Cannot GET /'"
description: "When you run storybook locally, you might encounter the error 'Cannot GET /' when browsing to localhost:6006."
date: "2021-11-23T17:30:10Z"
author: "Jon"
tags: ["programming", "web", "javascript", "storybook", "react"]
---
When you run storybook locally, you might encounter the error 'Cannot GET /' when browsing to localhost:6006.

The general advice given online is to delete all node modules for your project and re-install the packages using your preferred package manager. However, this doesn't always solve the problem and I was in this position just a moment ago.

Luckily, in the [Storybook CLI docs](https://storybook.js.org/docs/react/api/cli-options), there is an argument `--no-manager-cache` which says that it will disable the Storybook manager caching mechanism. They recommend not using this every time you run it, but it'll help when you need to refresh the Storybook UI, such as when editing themes etc.

I was able to run it with the following command:

```bash
yarn storybook -- --no-manager-cache
```

And Storybook was working again! I only need to add this argument on the CLI command one time to clear the cache. Hope this helps anyone else in the same situation.
