#Example {cmd} = ./gradlew clean build
docker run -v $PWD:/app -w /app -e ANDROID_BUILD_TOOL_VERSION=25.0.2 -e ANDROID_VERSION=25 android-docker {cmd}
