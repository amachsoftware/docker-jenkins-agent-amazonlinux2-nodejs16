FROM ghcr.io/lazzurs/jenkins-agent-amazonlinux2:latest

ARG NVM_VERSION=v0.38.0
ARG NODE_VERSION=16.13.2
ARG SONAR_SCANNER_VERSION=4.6.2.2472

ARG SONAR_HOME=/home/jenkins/.sonar
ARG SONAR_SCANNER_PACKAGE=sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip

LABEL Description="Docker image with Jenkins agent and Node.js on Amazon Linux 2"
LABEL Vendor="Catalin Piscureanu"

USER root

COPY install-google-chrome.sh /usr/local/bin/install-google-chrome.sh
RUN yum update -y &&\
    chmod +x /usr/local/bin/install-google-chrome.sh &&\
    /usr/local/bin/install-google-chrome.sh

RUN yum install -y glibc-langpack-en && \
    yum groupinstall -y development && \
    yum install -y xorg-x11-server-Xvfb gtk2-devel gtk3-devel libnotify-devel GConf2 nss libXScrnSaver alsa-lib && \
    yum install -y which clang cmake && \
    yum clean all && \
    rm -rf /var/cache/yum

USER jenkins

ENV NVM_DIR /home/jenkins/.nvm
ENV NODE_VERSION ${NODE_VERSION}

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    . ${NVM_DIR}/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION} && \
    nvm use default

ENV NODE_PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/lib/node_modules
ENV PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:${PATH}

RUN curl https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_PACKAGE} -o ${SONAR_SCANNER_PACKAGE} -s && \
    unzip ${SONAR_SCANNER_PACKAGE} -d ${SONAR_HOME} && \
    rm ${SONAR_SCANNER_PACKAGE}

ENV SONAR_RUNNER_HOME ${SONAR_HOME}/sonar-scanner-${SONAR_SCANNER_VERSION}-linux
ENV PATH ${SONAR_RUNNER_HOME}/bin:${PATH}

RUN npm install -g standard-version@9.3.1 && \
    npm install -g yarn && \
    yarn global add nx
