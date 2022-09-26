FROM node:16.17-bullseye-slim

RUN apt update
RUN apt install -y git zsh
RUN curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -
ENV SHELL /bin/zsh
ENV GIT_EDITOR="code --wait"
