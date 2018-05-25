
# K8s ecosystem Habitat plans


## Customize

TBD

## Install plans

  ./Planfile

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


## Export to docker

If you have built your package in the studio and remain in the context you can export your pkg to docker via:

```
[2][default:/src:130]# hab pkg export docker epcim/redis
```


## Test


### With delmo

Many of the plans are testable via [delmo](https://github.com/bodymindarts/delmo). You can run the tests via:
```
$ delmo -f redis/tests/delmo.yml
```

The tests will run against the latest image built by the pipeline (`epcim/redis:edge`). When a file `<pkg>/tests/delmo.yml` is found the same tests will also be run in the pipeline.

### Locally

    export HAB_DOCKER_OPTS="-p 8080:80"   # Maps localhost:8080 to port 80 in the Studio

## Deploy

TBD

