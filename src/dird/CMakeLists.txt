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

set(LIBS pthread dl)
set(PYTHON_LIBS python2.7 pthread dl util m rt)
set(OPENSSL_LIBS ssl crypto)
set(DLLIBS dl)
set(CAP_LIBS cap)
set(NDMP_LIBS bareosndmp)
set(LMDB_LIBS bareoslmdb)

set(SVRSRCS admin.cc archive.cc authenticate.cc autoprune.cc backup.cc bsr.cc catreq.cc
	  consolidate.cc dir_plugins.cc dird_conf.cc dird.cc expand.cc fd_cmds.cc
	  getmsg.cc inc_conf.cc job.cc jobq.cc migrate.cc mountreq.cc msgchan.cc
	  ndmp_dma_backup.cc ndmp_dma_generic.cc ndmp_dma_restore.cc
	  ndmp_dma_storage.cc ndmp_fhdb_common.cc ndmp_fhdb_helpers.cc
	  ndmp_fhdb_mem.cc ndmp_fhdb_lmdb.cc
	  newvol.cc next_vol.cc quota.cc socket_server.cc recycle.cc restore.cc
	  run_conf.cc sd_cmds.cc scheduler.cc stats.cc storage.cc ua_acl.cc ua_audit.cc
	  ua_cmds.cc ua_configure.cc ua_db.cc ua_dotcmds.cc ua_input.cc ua_impexp.cc
	  ua_label.cc ua_output.cc ua_prune.cc ua_purge.cc ua_query.cc ua_restore.cc
	  ua_run.cc ua_select.cc ua_server.cc ua_status.cc ua_tree.cc ua_update.cc
	  vbackup.cc verify.cc)

set(DBCHKSRCS dbcheck.cc dird_conf.cc ua_acl.cc ua_audit.cc run_conf.cc inc_conf.cc)

set(TSTFNDSRCS testfind.cc dird_conf.cc ua_acl.cc ua_audit.cc run_conf.cc inc_conf.cc)

set(DIRD_RESTYPES catalog client console counter director fileset job jobdefs messages pool profile schedule storage)

add_executable(bareos-dir ${SVRSRCS})
target_link_libraries(bareos-dir bareos bareoscats bareoscfg bareossql bareoscats bareosfind
                     ${NDMP_LIBS} ${LMDB_LIBS} ${CAP_LIBS} ${OPENSSL_LIBS}
                     ${LIBS} ${DLL_LIBS} jansson acl lzo2 )

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fPIC -DPIC -Wl,-export-dynamic" )

#TODO:

add_executable(bareos-dbcheck ${DBCHKSRCS})
target_link_libraries(bareos-dbcheck bareossql bareos bareosfind bareoscfg bareoscats
                      jansson ${OPENSSL_LIBS} ${CAP_LIBS} lzo2 acl
                      ${LIBS}
)

# is not built by default

#add_executable(testfind ${TSTFNDSRCS})
#target_link_libraries(testfind bareos bareosfind bareoscfg
#                      jansson ${OPENSSL_LIBS} acl cap lzo2
#)


INSTALL(TARGETS bareos-dir bareos-dbcheck DESTINATION "${CMAKE_INSTALL_SBINDIR}")
INSTALL(FILES query.sql DESTINATION "${scriptdir}")


install(SCRIPT install-configfiles.cmake)
