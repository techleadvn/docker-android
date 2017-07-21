#!/bin/bash
yes | /root/Android/Sdk/tools/android update sdk --no-ui --all --use-sdk-wrapper --filter build-tools-$ANDROID_BUILD_TOOL_VERSION,android-$ANDROID_VERSION
$@

