# torc-docker
Management scripts used for torc docker instance.

When updating torc in the past it was necessary to update the docker image
to align with the git repo. This was a pain in the ass, and this script means
it's not necessary to update the docker image quite so much. When any torc-*
repo is updated, the torc.sh script, which is the docker image entry point,
will update all torc-* repos first (unless the '-n' argument is provided).
Much better.
