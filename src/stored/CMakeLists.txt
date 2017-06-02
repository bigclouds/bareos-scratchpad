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


include_directories(. .. ../include ../lmdb ../ndmp)


set(PYTHON_LIBS python2.7 pthread dl util m util rt)
set(OPENSSL_LIBS ssl crypto)
set(DLLIBS dl)
set(LIBS pthread dl)

set (AVAILABLE_DEVICE_API_SRCS
      backends/cephfs_device.cc
      backends/elasto_device.cc
      backends/gfapi_device.cc
      backends/object_store_device.cc
      backends/rados_device.cc
      backends/generic_tape_device.cc
      backends/unix_fifo_device.cc
      backends/unix_tape_device.cc
     )

set (NEEDED_DEVICE_API_SRCS backends/unix_file_device.cc ${AVAILABLE_DEVICE_API_SRCS})


set (LIBBAREOSSD_SRCS acquire.cc ansi_label.cc askdir.cc autochanger.cc
         block.cc bsr.cc
		   butil.cc crc32.cc dev.cc device.cc ebcdic.cc label.cc lock.cc
		   mount.cc read_record.cc record.cc reserve.cc scan.cc
		   sd_backends.cc sd_plugins.cc sd_stats.cc spool.cc
		   stored_conf.cc vol_mgr.cc wait.cc ${NEEDED_DEVICE_API_SRCS}
    )

set(SDSRCS append.cc askdir.cc authenticate.cc dir_cmd.cc fd_cmds.cc
         job.cc mac.cc ndmp_tape.cc read.cc sd_cmds.cc sd_stats.cc
         socket_server.cc status.cc stored.cc
)

set(BTAPESRCS btape.cc)
set(BLSSRCS bls.cc)
set(BEXTRACTSRS bextract.cc)
set(BSCANSRCS  bscan.cc)
set(BCOPYSRCS bcopy.cc)

set(STORED_RESTYPES autochanger device director ndmp messages storage)



add_library(bareossd SHARED ${LIBBAREOSSD_SRCS})


add_executable(bareos-sd ${SDSRCS})
target_link_libraries(bareos-sd bareos bareossd bareosfind bareoscfg bareosndmp pthread)

add_executable(bls ${BLSSRCS})
target_link_libraries(bls bareos bareossd bareosfind bareoscfg)

add_executable(bextract ${BEXTRACTSRS})
target_link_libraries(bextract bareossd bareosfind bareos bareoscfg)

add_executable(bscan ${BSCANSRCS})
target_link_libraries(bscan bareos bareossd bareosfind bareoscfg bareossql bareoscats)

add_executable(btape ${BTAPESRCS})
target_link_libraries(btape bareossd bareos bareoscfg)

add_executable(bcopy ${BCOPYSRCS})
target_link_libraries(bcopy bareossd bareos bareoscfg)

INSTALL(TARGETS bareossd DESTINATION "${INSTALL_LIB_DIR}")

INSTALL(TARGETS bareos-sd bls bextract bscan btape bcopy DESTINATION "${CMAKE_INSTALL_SBINDIR}")

install(SCRIPT install-configfiles.cmake)
