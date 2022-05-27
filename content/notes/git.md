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

**Alternatively**, when doing the initial clone of the repository, you can do the following:

```
git clone --recursive {repository_url}
```

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

You can also flag it such that it won't automatically commit the revert too using the `--no-commit` or `-n` switch.

-----

## Git Bash command line prompt

This is my current custom and basic prompt in Git Bash on Windows which I add to my `~/.bashrc` file:

```bash
source /c/Program\ Files/Git/mingw64/share/git/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n\[\e[32m\]\w \[\e[91m\]$(__git_ps1 "(%s)")\[\e[00m\]\$ '
```

This results in the following (the examples are without colour):

```bash
# Non-git directory
/c/directory $

# Git directory
/c/directory (main)$
```

-----

## My git aliases

These are located in my `~/.gitconfig` file.

```
[alias]
	lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative
	lga = lg --all
	st = status -sb
	stat = log -1 --stat
```

-----