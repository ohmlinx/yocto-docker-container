# Copyright (c) 2018 Ohmlinx Electronics LLC

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM ubuntu:18.04
MAINTAINER Nate Drude "nate.drude@ohmlinxelectronics.com"

RUN apt-get update
RUN apt-get install -y sudo openssl apt-utils

WORKDIR /workdir

# Define username and temporary uid and gid
ENV USER=engr USER_ID=1000 USER_GID=1000

# now creating user, change password to 'ubuntu'
RUN groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
      --uid ${USER_ID} \
      --gid ${USER_GID} \
      --create-home \
      --shell /bin/bash\
      --password $(openssl passwd -1 ubuntu)\
      ${USER}

#setup locale
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y locales && dpkg-reconfigure locales --frontend noninteractive && locale-gen "en_US.UTF-8" && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
# RUN apt-get install -y locales && locale-gen "en_US.UTF-8" && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#     locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN apt-get update && apt-get install -y \
     gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

#handled by --shell command in useradd
#CMD ["/bin/bash"]
