FROM debian:9.5

RUN apt-get update && \
	apt-get install -y locales && \
	echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
	locale-gen

COPY dotfiles/xterm-256color-italic.terminfo /root/.xterm-256color-italic.terminfo
COPY dotfiles/tmux.conf /root/.tmux.conf
RUN tic /root/.xterm-256color-italic.terminfo

RUN apt-get install -y --no-install-recommends apt-utils\
	build-essential \
	curl \
	git \
	jq \
	neovim \
	tmux \
	wget \
	zsh 
RUN chsh -s /usr/bin/zsh

# install node
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

# install go
# WORKDIR /tmp
# RUN wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
# RUN tar -xvf go1.11.linux-amd64.tar.gz
# RUN mv go /usr/local
# RUN rm -rf /tmp/go*

