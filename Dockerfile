FROM ubuntu:20.04
ARG USERNAME=ktran

# Set up a cleaner install of apt-get so that we can `apt build-dep` later
RUN cp /etc/apt/sources.list /etc/apt/sources.list~
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update

# Essential, baseline installations
RUN apt-get install -y openssh-server
RUN apt-get install -y nano git vim build-essential curl wget

# SSH configuration to enable swarming
RUN mkdir /var/run/sshd
RUN sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Other configurations required for swarming
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Defune username & environment
RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1000 $USERNAME
RUN echo $USERNAME:$USERNAME | chpasswd

# Personal configurations
COPY bashrc_additions.sh .
RUN cat bashrc_additions.sh >> /home/$USERNAME/.bashrc
RUN rm bashrc_additions.sh
# Personal VIM installation
RUN git clone https://github.com/vim/vim.git /home/$USERNAME/vim
RUN apt build-dep vim -y
RUN cd /home/$USERNAME/vim/ && ./configure --enable-gui=auto --enable-gtk2-check --with-x
COPY .vimrc /home/$USERNAME/.vimrc
RUN vim -E -u NONE -S /home/$USERNAME/.vimrc +qall

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
