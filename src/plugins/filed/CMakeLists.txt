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

include_directories(../.. . ../../include ../../filed /usr/include/python2.7)


set(OPENSSL_LIBS ssl crypto)
set(DLLIBS dl)

add_library(bpipe-fd MODULE bpipe-fd.cc)
# do not prefix with "lib"
set_target_properties(bpipe-fd PROPERTIES PREFIX "")

add_library(example-plugin-fd MODULE example-plugin-fd.cc)
# do not prefix with "lib"
set_target_properties(example-plugin-fd PROPERTIES PREFIX "")

add_library(python-fd MODULE python-fd.cc)
# do not prefix with "lib"
set_target_properties(python-fd PROPERTIES PREFIX "")

INSTALL(TARGETS python-fd DESTINATION ${plugindir})
