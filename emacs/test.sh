#!/bin/sh
set -e

export HOME="$(pwd)/test-home"
mkdir -p "${HOME}/.emacs.d"
cp "./init.el" "${HOME}/.emacs.d/init.el"

emacs
