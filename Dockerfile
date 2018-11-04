FROM debian:9.5

RUN groupadd -r dev && \
    useradd --no-log-init -r -g dev dev

RUN apt-get update && \
	apt-get install -y locales && \
	echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
	locale-gen

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

COPY dotfiles/xterm-256color-italic.terminfo /home/dev/.xterm-256color-italic.terminfo
COPY dotfiles/tmux.conf /home/dev/.tmux.conf
RUN tic /home/dev/.xterm-256color-italic.terminfo

# install node
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

RUN mkdir -p /home/dev/.config/nvim
COPY dotfiles/vimrc /home/dev/.config/nvim/init.vim
RUN chown dev /home/dev
USER dev
WORKDIR /home/dev


# install go
# WORKDIR /tmp
# RUN wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
# RUN tar -xvf go1.11.linux-amd64.tar.gz
# RUN mv go /usr/local
# RUN rm -rf /tmp/go*

