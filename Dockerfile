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

FROM ubuntu:16.04
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

#Android ASOP on ubuntu 14.04
#https://source.android.com/setup/build/initializing
#RUN apt-get install -y \
#    git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib \
#    g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev \
#    lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip

#https://boundarydevices.com/android-getting-started-guide/
#Android ASOP on ubuntu 16.04
RUN apt-get install -y \
    openjdk-8-jdk
RUN apt-get install -y \
    git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip
#NXP Dependencies
RUN apt-get install -y \
    uuid uuid-dev lzop gperf liblz-dev liblzo2-2 \
    liblzo2-dev u-boot-tools flex mtd-utils android-tools-fsutils bc \
    repo git

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

#handled by --shell command in useradd
#CMD ["/bin/bash"]
