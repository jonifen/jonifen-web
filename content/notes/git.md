---
type: "note"
title: "Git (Source Control)"
description: "Some things I've done in Git which I'd like to keep for future reference"
---

## Retaining chmod permissions for scripts in git repositories

```
git update-index --chmod=+x your_bash_script.sh
```

The git documentation provides more information on the `update-index` command here: https://www.git-scm.com/docs/git-update-index

-----

## Clone repository including all submodules

Get the latest commit in the parent repository:

```
git clone {repository_url}
cd {repository_dir}
# -- OR --
git pull
```

And then update the submodule:

```
git submodule update --init --recursive
```

This should pull the relevant commit for the submodule, but it will be in detached HEAD mode based on the commit of the submodule reference in the parent repository.

-----

## Revert without commit

A standard `git revert` will create a new commit with the reverted content. To revert without creating that commit:

```
git revert {commit-id} --no-commit
```

The changes will be staged ready for committing, but a `git reset` will unstage the changes, so you can continue making changes.

_What about merges?_

You'd need to provide further commands to do this, as follows:

```
git revert -m 1 {commit-id} --no-commit
```

The `-m` identifies that it's a merge commit that you're reverting, and the number `1` indicates that you want to revert back to the tree of the first parent prior to the merge.

-----

## Revert a range of commits

```
git revert {oldest_commit}^..{newest_commit}

i.e.

git revert abcdef01^..abcdef09
```

-----
