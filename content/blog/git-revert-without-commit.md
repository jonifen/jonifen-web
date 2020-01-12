---
type: "blog"
title: "Git reverts without automatic commit"
description: "If you have multiple commits that you want to revert but keep things concise under a single commit, this could be the answer you're looking for."
date: 2019-05-23T21:52:44+01:00
author: "Jon"
tags: ["programming", "sourcecontrol", "git"]
---
Git is easily the best source control system I've ever used, yet it's probably one of the more infuriating too because its power and flexibility can also land the users in a whole world of pain.

Today at work we had a scenario where a colleague needed to revert a handful of commits including a merge but there was a chance it may need re-introducing at a later date. I suggested reverting each commit with `--no-commit` but nobody else had heard of this argument before, hence I felt a post may be useful (although this probably requires that people visit my blog first to find it haha).

Ok, so normally, you can perform a revert by doing the following:

```
git revert {commit-id}
```

but although this _does_ perform the revert, it also creates a new commit. So what if you wanted to make any amendments to the contents before making this new commit?

Well, you could just add a further commit, but if you wanted to keep things tidier, you could perform the revert as follows:

```
git revert {commit-id} --no-commit
```

This will leave the commit content reverted, and staged, but without a commit. So if you want to make changes at this point, you just do:

```
git reset
```

which will unstage your files ready for changes. You can then commit as you wish.

### But you said your colleague had _many_ commits to revert?

You just revert all the commits that you need reverted, remembering to add `--no-commit` on each command. You can then reset and create your new single commit which can then be easily reverted in the future if you want things back in place.

### Ok, so you mentioned something about merges?

You'd need to provide further commands to do this, as follows:

```
git revert -m 1 {commit-id} --no-commit
```

The `-m` identifies that it's a merge commit that you're reverting, and the number `1` indicates that you want to revert back to the tree of the first parent prior to the merge.

Any questions? [Get in touch](/contact).

And when it comes to git, be careful everyone!
