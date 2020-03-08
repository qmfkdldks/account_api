# AccountApi

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/058c8c6a3a4249799af847373a49c55e)](https://app.codacy.com/manual/qmfkdldks/account_api?utm_source=github.com&utm_medium=referral&utm_content=qmfkdldks/account_api&utm_campaign=Badge_Grade_Dashboard)

[![Coverage Status](https://coveralls.io/repos/github/qmfkdldks/account_api/badge.svg?branch=master)](https://coveralls.io/github/qmfkdldks/account_api?branch=master)

[![Codefresh build status](https://g.codefresh.io/api/badges/pipeline/visible/default%2FAccount?key=eyJhbGciOiJIUzI1NiJ9.NWU2MTdmMjQwYjcyZjBhZjBhYTI4MjQ3.GXWvqh4ZABuWihE44pULZiBVgVBc8vyYGLhOhBVOzLg&type=cf-1)](https%3A%2F%2Fg.codefresh.io%2Fpipelines%2FAccount%2Fbuilds%3Ffilter%3Dtrigger%3Abuild~Build%3Bpipeline%3A5e617fdad7e4d05db0a8fb63~Account)

Account service

# Objective

# Routes

- /sign_in authenticate given username and password
- /sign_up create new account
- Protected
  - update user data
  - reset new password

# Dev

## Test and Coverage

Github Actions test pipeline report test coverage to [coveralls](https://coveralls.io/). Run `mix coveralls` to improve test quality. [Excoverall](https://github.com/parroty/excoveralls)

## Lint

[codacy](https://codacy.com) is configured at pull request level. And Codacy uses [credo](https://github.com/rrrene/credo/) linter.
Please, before commiting to pull request. Run `mix credo` and solve code quality issue.

# Pipeline

1. Github Action: Run test and generate coverage report
2. Codefresh: Build and push image and manually test [feature branch](https://codefresh.io/docs/docs/getting-started/on-demand-environments/) using `dev.Dockerfile` with seed data.
3. GKE pull image and delivery new feature
