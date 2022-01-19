# docker-jenkins-agent-amazonlinux2-nodejs16

Extension of Docker image with Jenkins agent and Node.js on Amazon Linux 2.

The image is an extension to [lazzurs/jenkins-agent-amazonlinux2:latest](lazzurs/jenkins-agent-amazonlinux2).

**Software**:

- Jenkins agent, [check version](https://github.com/lazzurs/docker-jenkins-agent-amazonlinux2/blob/master/Dockerfile#L3)
- [nvm v0.38.0](https://github.com/nvm-sh/nvm)
- [Node.js v16.13.2](https://nodejs.org/en/download/package-manager/#nvm)
- [Yarn v1.22.10](https://yarnpkg.com/getting-started/install)
- [standard-version 9.3.1](https://github.com/conventional-changelog/standard-version)
- [SonarScanner 4.6.2.2472](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)
- [nx workspace](https://nx.dev)
- [google-chrome-stable](https://intoli.com/blog/installing-google-chrome-on-centos/)
- extra system packages for Node.js native addons compilation
