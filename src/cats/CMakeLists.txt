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

include_directories(. .. ../include)


add_definitions( -D_BDB_PRIV_INTERFACE_)

set(LIBBAREOSSQL_SRCS
    bvfs.cc cats.cc sql.cc sql_cmds.cc sql_create.cc sql_delete.cc
    sql_find.cc sql_get.cc sql_glue.cc sql_list.cc sql_pooling.cc
    sql_update.cc)


set(LIBBAREOSCATS_DYN_SRCS cats_backends.cc)



set(SQLITE_SRCS sqlite.cc)
set(MYSQL_SRCS mysql.cc)
set(POSTGRESQL_SRCS postgresql.cc)


add_library(bareossql SHARED ${LIBBAREOSSQL_SRCS})

set_property(TARGET bareossql PROPERTY VERSION "16.2.5")
set_property(TARGET bareossql PROPERTY SOVERSION 16)




add_library(bareoscats SHARED ${LIBBAREOSCATS_SRCS} ${LIBBAREOSCATS_DYN_SRCS})
target_link_libraries (bareoscats bareossql bareos)

set_property(TARGET bareoscats PROPERTY VERSION "16.2.5")
set_property(TARGET bareoscats PROPERTY SOVERSION 16)


add_library(bareoscats-sqlite3 MODULE ${SQLITE_SRCS})
target_link_libraries (bareoscats-sqlite3 bareossql bareos sqlite3)

add_library(bareoscats-mysql MODULE ${MYSQL_SRCS})
target_link_libraries(bareoscats-mysql bareossql bareos)

add_library(bareoscats-postgresql MODULE ${POSTGRESQL_SRCS})
target_link_libraries(bareoscats-postgresql bareossql bareos)

set_property(TARGET bareoscats-sqlite3 PROPERTY VERSION "16.2.5")
set_property(TARGET bareoscats-sqlite3 PROPERTY SOVERSION 16)

set_property(TARGET bareoscats-mysql PROPERTY VERSION "16.2.5")
set_property(TARGET bareoscats-mysql PROPERTY SOVERSION 16)

set_property(TARGET bareoscats-postgresql PROPERTY VERSION "16.2.5")
set_property(TARGET bareoscats-postgresql PROPERTY SOVERSION 16)


INSTALL(TARGETS bareoscats-postgresql
                bareoscats-mysql
                bareoscats-sqlite3
                bareoscats
                bareossql
                DESTINATION ${INSTALL_LIB_DIR})

INSTALL(FILES
                  create_bareos_database
                  update_bareos_tables
                  make_bareos_tables
                  grant_bareos_privileges
                  drop_bareos_tables
                  drop_bareos_database
                  make_catalog_backup.pl
                  make_catalog_backup
                  delete_catalog_backup
                  DESTINATION ${scriptdir})

INSTALL(DIRECTORY ddl DESTINATION ${scriptdir})
