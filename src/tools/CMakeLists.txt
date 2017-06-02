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

include_directories(../include .. ../dird ../filed ../stored)


add_executable(bsmtp bsmtp.cc)
target_link_libraries(bsmtp bareos)

add_executable(drivetype drivetype.cc)
target_link_libraries(drivetype bareos bareosfind )

add_executable(fstype fstype.cc)
target_link_libraries(fstype bareos bareosfind )

add_executable(bregex bregex.cc)
target_link_libraries(bregex bareos bareosfind )

add_executable(bwild bwild.cc)
target_link_libraries(bwild bareos )

add_executable(bpluginfo bpluginfo.cc)
target_link_libraries(bpluginfo bareos dl )

add_executable(bscrypto bscrypto.cc)
target_link_libraries(bscrypto bareos )

add_executable(timelimit timelimit.cc)

set (TOOLS_BIN bsmtp bwild bregex)
set (TOOLS_SBIN bpluginfo bscrypto)

INSTALL(TARGETS ${TOOLS_BIN} DESTINATION "${CMAKE_INSTALL_BINDIR}")
INSTALL(TARGETS ${TOOLS_SBIN} DESTINATION "${CMAKE_INSTALL_SBINDIR}")
