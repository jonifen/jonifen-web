---
type: "blog"
title: "Retaining chmod permissions for scripts in git repositories"
date: 2019-05-01T20:44:36+01:00
author: "Jon"
tags: [
  "programming",
  "sourcecontrol"
]
---
Our continuous delivery setup at work requires that we use bash scripts for builds that can be handled by Linux machines.

The main issue is when we create a new project, we often get "Permission Denied" errors when the CI system runs the scripts on the build agents. Usually, you'd just run `chmod` on a machine and try again, but this doesn't work when the files are being pushed into a git repository, and then pulled at the other side.

To fix it, you'd run the following command:

```
git update-index --chmod=+x your_bash_script.sh
```

Commit and push the changes into the remote repo and the next time you run the pipeline, everything should be sorted.

Normally, this is something that could be easily remembered, but we create these new repos quite rarely, so I usually forget the full command by the next time :)

The git documentation provides more information on the `update-index` command here: https://www.git-scm.com/docs/git-update-index
