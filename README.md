# jonifen-web

This is the repository for my rather basic personal blog/website which is hosted in Github Pages via my own domain https://jonifen.co.uk/

## Deploying changes

I have set up an npm script `npm run deploy` which will run the `deploy.sh` script in the root of the repository to build the site and push the public/ directory (configured as a submodule as per Github's documentation) to the other repository.

### Gotchas

When cloning the repo, I have to do so as the following to ensure the submodule is fetched too:

```bash
git clone --recurse-submodules {REPO_PATH}
```

If the submodule is not set up, the deploy script will not be successful.

