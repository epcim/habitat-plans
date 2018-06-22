
# K8s ecosystem Habitat plans


## Install / update plans

    Planfile

You will be asked whether to sync with remotes and whether to fetch all dependencies as well (by default only these specified
in the Planfile). Check more in `Planfile` env. variables.


## Develop plans

`Planfile` reference remote repos/origins as `git remotes` and sparse checkout them to git worktree branches under `.worktree`.

You may develop plans on a "master" branch as usual.

To provide pull-request to upstream, manually update worktree branch with the local change. (cherry-pick works)

### Customize

There is an .hook script in the main directory that may run your own tasks (change maintainer/origin etc)

### Push

To push all branches, use:

    git push --all origin

To commit all modified branches use:

    ./Planfile git-all status
    ./Planfile git-all add .
    ./Planfile git-all commit -m "Xyz"

    # push all local branches to origin
    git push --all origin


### Planfile usage

In general, the Planfile is reusable for any repo.

    # prereq
    apt-get install collordiff git direnv rsync

    # fetch plans
    ./Planfile
    git status
    git add .
    git commit -m "initial plans from upstream"

    # edit plans

    # fetch plans
    ./Planfile # will update remote plans and diff local vs. upstream changes


## Build

To build a plan locally (eg. Redis) run:
```
$ hab pkg build redis
```

You can also build from within the context of the `hab studio` (a shell environment for quickly iterating plans).

```
$ hab studio enter
[1][default:/src:0]# build redis
```

### Via pipeline

Instead of building and exporting the images manually you can also use the concourse.ci habitat-plan pipeline.

    #TBD, inspiration:
    #
    # * https://forums.habitat.sh/t/habitat-core-plans-ci/424
    # * https://github.com/habitat-sh/core-plans/tree/master/ci
    # * https://github.com/starkandwayne/habitat-plans/tree/master/ci
    # * https://github.com/eeyun/ci-hab-test/tree/master/ci
    # * https://github.com/eeyun/hab-ci/tree/master/ci
    # * https://ci.starkandwayne/teams/main/pipelines/habitat-plans
    #
    #When you have decided on a version of `plan.sh` file you like commit and push it to origin. This will trigger a build of the plan.
    #If you add a new plan you will need to run `./ci/repipe` to update the pipeline.

    # store CI code under ./.ci instead of ci


## Export

### To Docker

If you have built your package in the studio and remain in the context you can export your pkg to docker via:

```
[2][default:/src:130]# hab pkg export docker epcim/redis
```


## Testing

CI/Testing was discussed at the community forum: https://forums.habitat.sh/t/what-to-use-as-ci-for-plans-local-onprem-hosted-kitchen-delmo-concourse/544

### Example with delmo

Many of the plans are testable via [delmo](https://github.com/bodymindarts/delmo). You can run the tests via:
```
$ delmo -f redis/tests/delmo.yml
```

The tests will run against the latest image built by the pipeline (`epcim/redis:edge`). When a file `<pkg>/tests/delmo.yml` is found the same tests will also be run in the pipeline.

### Locally

    export HAB_DOCKER_OPTS="-p 8080:80"   # Maps localhost:8080 to port 80 in the Studio

## Deploy

TBD

