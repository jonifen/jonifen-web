---
type: "blog"
title: "Revert a range of commits in a Git repository"
description: "Have you ever had one of those days when you've been hard at work on a repository, making small and regular commits to the repository during the day only to decide that it wasn't the way you wanted to go..."
date: 2019-06-21T21:27:47+01:00
author: "Jon"
tags: ["programming", "sourcecontrol", "git"]
---
Have you ever had one of those days when you've been hard at work on a repository, making small and regular commits to the repository during the day only to decide that it wasn't the way you wanted to go? So how do you get back to where you were at the beginning of the day?

Well, you could just revert each commit one-by-one, but what if your commit history is like this? (disclaimer: all commit messages are just junk for the sake of this example. I mean, who would commit a repo with failing tests? ahem!)

```
abcdef09 fix typo in copy displayed to user
abcdef08 make tests pass
abcdef07 add tests for yet another feature
abcdef06 update config with correct api url
abcdef05 add infrastructure changes to support new feature
abcdef04 make next test pass
abcdef03 add next feature test
abcdef02 make the test pass
abcdef01 add test for new feature (first commit of the day!)
abcdef00 last commit of yesterday - everything works a dream here!
```

So, as mentioned before, you could go down the path of [one of my previous posts](/blog/post/2019/git-revert-without-commit/) by reverting each commit with `--no-commit` and then push all the reverts in one go, but I found out today, that Git has got a feature for this exact purpose!

```
git revert {oldest_commit}^..{newest_commit}

i.e.

git revert abcdef01^..abcdef09
```

So this command works on the basis of specifying a range of commits, so it'll revert all commits between the two hashes.

Ah, but what if a colleague has committed something (unrelated to your work in progress) in the middle? Well, you'd have to get creative here and revert them in 2 ranges (either side of your colleague's commit). Unless anyone else has a better idea?

Please get in touch if there is a better way! Alternatively, you could offer it up as a pull request on [my blog repository](https://github.com/jonifen/jonifen-web/). I'll always give credit where it's due.
