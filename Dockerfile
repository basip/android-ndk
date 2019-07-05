FROM ubuntu:18.10
LABEL maintainer="dmpanch"

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r16b

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get clean
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'


# ------------------------------------------------------
# --- Install required tools

RUN apt-get install -qqy --no-install-recommends \
      apt-utils \
      bzip2 \
      curl \
      git-core \
      html2text \
      libc6-i386 \
      lib32stdc++6 \
      lib32gcc1 \
      lib32ncurses5-dev \
      lib32z1 \
      unzip \
      zip \
      wget \
      sudo \
      software-properties-common \
      python \
      build-essential \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp && \
    cd /opt/android-ndk-tmp && \
    wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
# uncompress
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip && \
# move to its final location
    mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} && \
# remove temp dir
    cd ${ANDROID_NDK_HOME} && \
    rm -rf /opt/android-ndk-tmp

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Cleanup and rev num

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK v2017_12_07_1
CMD bitrise -version
