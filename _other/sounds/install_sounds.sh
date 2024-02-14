#!/bin/bash

set -e

pushd "${0%/*}" &>/dev/null

sudo cp "$(pwd)"/*.oga /usr/share/sounds/freedesktop/stereo/

popd &>/dev/null
