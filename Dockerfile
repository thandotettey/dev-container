FROM debian:10-slim

ARG USERNAME=vscode
ARG USER_UID=10000
ARG USER_GID=$USER_UID

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y install --no-install-recommends apt-utils dialog 2>&1

RUN apt-get -y install --no-install-recommends \
  less \
  curl \
  tar \
  wget \
  ca-certificates \
  apt-transport-https \
  bash \
  vim \
  dos2unix \
  sudo \
  unzip \
  bash-completion \
  lsb-release \
  gnupg

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list && \
  curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 2>/dev/null && \
  apt-get update && \
  apt-get install --no-install-recommends -y azure-cli && \
  rm -rf /opt/az/lib/python3.6/test/

RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && \
  unzip ./terraform_0.11.13_linux_amd64.zip && \
  mv terraform /usr/local/bin/ && \
  chmod +x /usr/local/bin/terraform

