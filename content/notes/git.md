---
type: "note"
title: "Git (Source Control)"
---

## Retaining chmod permissions for scripts in git repositories

```
git update-index --chmod=+x your_bash_script.sh
```

The git documentation provides more information on the `update-index` command here: https://www.git-scm.com/docs/git-update-index

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

## Revert a range of commits

```
git revert {oldest_commit}^..{newest_commit}

i.e.

git revert abcdef01^..abcdef09
```
