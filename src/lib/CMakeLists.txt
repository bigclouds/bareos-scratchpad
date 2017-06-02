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
include_directories(../include ..)

set (BAREOS_SRCS  address_conf.cc alist.cc attr.cc attribs.cc base64.cc
   berrno.cc bget_msg.cc binflate.cc bnet_server_tcp.cc bnet.cc  bpipe.cc
   breg.cc bregex.cc bsnprintf.cc bsock.cc bsock_sctp.cc  bsock_tcp.cc
   bsock_udt.cc bsys.cc btime.cc btimers.cc  cbuf.cc compression.cc
   connection_pool.cc cram-md5.cc crypto.cc  crypto_cache.cc crypto_gnutls.cc
   crypto_none.cc crypto_nss.cc  crypto_openssl.cc crypto_wrap.cc daemon.cc
   devlock.cc dlist.cc  edit.cc fnmatch.cc guid_to_name.cc hmac.cc htable.cc
   jcr.cc json.cc  lockmgr.cc md5.cc mem_pool.cc message.cc mntent_cache.cc
   output_formatter.cc passphrase.cc path_list.cc plugins.cc poll.cc  priv.cc
   queue.cc rblist.cc runscript.cc rwlock.cc scan.cc scsi_crypto.cc  scsi_lli.cc
   scsi_tapealert.cc sellist.cc serial.cc sha1.cc signal.cc  smartall.cc
   tls_gnutls.cc tls_none.cc tls_nss.cc tls_openssl.cc  tree.cc util.cc var.cc
   watchdog.cc workq.cc)

add_library(bareos SHARED ${BAREOS_SRCS})

target_link_libraries(bareos crypto ssl ${LZO_LIB})

set (BAREOSCFG_SRCS ini.cc lex.cc parse_bsr.cc parse_conf.cc res.cc)

add_library(bareoscfg SHARED ${BAREOSCFG_SRCS})

target_link_libraries(bareoscfg crypto ssl ${LZO_LIB})

INSTALL(TARGETS bareos DESTINATION ${INSTALL_LIB_DIR})
INSTALL(TARGETS bareoscfg DESTINATION ${INSTALL_LIB_DIR})

