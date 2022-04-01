#!/bin/bash

[[ "$target_platform" == "win-64" ]] && patch_libtool

# this is used for testing only
echo "Hello world!"
