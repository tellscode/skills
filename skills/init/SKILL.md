---
name: init
description: Use when initializing a new git repository and creating the first
  commit. Enforces the user's conventional-commit style.
---

# Initializing a Git Repository

Test for the existence of a repository by running
`git rev-parse --is-inside-work-tree`.
If a git repository does already exist, stop and ask the user if they want to
continue, otherwise:

run `git init` and `git branch -M main`

If the user mentions spoofing, faking, backdating, or customizing the commit
date, also load and work with the `spoof-commit-date` skill for the initial
commit.

run `git commit --allow-empty -m "init: initial commit"`

After this is done, ask the user if they want to add a remote repository, ask for GitHub user or org, repo name and if it should push to remote immediately.
Build the remote URL like `https://github.com/<user_or_org>/<repo>` and run `git remote add origin <remote_url>`.
The user may also provide a full URL or state the user / repo combo of another git hosting service. Use it or build the URL accordingly.
