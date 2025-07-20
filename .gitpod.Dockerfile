# Use Ubuntu as base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update -y && apt-get install -y \
    openjdk-11-jdk wget unzip curl git zip

# Install Android SDK
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip \
    && unzip commandlinetools-linux-7583922_latest.zip \
    && rm commandlinetools-linux-7583922_latest.zip

# Set environment variables for Android SDK
ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Install Android SDK platforms and build tools
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses
RUN sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "platforms;android-30" "build-tools;30.0.3"

# Install Gradle (optional)
RUN wget https://services.gradle.org/distributions/gradle-6.7.1-bin.zip -P /opt/gradle \
    && unzip /opt/gradle/gradle-6.7.1-bin.zip -d /opt/gradle \
    && rm /opt/gradle/gradle-6.7.1-bin.zip

ENV GRADLE_HOME /opt/gradle/gradle-6.7.1
ENV PATH $PATH:$GRADLE_HOME/bin
