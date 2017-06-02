#   BAREOS�� - Backup Archiving REcovery Open Sourced
#
#   Copyright (C) 2017-2017 Bareos GmbH & Co. KG
#
#   This program is Free Software; you can redistribute it and/or
#   modify it under the terms of version three of the GNU Affero General Public
#   License as published by the Free Software Foundation and included
#   in the file LICENSE.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#   02110-1301, USA.

cmake_minimum_required(VERSION 2.8.9)
project(bareos)
set(CMAKE_BUILD_TYPE Release)
include_directories(. .. ../include )

set(FDSRCS accurate.cc authenticate.cc crypto.cc fd_plugins.cc fileset.cc sd_cmds.cc verify.cc
    accurate_htable.cc backup.cc dir_cmd.cc filed.cc heartbeat.cc socket_server.cc verify_vol.cc
    accurate_lmdb.cc compression.cc estimate.cc filed_conf.cc restore.cc status.cc)

add_executable(bareos-fd ${FDSRCS})
target_link_libraries(bareos-fd bareosfind bareoscfg bareos pthread ${ZLIB_LIBRARIES})

INSTALL(TARGETS bareos-fd DESTINATION "${CMAKE_INSTALL_SBINDIR}")

install(SCRIPT install-configfiles.cmake)

