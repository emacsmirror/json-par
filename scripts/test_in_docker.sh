#!/bin/sh

# Run tests in Docker.  Used in Makefile.

for version in 28 27 26 25 24
do
    rm -f *.elc
    rm -f *-autoloads.el
    docker \
        run \
        --rm \
        --volume="$(pwd)":/src \
        --user="$(id -u):$(id -g)" \
        --workdir="/src" \
        --env=ELDEV_DIR=/src/.eldev \
        --env=HOME=/tmp \
        silex/emacs:${version}-ci-eldev \
        bash -c "./scripts/run_test.sh" \
        || exit 1
done

echo "done"
