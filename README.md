This is a simple Elm program to calculate the exact coin change for doing laundry (ported from the original [Haskell program](https://gist.github.com/srid/dca5ee92bcab1d6cefae)). It was written in the process of learning Elm.

# Local development


First install the prerequisites:

```
open http://boot2docker.io
open https://toolbelt.heroku.com
heroku plugins:install heroku-docker
```

Then build and run:

```
make
```

# Heroku deployment

Deployment is made easier using [Heroku's client-side docker plugin](https://blog.heroku.com/archives/2015/5/5/introducing_heroku_docker_release_build_deploy_heroku_apps_with_docker).
```
make deploy
```

