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

INSTALL(FILES
         bareos
         PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE
         DESTINATION "${sbindir}")

INSTALL(FILES
         bconsole
         mtx-changer
         disk-changer
         btraceback.gdb
         btraceback.dbx
         btraceback.mdb
         bareos-config
         bareos-config-lib.sh
         bareos-explorer
         bareos-glusterfind-wrapper
         btraceback
         bareos_config
         bareos-ctl-dir
         bareos-ctl-fd
         bareos-ctl-sd
         bareos-ctl-funcs
         PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE
         DESTINATION "${scriptdir}")

INSTALL(FILES
         mtx-changer.conf
         DESTINATION "${confdir}")

