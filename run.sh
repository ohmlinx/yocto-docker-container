#!/bin/bash

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

uid=$(id -u ${USER})
gid=$(id -g ${USER})

docker run --rm -e HOST_USER_ID=$uid -e HOST_USER_GID=$gid -it -v $(pwd):/workdir ohmlinx:yocto