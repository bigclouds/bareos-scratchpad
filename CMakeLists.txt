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



set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(ZLIB)
find_package(Readline)
find_package(Lzo)

set(lld "\"lld\"")
set(llu "\"llu\"")

set(HAVE_LIBZ "${ZLIB_FOUND}" )
set(HAVE_ZLIB_H "${ZLIB_FOUND}" )

find_program(AWK awk)
find_program(PIDOF pidof)
find_program(PGREP pgrep)


# set INSTALL_LIB_DIR automatically to lib or lib64 automatically
# Taken from  https://cmake.org/pipermail/cmake/2013-July/055374.html

get_property(LIB64 GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS)
if ("${LIB64}" STREQUAL "TRUE")
    set(LIBSUFFIX 64)
else()
    set(LIBSUFFIX "")
endif()
set(INSTALL_LIB_DIR  "usr/lib${LIBSUFFIX}" CACHE PATH "Installation directory for libraries")
mark_as_advanced(INSTALL_LIB_DIR)




# RPATH settings (from https://cmake.org/Wiki/CMake_RPATH_handling)
# use, i.e. don't skip the full RPATH for the build tree
SET(CMAKE_SKIP_BUILD_RPATH  FALSE)

# when building, don't use the install RPATH already
# (but later on when installing)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 

SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${INSTALL_LIB_DIR}")

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)






# extract version number from version.h
file(STRINGS ${CMAKE_SOURCE_DIR}/src/include/version.h VERSION_INFO REGEX define.*VERSION.*)
string(REGEX MATCH "\"(.*)\""
       VERSION ${VERSION_INFO})
set(VERSION, ${CMAKE_MATCH_1})

if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
   set(HAVE_LINUX_OS, 1)
endif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")

INCLUDE(GNUInstallDirs)



cmake_host_system_information(RESULT hostname QUERY HOSTNAME)

set(dbdriver sqlite3)
set(db_name bareos)
set(db_user bareos)
set(db_password "")



#manual definitions
set (BAREOS "Bareos")
#set(CONFDIR \"${CMAKE_INSTALL_FULL_SYSCONFDIR}\")
set(LOCALEDIR \"${CMAKE_INSTALL_FULL_LOCALEDIR}\")



set(SMARTALLOC 1)
set(ENABLE_NLS 1)
set(HAVE_OPENSSL 1)
set(FSTYPE_MNTENT 1)
#set(HAVE_ACL 0)
set(HAVE_CMOCKA 1)
set(HAVE_CRYPTO 1)
set(HAVE_DYNAMIC_CATS_BACKENDS 1)
set(HAVE_SQLITE3 1)





#LIBDIR
#LOCALEDIR
#PACKAGE_STRING
#PACKAGE_VERSION
#SYSCONFDIR
#_PATH_BAREOS_BACKENDDIR
#_PATH_BAREOS_PIDDIR
#_PATH_BAREOS_WORKINGDIR


# type size checks
INCLUDE(CheckTypeSize)
CHECK_TYPE_SIZE("short int" SIZEOF_SHORT_INT)
CHECK_TYPE_SIZE("char" SIZEOF_CHAR)
CHECK_TYPE_SIZE("int" SIZEOF_INT)
CHECK_TYPE_SIZE("int *" SIZEOF_INT_P)
CHECK_TYPE_SIZE("long int" SIZEOF_LONG_INT)
CHECK_TYPE_SIZE("long long int" SIZEOF_LONG_LONG_INT)

CHECK_TYPE_SIZE(int16_t INT16_T)
CHECK_TYPE_SIZE(int32_t INT32_T)
CHECK_TYPE_SIZE(int64_t INT64_T)
CHECK_TYPE_SIZE(intmax_t INTMAX_T)
CHECK_TYPE_SIZE(uint8_t U_INT8_T)
CHECK_TYPE_SIZE(uint16_t U_INT16_T)
CHECK_TYPE_SIZE(uint32_t U_INT32_T)
CHECK_TYPE_SIZE(uint64_t U_INT64_T)
CHECK_TYPE_SIZE(uintmax_t UINTMAX_T)
CHECK_TYPE_SIZE(u_intmax_t U_INTMAX_T)



INCLUDE(TestBigEndian)
TEST_BIG_ENDIAN(WORDS_BIGENDIAN)
TEST_BIG_ENDIAN(BIG_ENDIAN)


MESSAGE( STATUS "VERSION: " ${CMAKE_MATCH_1} )

MESSAGE( STATUS "CMAKE_SOURCE_DIR:         " ${CMAKE_SOURCE_DIR} )




INCLUDE(FindPythonLibs)

#PYTHONLIBS_FOUND
#PYTHON_LIBRARIES
#PYTHON_INCLUDE_PATH
#PYTHON_INCLUDE_DIRS
#PYTHON_DEBUG_LIBRARIES
#PYTHONLIBS_VERSION_STRING





# Platform Checks
INCLUDE (CheckIncludeFiles)


CHECK_INCLUDE_FILES(Python.h HAVE_PYTHON_H)
CHECK_INCLUDE_FILES(tcpd.h HAVE_TCPD_H)
CHECK_INCLUDE_FILES(afs/afsint.h HAVE_AFS_AFSINT_H)
CHECK_INCLUDE_FILES(afs/venus.h HAVE_AFS_VENUS_H)
CHECK_INCLUDE_FILES(argz.h HAVE_ARGZ_H)
CHECK_INCLUDE_FILES(arpa/nameser.h HAVE_ARPA_NAMESER_H)
CHECK_INCLUDE_FILES(assert.h HAVE_ASSERT_H)
CHECK_INCLUDE_FILES(attr.h HAVE_ATTR_H)
CHECK_INCLUDE_FILES(camlib.h HAVE_CAMLIB_H)
CHECK_INCLUDE_FILES(cam/scsi/scsi_message.h HAVE_CAM_SCSI_SCSI_MESSAGE_H)
CHECK_INCLUDE_FILES(cmocka.h HAVE_CMOCKA_H)
CHECK_INCLUDE_FILES(curses.h HAVE_CURSES_H)
CHECK_INCLUDE_FILES(cxxabi.h HAVE_CXXABI_H)
CHECK_INCLUDE_FILES(demangle.h HAVE_DEMANGLE_H)
CHECK_INCLUDE_FILES(dev/scsipi/scsipi_all.h HAVE_DEV_SCSIPI_SCSIPI_ALL_H)
CHECK_INCLUDE_FILES(dirent.h HAVE_DIRENT_H)
CHECK_INCLUDE_FILES(dlfcn.h HAVE_DLFCN_H)
CHECK_INCLUDE_FILES(dl.h HAVE_DL_H)
CHECK_INCLUDE_FILES(execinfo.h HAVE_EXECINFO_H)
CHECK_INCLUDE_FILES(fastlzlib.h HAVE_FASTLZLIB_H)
CHECK_INCLUDE_FILES(jansson.h HAVE_JANSSON_H)
CHECK_INCLUDE_FILES(fcntl.h HAVE_FCNTL_H)
CHECK_INCLUDE_FILES(glob.h HAVE_GLOB_H)
CHECK_INCLUDE_FILES(gnutls/gnutls.h HAVE_GNUTLS_GNUTLS_H)
CHECK_INCLUDE_FILES(grp.h HAVE_GRP_H)
CHECK_INCLUDE_FILES(inttypes.h HAVE_INTTYPES_H)
CHECK_INCLUDE_FILES(libc.h HAVE_LIBC_H)
CHECK_INCLUDE_FILES(libutil.h HAVE_LIBUTIL_H)
CHECK_INCLUDE_FILES(limits.h HAVE_LIMITS_H)
CHECK_INCLUDE_FILES(locale.h HAVE_LOCALE_H)
#CHECK_INCLUDE_FILES(lzo/lzo1x.h HAVE_LZO_LZO1X_H)
#CHECK_INCLUDE_FILES(lzo/lzoconf.h HAVE_LZO_LZOCONF_H)
CHECK_INCLUDE_FILES(malloc.h HAVE_MALLOC_H)
CHECK_INCLUDE_FILES(memory.h HAVE_MEMORY_H)
CHECK_INCLUDE_FILES(mtio.h HAVE_MTIO_H)
CHECK_INCLUDE_FILES(ndir.h HAVE_NDIR_H)
CHECK_INCLUDE_FILES(nl_types.h HAVE_NL_TYPES_H)
CHECK_INCLUDE_FILES(poll.h HAVE_POLL_H)
CHECK_INCLUDE_FILES(pwd.h HAVE_PWD_H)
CHECK_INCLUDE_FILES(regex.h HAVE_REGEX_H)
CHECK_INCLUDE_FILES(scsi/scsi.h HAVE_SCSI_SCSI_H)
CHECK_INCLUDE_FILES(scsi/sg.h HAVE_SCSI_SG_H)
CHECK_INCLUDE_FILES(setjmp.h HAVE_SETJMP_H)
CHECK_INCLUDE_FILES(stdarg.h HAVE_STDARG_H)
CHECK_INCLUDE_FILES(stddef.h HAVE_STDDEF_H)
CHECK_INCLUDE_FILES(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILES(stdlib.h HAVE_STDLIB_H)
CHECK_INCLUDE_FILES(strings.h HAVE_STRINGS_H)
CHECK_INCLUDE_FILES(string.h HAVE_STRING_H)
CHECK_INCLUDE_FILES(sys/acl.h HAVE_SYS_ACL_H)
CHECK_INCLUDE_FILES(sys/attr.h HAVE_SYS_ATTR_H)
CHECK_INCLUDE_FILES(sys/bitypes.h HAVE_SYS_BITYPES_H)
CHECK_INCLUDE_FILES(sys/byteorder.h HAVE_SYS_BYTEORDER_H)
CHECK_INCLUDE_FILES(sys/capability.h HAVE_SYS_CAPABILITY_H)
CHECK_INCLUDE_FILES(sys/dir.h HAVE_SYS_DIR_H)
CHECK_INCLUDE_FILES(sys/dl.h HAVE_SYS_DL_H)
CHECK_INCLUDE_FILES(sys/ea.h HAVE_SYS_EA_H)
CHECK_INCLUDE_FILES(sys/extattr.h HAVE_SYS_EXTATTR_H)
CHECK_INCLUDE_FILES(sys/ioctl.h HAVE_SYS_IOCTL_H)
CHECK_INCLUDE_FILES(sys/mtio.h HAVE_SYS_MTIO_H)
CHECK_INCLUDE_FILES(sys/ndir.h HAVE_SYS_NDIR_H)
CHECK_INCLUDE_FILES(sys/nvpair.h HAVE_SYS_NVPAIR_H)
CHECK_INCLUDE_FILES(sys/param.h HAVE_SYS_PARAM_H)
CHECK_INCLUDE_FILES(sys/poll.h HAVE_SYS_POLL_H)
CHECK_INCLUDE_FILES(sys/prctl.h HAVE_SYS_PRCTL_H)
CHECK_INCLUDE_FILES(sys/proplist.h HAVE_SYS_PROPLIST_H)
CHECK_INCLUDE_FILES(sys/scsi/impl/uscsi.h HAVE_SYS_SCSI_IMPL_USCSI_H)
CHECK_INCLUDE_FILES(sys/select.h HAVE_SYS_SELECT_H)
CHECK_INCLUDE_FILES(sys/socket.h HAVE_SYS_SOCKET_H)
CHECK_INCLUDE_FILES(sys/sockio.h HAVE_SYS_SOCKIO_H)
CHECK_INCLUDE_FILES(sys/statvfs.h HAVE_SYS_STATVFS_H)
CHECK_INCLUDE_FILES(sys/stat.h HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILES(sys/tape.h HAVE_SYS_TAPE_H)
CHECK_INCLUDE_FILES(sys/time.h HAVE_SYS_TIME_H)
CHECK_INCLUDE_FILES(sys/types.h HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILES(sys/xattr.h HAVE_SYS_XATTR_H)
CHECK_INCLUDE_FILES(termcap.h HAVE_TERMCAP_H)
CHECK_INCLUDE_FILES(termios.h HAVE_TERMIOS_H)
CHECK_INCLUDE_FILES(term.h HAVE_TERM_H)
CHECK_INCLUDE_FILES(ucontext.h HAVE_UCONTEXT_H)
CHECK_INCLUDE_FILES(umem.h HAVE_UMEM_H)
CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
CHECK_INCLUDE_FILES(scsi/uscsi_all.h HAVE_SCSI_USCSI_ALL_H)
CHECK_INCLUDE_FILES(utime.h HAVE_UTIME_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)
#CHECK_INCLUDE_FILES(zlib.h HAVE_ZLIB_H)
CHECK_INCLUDE_FILES(NSI HAVE_NSI)




CHECK_INCLUDE_FILES(fcntl.h HAVE_DLFCN_H)
CHECK_INCLUDE_FILES(dlfcn.h HAVE_DLFCN_H)
CHECK_INCLUDE_FILES(dirent.h HAVE_DIRENT_H)
CHECK_INCLUDE_FILES(cxxabi.h HAVE_CXXABI_H)
CHECK_INCLUDE_FILES(assert.h HAVE_ASSERT_H)
CHECK_INCLUDE_FILES(arpa/nameser.h HAVE_ARPA_NAMESER_H)
CHECK_INCLUDE_FILES(sys/wait.h HAVE_SYS_WAIT_H)
CHECK_INCLUDE_FILES(curses.h HAVE_CURSES_H)
CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)
CHECK_INCLUDE_FILES(stdarg.h HAVE_STDARG_H)
CHECK_INCLUDE_FILES(stdlib.h HAVE_STDLIB_H)
CHECK_INCLUDE_FILES(cmocka.h HAVE_CMOCKA_H)
CHECK_INCLUDE_FILES(term.h HAVE_TERM_H)
CHECK_INCLUDE_FILES(glob.h HAVE_GLOB_H)
CHECK_INCLUDE_FILES(poll.h HAVE_POLL_H)
CHECK_INCLUDE_FILES(sys/poll.h HAVE_SYS_POLL_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)
CHECK_INCLUDE_FILES(gnutls/gnutls.h HAVE_GNUTLS_GNUTLS_H)
CHECK_INCLUDE_FILES(sys/statvfs.h HAVE_SYS_STATVFS_H)
CHECK_INCLUDE_FILES(umem.h HAVE_UMEM_H)
CHECK_INCLUDE_FILES(execinfo.h HAVE_EXECINFO_H)
CHECK_INCLUDE_FILES(cxxabi.h HAVE_CXXABI_H)
CHECK_INCLUDE_FILES(ucontext.h HAVE_UCONTEXT_H)
CHECK_INCLUDE_FILES(demangle.h HAVE_DEMANGLE_H)
#CHECK_INCLUDE_FILES(zlib.h HAVE_ZLIB_H)
#CHECK_INCLUDE_FILES(lzo/lzoconf.h HAVE_LZO_LZOCONF_H)
#CHECK_INCLUDE_FILES(lzo/lzo1x.h HAVE_LZO_LZO1X_H)

#IF( "${HAVE_LZO_LZOCONF_H}" OR "${HAVE_LZO_LZO1X_H}")
#   set(HAVE_LZO "1")
#ENDIF()



CHECK_INCLUDE_FILES(fastlzlib.h HAVE_FASTLZLIB_H)
CHECK_INCLUDE_FILES(afs/afsint.h HAVE_AFS_AFSINT_H)
CHECK_INCLUDE_FILES(sys/acl.h HAVE_ACL_H)
CHECK_INCLUDE_FILES(sys/extattr.h HAVE_SYS_EXTATTR_H)
CHECK_INCLUDE_FILES(libutil.h HAVE_LIBUTIL_H)
CHECK_INCLUDE_FILES(alloca.h HAVE_ALLOCA_H)
CHECK_INCLUDE_FILES(sys/ea.h HAVE_SYS_EA_H)
CHECK_INCLUDE_FILES(sys/proplist.h HAVE_SYS_PROPLIST_H)
CHECK_INCLUDE_FILES(sys/attr.h HAVE_SYS_ATTR_H)
CHECK_INCLUDE_FILES(sys/nvpair.h HAVE_SYS_NVPAIR_H)
CHECK_INCLUDE_FILES(attr.h HAVE_ATTR_H)
CHECK_INCLUDE_FILES(sys/xattr.h HAVE_SYS_XATTR_H)
CHECK_INCLUDE_FILES(scsi/sg.h HAVE_SCSI_SG_H)
CHECK_INCLUDE_FILES(scsi/scsi.h HAVE_SCSI_SCSI_H)
CHECK_INCLUDE_FILES(sys/scsi/impl/uscsi.h HAVE_SYS_SCSI_IMPL_USCSI_H)
CHECK_INCLUDE_FILES(camlib.h HAVE_CAMLIB_H)
CHECK_INCLUDE_FILES(cam/scsi/scsi_message.h HAVE_CAM_SCSI_SCSI_MESSAGE_H)
CHECK_INCLUDE_FILES(dev/scsipi/scsipi_all.h HAVE_DEV_SCSIPI_SCSIPI_ALL_H)
CHECK_INCLUDE_FILES(scsi/uscsi_all.h HAVE_SCSI_USCSI_ALL_H)
CHECK_INCLUDE_FILES(api/glfs.h HAVE_API_GLFS_H)
CHECK_INCLUDE_FILES(droplet.h HAVE_DROPLET_H)
CHECK_INCLUDE_FILES(rados/librados.h HAVE_RADOS_LIBRADOS_H)
CHECK_INCLUDE_FILES(radosstriper/libradosstriper.h HAVE_RADOSSTRIPER_LIBRADOSSTRIPER_H)
CHECK_INCLUDE_FILES(cephfs/libcephfs.h HAVE_CEPHFS_LIBCEPHFS_H)
CHECK_INCLUDE_FILES(elasto/data.h HAVE_ELASTO_DATA_H)
CHECK_INCLUDE_FILES(elasto/file.h HAVE_ELASTO_FILE_H)
CHECK_INCLUDE_FILES(sys/prctl.h HAVE_SYS_PRCTL_H)
CHECK_INCLUDE_FILES(sys/capability.h HAVE_SYS_CAPABILITY_H)
CHECK_INCLUDE_FILES(time.h HAVE_TIME_H)

INCLUDE (CheckFunctionExists)
CHECK_FUNCTION_EXISTS(va_copy HAVE_VA_COPY)
CHECK_FUNCTION_EXISTS(strtoll HAVE_STRTOLL)
CHECK_FUNCTION_EXISTS(backtrace HAVE_BACKTRACE)
CHECK_FUNCTION_EXISTS(backtrace_symbols HAVE_BACKTRACE_SYMBOLS)
CHECK_FUNCTION_EXISTS(bcopy HAVE_BCOPY)
CHECK_FUNCTION_EXISTS(dcgettext HAVE_DCGETTTEXT)
CHECK_FUNCTION_EXISTS(dlerror HAVE_DLERROR)
CHECK_FUNCTION_EXISTS(fchdir HAVE_FCHDIR)
CHECK_FUNCTION_EXISTS(fchmod HAVE_FCHMOD)
CHECK_FUNCTION_EXISTS(fchown HAVE_FCHOWN)

CHECK_FUNCTION_EXISTS(add_proplist_entry HAVE_ADD_PROPLIST_ENTRY)
CHECK_FUNCTION_EXISTS(asprintf HAVE_ASPRINTF)
CHECK_FUNCTION_EXISTS(backtrace HAVE_BACKTRACE)
CHECK_FUNCTION_EXISTS(backtrace_symbols HAVE_BACKTRACE_SYMBOLS)
CHECK_FUNCTION_EXISTS(bcopy HAVE_BCOPY)
# CHECK_FUNCTION_EXISTS(chflags HAVE_CHFLAGS)
CHECK_FUNCTION_EXISTS(closefrom HAVE_CLOSEFROM)
CHECK_FUNCTION_EXISTS(dlerror HAVE_DLERROR)
CHECK_FUNCTION_EXISTS(dyld_func_looku HAVE_DYLD_FUNC_LOOKU)
CHECK_FUNCTION_EXISTS(extattr_get_file HAVE_EXTATTR_GET_FILE)
CHECK_FUNCTION_EXISTS(extattr_get_link HAVE_EXTATTR_GET_LINK)
CHECK_FUNCTION_EXISTS(extattr_list_file HAVE_EXTATTR_LIST_FILE)
CHECK_FUNCTION_EXISTS(extattr_list_link HAVE_EXTATTR_LIST_LINK)
CHECK_FUNCTION_EXISTS(extattr_namespace_to_string HAVE_EXTATTR_NAMESPACE_TO_STRING)
CHECK_FUNCTION_EXISTS(extattr_set_file HAVE_EXTATTR_SET_FILE)
CHECK_FUNCTION_EXISTS(extattr_set_link HAVE_EXTATTR_SET_LINK)
CHECK_FUNCTION_EXISTS(extattr_string_to_namespace HAVE_EXTATTR_STRING_TO_NAMESPACE)
CHECK_FUNCTION_EXISTS(fchdir HAVE_FCHDIR)
CHECK_FUNCTION_EXISTS(fchmod HAVE_FCHMOD)
CHECK_FUNCTION_EXISTS(fchown HAVE_FCHOWN)
CHECK_FUNCTION_EXISTS(fchownat HAVE_FCHOWNAT)
CHECK_FUNCTION_EXISTS(fdatasync HAVE_FDATASYNC)
CHECK_FUNCTION_EXISTS(fork HAVE_FORK)
CHECK_FUNCTION_EXISTS(fseeko HAVE_FSEEKO)
CHECK_FUNCTION_EXISTS(fstatat HAVE_FSTATAT)
CHECK_FUNCTION_EXISTS(futimens HAVE_FUTIMENS)
CHECK_FUNCTION_EXISTS(futimes HAVE_FUTIMES)
CHECK_FUNCTION_EXISTS(futimesat HAVE_FUTIMESAT)
CHECK_FUNCTION_EXISTS(fwprintf HAVE_FWPRINTF)
CHECK_FUNCTION_EXISTS(gai_strerror HAVE_GAI_STRERROR)
CHECK_FUNCTION_EXISTS(getaddrinfo HAVE_GETADDRINFO)
CHECK_FUNCTION_EXISTS(getcwd HAVE_GETCWD)
CHECK_FUNCTION_EXISTS(getea HAVE_GETEA)
CHECK_FUNCTION_EXISTS(getegid HAVE_GETEGID)
CHECK_FUNCTION_EXISTS(geteuid HAVE_GETEUID)
CHECK_FUNCTION_EXISTS(getgid HAVE_GETGID)
CHECK_FUNCTION_EXISTS(gethostbyname2 HAVE_GETHOSTBYNAME2)
CHECK_FUNCTION_EXISTS(gethostbyname_r HAVE_GETHOSTBYNAME_R)
CHECK_FUNCTION_EXISTS(gethostid HAVE_GETHOSTID)
CHECK_FUNCTION_EXISTS(gethostname HAVE_GETHOSTNAME)
CHECK_FUNCTION_EXISTS(getmntent HAVE_GETMNTENT)
CHECK_FUNCTION_EXISTS(getmntinfo HAVE_GETMNTINFO)
CHECK_FUNCTION_EXISTS(getpagesize HAVE_GETPAGESIZE)
CHECK_FUNCTION_EXISTS(getpid HAVE_GETPID)
CHECK_FUNCTION_EXISTS(getproplist HAVE_GETPROPLIST)
CHECK_FUNCTION_EXISTS(gettimeofday HAVE_GETTIMEOFDAY)
CHECK_FUNCTION_EXISTS(getuid HAVE_GETUID)
CHECK_FUNCTION_EXISTS(getxattr HAVE_GETXATTR)
CHECK_FUNCTION_EXISTS(get_proplist_entry HAVE_GET_PROPLIST_ENTRY)
CHECK_FUNCTION_EXISTS(glfs_readdirplus HAVE_GLFS_READDIRPLUS)
CHECK_FUNCTION_EXISTS(glob HAVE_GLOB)
CHECK_FUNCTION_EXISTS(gnutls_cipher_init HAVE_GNUTLS_CIPHER_INIT)
CHECK_FUNCTION_EXISTS(gnutls_transport_set_int HAVE_GNUTLS_TRANSPORT_SET_INT)
CHECK_FUNCTION_EXISTS(iconv HAVE_ICONV)
CHECK_FUNCTION_EXISTS(inet_ntop HAVE_INET_NTOP)
CHECK_FUNCTION_EXISTS(inet_pton HAVE_INET_PTON)
CHECK_FUNCTION_EXISTS(lchmod HAVE_LCHMOD)
CHECK_FUNCTION_EXISTS(lchown HAVE_LCHOWN)
CHECK_FUNCTION_EXISTS(lgetea HAVE_LGETEA)
CHECK_FUNCTION_EXISTS(lgetxattr HAVE_LGETXATTR)
CHECK_FUNCTION_EXISTS(listea HAVE_LISTEA)
CHECK_FUNCTION_EXISTS(listxattr HAVE_LISTXATTR)
CHECK_FUNCTION_EXISTS(llistea HAVE_LLISTEA)
CHECK_FUNCTION_EXISTS(llistxattr HAVE_LLISTXATTR)
CHECK_FUNCTION_EXISTS(localtime_r HAVE_LOCALTIME_R)
CHECK_FUNCTION_EXISTS(lsetea HAVE_LSETEA)
CHECK_FUNCTION_EXISTS(lsetxattr HAVE_LSETXATTR)
CHECK_FUNCTION_EXISTS(lstat HAVE_LSTAT)
CHECK_FUNCTION_EXISTS(lutimes HAVE_LUTIMES)
CHECK_FUNCTION_EXISTS(malloc_trim HAVE_MALLOC_TRIM)
CHECK_FUNCTION_EXISTS(mempcpy HAVE_MEMPCPY)
CHECK_FUNCTION_EXISTS(munmap HAVE_MUNMAP)
CHECK_FUNCTION_EXISTS(nanosleep HAVE_NANOSLEEP)
CHECK_FUNCTION_EXISTS(nl_langinfo HAVE_NL_LANGINFO)
CHECK_FUNCTION_EXISTS(nvlist_next_nvpair HAVE_NVLIST_NEXT_NVPAIR)
CHECK_FUNCTION_EXISTS(openat HAVE_OPENAT)
CHECK_FUNCTION_EXISTS(poll HAVE_POLL)
CHECK_FUNCTION_EXISTS(posix_fadvise HAVE_POSIX_FADVISE)
CHECK_FUNCTION_EXISTS(prctl HAVE_PRCTL)
CHECK_FUNCTION_EXISTS(putenv HAVE_PUTENV)
CHECK_FUNCTION_EXISTS(readdir_r HAVE_READDIR_R)
CHECK_FUNCTION_EXISTS(select HAVE_SELECT)
CHECK_FUNCTION_EXISTS(setea HAVE_SETEA)
CHECK_FUNCTION_EXISTS(setenv HAVE_SETENV)
CHECK_FUNCTION_EXISTS(setlocale HAVE_SETLOCALE)
CHECK_FUNCTION_EXISTS(setpgid HAVE_SETPGID)
CHECK_FUNCTION_EXISTS(setpgrp HAVE_SETPGRP)
CHECK_FUNCTION_EXISTS(setproplist HAVE_SETPROPLIST)
CHECK_FUNCTION_EXISTS(setreuid HAVE_SETREUID)
CHECK_FUNCTION_EXISTS(setsid HAVE_SETSID)
CHECK_FUNCTION_EXISTS(setxattr HAVE_SETXATTR)
CHECK_FUNCTION_EXISTS(hl_loa HAVE_HL_LOA)
CHECK_FUNCTION_EXISTS(signal HAVE_SIGNAL)
CHECK_FUNCTION_EXISTS(sizeof_proplist_entry HAVE_SIZEOF_PROPLIST_ENTRY)
CHECK_FUNCTION_EXISTS(snprintf HAVE_SNPRINTF)
CHECK_FUNCTION_EXISTS(sqlite3_threadsafe HAVE_SQLITE3_THREADSAFE)
CHECK_FUNCTION_EXISTS(stpcpy HAVE_STPCPY)
CHECK_FUNCTION_EXISTS(strcasecmp HAVE_STRCASECMP)
CHECK_FUNCTION_EXISTS(strdup HAVE_STRDUP)
CHECK_FUNCTION_EXISTS(strerror HAVE_STRERROR)
CHECK_FUNCTION_EXISTS(strerror_r HAVE_STRERROR_R)
CHECK_FUNCTION_EXISTS(strftime HAVE_STRFTIME)
CHECK_FUNCTION_EXISTS(strncmp HAVE_STRNCMP)
CHECK_FUNCTION_EXISTS(strncpy HAVE_STRNCPY)
CHECK_FUNCTION_EXISTS(strtoll HAVE_STRTOLL)
CHECK_FUNCTION_EXISTS(strtoul HAVE_STRTOUL)
CHECK_FUNCTION_EXISTS(tcgetattr HAVE_TCGETATTR)
CHECK_FUNCTION_EXISTS(tsearch HAVE_TSEARCH)
CHECK_FUNCTION_EXISTS(unlinkat HAVE_UNLINKAT)
CHECK_FUNCTION_EXISTS(utimes HAVE_UTIMES)
CHECK_FUNCTION_EXISTS(vfprintf HAVE_VFPRINTF)
CHECK_FUNCTION_EXISTS(vprintf HAVE_VPRINTF)
CHECK_FUNCTION_EXISTS(vsnprintf HAVE_VSNPRINTF)
CHECK_FUNCTION_EXISTS(wcslen HAVE_WCSLEN)
CHECK_FUNCTION_EXISTS(__argz_count HAVE___ARGZ_COUNT)
CHECK_FUNCTION_EXISTS(__argz_next HAVE___ARGZ_NEXT)
CHECK_FUNCTION_EXISTS(__argz_stringify HAVE___ARGZ_STRINGIFY)
CHECK_FUNCTION_EXISTS(__fsetlocking HAVE___FSETLOCKING)





INCLUDE (CheckSymbolExists)
CHECK_SYMBOL_EXISTS(poll poll.h HAVE_POLL)
CHECK_SYMBOL_EXISTS(alloca alloca.h HAVE_ALLOCA)

# trick for socklen_t
set(CMAKE_EXTRA_INCLUDE_FILES "sys/socket.h")
check_type_size("socklen_t" HAVE_SOCKLEN_T)
set(CMAKE_EXTRA_INCLUDE_FILES)


set(CMAKE_EXTRA_INCLUDE_FILES sys/socket.h)


# configure options
# bool options
option(support_ndmp "enable build of NDMP support" "ON")
option(support_ldmb "enable build of LMDB support" "ON")
option(libtool "enable building using GNU libtool" "ON")
option(includes "enable installing of include files" "no")
option(support_bat "enable build of bat Qt4 GUI" "no")
option(TRAYMONITOR "enable build of traymonitor" "no")
option(support_smartalloc "enable smartalloc debugging support" "ON")
option(support_lockmgr "enable lock manager support" "no")
option(developer-mode "enable developer mode" "no")
option(static-tools "enable static tape tools" "no")
option(static-fd "enable static File daemon" "no")
option(static-sd "enable static Storage daemon" "no")
option(static-dir "enable static Director" "no")
option(static-cons "enable static Console" "no")
option(build_client-only "build client (File daemon) only" "no")
option(build-dird "enable building of dird (Director)" "ON")
option(build-stored "enable building of stored (Storage daemon)" "ON")
option(dynamic-storage-backends "enable dynamic loading of storage backends" "no")
option(conio "disable conio support" "no")
option(ipv6 "enable ipv6 support" "ON")
option(readline "disable readline support" "ON")
option(readline "specify readline library directory")
option(tcp-wrappers "enable tcpwrappers support")

# path options
#set(CONFDIR \"${CMAKE_INSTALL_FULL_SYSCONFDIR}\" CACHE PATH "specify directory for Bareos configuration files")



#set(archivedir  "/tmp"  CACHE PATH "specify path of SD archive directory")
#set(scriptdir "" CACHE PATH "specify path of Bareos scripts directory")
#set(backenddir "" CACHE PATH "specify path of Bareos backends directory")
#set(bsrdir "" CACHE PATH "specify path of Bareos bsrs directory")
#set(plugindir "" CACHE PATH "specify path of Bareos plugins directory")
#set(configtemplatedir "" CACHE PATH "specify path of Bareos configuration templates directory (Debian only)")
#
#set(basename "bareos" CACHE STRING "specify base resource name for daemons")
#set(hostname "bareos" CACHE STRING "specify host name for daemons")




option(dynamic-debian-package-list "generate debian/control depending on configured options" "no")
#option(python "Include Python support. DIR is the Python base install directory, default is to search through a number of common places for the Python files.")

option(crypto "disable crypto support" "auto")
option(tls "disable TLS support" "auto")
option(openssl "Include OpenSSL support. DIR is the OpenSSL base")
option(gnutls "Include GNUTLS support. DIR is the GNUTLS base")
option(dump-email=EMAIL "dump email address")
option(job-email=EMAIL "job output email address")
option(smtp-host=HOST "SMTP mail host address")
option(pid-dir=PATH "specify location of Bareos pid files")
option(subsys-dir=PATH "specify location of Bareos subsys file")
option(baseport=PORT "specify base port address for daemons")
option(dir-password "specify Director's password")
option(fd-password "specify Client's password")
option(sd-password "specify Storage daemon's password")
option(mon-dir-password "specify Director's password used by the monitor")
option(mon-fd-password "specify Client's password used by the monitor")
option(mon-sd-password "specify Storage daemon's password used by the monitor")


#option(db_name "specify database name" bareos)
#option(db_user "specify database user" bareos)
#option(db_password "specify database password" "")
#option(db_port "specify a database port" "null")

#option(dir_user "specify user for Director daemon" "")
#option(dir_group "specify group for Director daemon" "")
#option(sd_user "specify user for Storage daemon" "")
#option(sd_group "specify group for Storage daemon" "")
#option(fd_user "specify user for File daemon" "")
option(fd_group "specify group for File daemon" "")

option(sbin-perm "specify permissions for sbin binaries" "0750")
option(batch-insert "enable the DB batch insert code" "ON")
option(dynamic-cats-backends "enable dynamic loading of catalog backends" "no")
option(sql-pooling "enable sql pooling support" "no")
option(zlib "Directory holding zlib includes/libs")
option(lzo "Directory holding lzo includes/libs")
option(fastlz "Directory holding fastlz includes/libs")
option(jansson "Directory holding jansson includes/libs")
option(afs "disable afs support" "auto")
option(afsdir "Directory holding AFS includes/libs")
option(acl "disable acl support" "auto")
#option(xattr "disable xattr support" "auto")
option(scsi-crypto "enable low level SCSI crypto support" "no")
option(glusterfs "Directory holding GLUSTERFS includes/libs")
option(droplet "Directory holding DROPLET includes/libs")
option(rados "Directory holding RADOS includes/libs")
option(rados-striper "Directory holding RADOS striper includes/libs")
option(cephfs "Directory holding CEPHFS includes/libs")
option(elasto "Directory holding ELASTO includes/libs")
option(systemd "Include systemd support. UNITDIR is where systemd system .service files are located, default is to ask systemctl.")










# ------------------------- Begin Generic CMake Variable Logging ------------------

# /*	C++ comment style not allowed	*/


# if you are building in-source, this is the same as CMAKE_SOURCE_DIR, otherwise
# this is the top level directory of your build tree
MESSAGE( STATUS "CMAKE_BINARY_DIR:         " ${CMAKE_BINARY_DIR} )

# if you are building in-source, this is the same as CMAKE_CURRENT_SOURCE_DIR, otherwise this
# is the directory where the compiled or generated files from the current CMakeLists.txt will go to
MESSAGE( STATUS "CMAKE_CURRENT_BINARY_DIR: " ${CMAKE_CURRENT_BINARY_DIR} )

# this is the directory, from which cmake was started, i.e. the top level source directory
MESSAGE( STATUS "CMAKE_SOURCE_DIR:         " ${CMAKE_SOURCE_DIR} )

# this is the directory where the currently processed CMakeLists.txt is located in
MESSAGE( STATUS "CMAKE_CURRENT_SOURCE_DIR: " ${CMAKE_CURRENT_SOURCE_DIR} )

# contains the full path to the top level directory of your build tree
MESSAGE( STATUS "PROJECT_BINARY_DIR: " ${PROJECT_BINARY_DIR} )

# contains the full path to the root of your project source directory,
# i.e. to the nearest directory where CMakeLists.txt contains the PROJECT() command
MESSAGE( STATUS "PROJECT_SOURCE_DIR: " ${PROJECT_SOURCE_DIR} )

# set this variable to specify a common place where CMake should put all executable files
# (instead of CMAKE_CURRENT_BINARY_DIR)
MESSAGE( STATUS "EXECUTABLE_OUTPUT_PATH: " ${EXECUTABLE_OUTPUT_PATH} )

# set this variable to specify a common place where CMake should put all libraries
# (instead of CMAKE_CURRENT_BINARY_DIR)
MESSAGE( STATUS "LIBRARY_OUTPUT_PATH:     " ${LIBRARY_OUTPUT_PATH} )

# tell CMake to search first in directories listed in CMAKE_MODULE_PATH
# when you use FIND_PACKAGE() or INCLUDE()
MESSAGE( STATUS "CMAKE_MODULE_PATH: " ${CMAKE_MODULE_PATH} )

# this is the complete path of the cmake which runs currently (e.g. /usr/local/bin/cmake)
MESSAGE( STATUS "CMAKE_COMMAND: " ${CMAKE_COMMAND} )

# this is the CMake installation directory
MESSAGE( STATUS "CMAKE_ROOT: " ${CMAKE_ROOT} )

# this is the filename including the complete path of the file where this variable is used.
MESSAGE( STATUS "CMAKE_CURRENT_LIST_FILE: " ${CMAKE_CURRENT_LIST_FILE} )

# this is linenumber where the variable is used
MESSAGE( STATUS "CMAKE_CURRENT_LIST_LINE: " ${CMAKE_CURRENT_LIST_LINE} )

# this is used when searching for include files e.g. using the FIND_PATH() command.
MESSAGE( STATUS "CMAKE_INCLUDE_PATH: " ${CMAKE_INCLUDE_PATH} )

# this is used when searching for libraries e.g. using the FIND_LIBRARY() command.
MESSAGE( STATUS "CMAKE_LIBRARY_PATH: " ${CMAKE_LIBRARY_PATH} )

# the complete system name, e.g. "Linux-2.4.22", "FreeBSD-5.4-RELEASE" or "Windows 5.1"
MESSAGE( STATUS "CMAKE_SYSTEM: " ${CMAKE_SYSTEM} )

# the short system name, e.g. "Linux", "FreeBSD" or "Windows"
MESSAGE( STATUS "CMAKE_SYSTEM_NAME: " ${CMAKE_SYSTEM_NAME} )

# only the version part of CMAKE_SYSTEM
MESSAGE( STATUS "CMAKE_SYSTEM_VERSION: " ${CMAKE_SYSTEM_VERSION} )

# the processor name (e.g. "Intel(R) Pentium(R) M processor 2.00GHz")
MESSAGE( STATUS "CMAKE_SYSTEM_PROCESSOR: " ${CMAKE_SYSTEM_PROCESSOR} )

# is TRUE on all UNIX-like OS's, including Apple OS X and CygWin
MESSAGE( STATUS "UNIX: " ${UNIX} )

# is TRUE on Windows, including CygWin
MESSAGE( STATUS "WIN32: " ${WIN32} )

# is TRUE on Apple OS X
MESSAGE( STATUS "APPLE: " ${APPLE} )

# is TRUE when using the MinGW compiler in Windows
MESSAGE( STATUS "MINGW: " ${MINGW} )

# is TRUE on Windows when using the CygWin version of cmake
MESSAGE( STATUS "CYGWIN: " ${CYGWIN} )

# is TRUE on Windows when using a Borland compiler
MESSAGE( STATUS "BORLAND: " ${BORLAND} )

# Microsoft compiler
MESSAGE( STATUS "MSVC: " ${MSVC} )
MESSAGE( STATUS "MSVC_IDE: " ${MSVC_IDE} )
MESSAGE( STATUS "MSVC60: " ${MSVC60} )
MESSAGE( STATUS "MSVC70: " ${MSVC70} )
MESSAGE( STATUS "MSVC71: " ${MSVC71} )
MESSAGE( STATUS "MSVC80: " ${MSVC80} )
MESSAGE( STATUS "CMAKE_COMPILER_2005: " ${CMAKE_COMPILER_2005} )


# set this to true if you don't want to rebuild the object files if the rules have changed,
# but not the actual source files or headers (e.g. if you changed the some compiler switches)
MESSAGE( STATUS "CMAKE_SKIP_RULE_DEPENDENCY: " ${CMAKE_SKIP_RULE_DEPENDENCY} )

# since CMake 2.1 the install rule depends on all, i.e. everything will be built before installing.
# If you don't like this, set this one to true.
MESSAGE( STATUS "CMAKE_SKIP_INSTALL_ALL_DEPENDENCY: " ${CMAKE_SKIP_INSTALL_ALL_DEPENDENCY} )

# If set, runtime paths are not added when using shared libraries. Default it is set to OFF
MESSAGE( STATUS "CMAKE_SKIP_RPATH: " ${CMAKE_SKIP_RPATH} )

# set this to true if you are using makefiles and want to see the full compile and link
# commands instead of only the shortened ones
MESSAGE( STATUS "CMAKE_VERBOSE_MAKEFILE: " ${CMAKE_VERBOSE_MAKEFILE} )

# this will cause CMake to not put in the rules that re-run CMake. This might be useful if
# you want to use the generated build files on another machine.
MESSAGE( STATUS "CMAKE_SUPPRESS_REGENERATION: " ${CMAKE_SUPPRESS_REGENERATION} )


# A simple way to get switches to the compiler is to use ADD_DEFINITIONS().
# But there are also two variables exactly for this purpose:

# the compiler flags for compiling C sources
MESSAGE( STATUS "CMAKE_C_FLAGS: " ${CMAKE_C_FLAGS} )

# the compiler flags for compiling C++ sources
MESSAGE( STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS} )


# Choose the type of build.  Example: SET(CMAKE_BUILD_TYPE Debug)
MESSAGE( STATUS "CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE} )

# if this is set to ON, then all libraries are built as shared libraries by default.
MESSAGE( STATUS "BUILD_SHARED_LIBS: " ${BUILD_SHARED_LIBS} )

# the compiler used for C files
MESSAGE( STATUS "CMAKE_C_COMPILER: " ${CMAKE_C_COMPILER} )

# the compiler used for C++ files
MESSAGE( STATUS "CMAKE_CXX_COMPILER: " ${CMAKE_CXX_COMPILER} )

# if the compiler is a variant of gcc, this should be set to 1
MESSAGE( STATUS "CMAKE_COMPILER_IS_GNUCC: " ${CMAKE_COMPILER_IS_GNUCC} )

# if the compiler is a variant of g++, this should be set to 1
MESSAGE( STATUS "CMAKE_COMPILER_IS_GNUCXX : " ${CMAKE_COMPILER_IS_GNUCXX} )

# the tools for creating libraries
MESSAGE( STATUS "CMAKE_AR: " ${CMAKE_AR} )
MESSAGE( STATUS "CMAKE_RANLIB: " ${CMAKE_RANLIB} )
#


# execute lsb_release and set LSB_RELEASE_ID_SHORT
find_program(LSB_RELEASE lsb_release)
execute_process(COMMAND ${LSB_RELEASE} -is
    OUTPUT_VARIABLE LSB_RELEASE_ID_SHORT
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(COMMAND ${LSB_RELEASE} -ds
    OUTPUT_VARIABLE LSB_RELEASE_DESCRIPTION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(COMMAND ${LSB_RELEASE} -sr
    OUTPUT_VARIABLE LSB_RELEASE_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)


set(Host "${CMAKE_SYSTEM} ${LSB_RELEASE_DESCRIPTION}")
set(Distribution ${LSB_RELEASE_ID_SHORT})

#${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LOCALSTATEDIR}/${CMAKE_PROJECT_    NAME}


set(uncomment_dbi "#")

set(srcdir ${PROJECT_SOURCE_DIR})

set(bindir ${CMAKE_INSTALL_FULL_BINDIR})
set(sbindir ${CMAKE_INSTALL_FULL_SBINDIR})
set(libdir ${CMAKE_INSTALL_FULL_LIBDIR})
set(sysconfdir ${CMAKE_INSTALL_FULL_SYSCONFDIR})
set(confdir "${sysconfdir}/${CMAKE_PROJECT_NAME}")
set(CONFDIR "\"${confdir}\"")

set(scriptdir "${CMAKE_INSTALL_PREFIX}/usr/lib/${CMAKE_PROJECT_NAME}/scripts")
set(archivedir "${CMAKE_INSTALL_PREFIX}/tmp")
set(working_dir "${CMAKE_INSTALL_FULL_LOCALSTATEDIR}/${CMAKE_PROJECT_NAME}/working")
set(logdir "${CMAKE_INSTALL_FULL_LOCALSTATEDIR}/${CMAKE_PROJECT_NAME}/logs")
set(piddir "${CMAKE_INSTALL_PREFIX}/var/tmp")
set(subsysdir "${CMAKE_INSTALL_PREFIX}/var/lock/subsys")
set(datarootdir ${CMAKE_INSTALL_FULL_DATAROOTDIR})
set(mandir ${CMAKE_INSTALL_FULL_MANDIR})

set(backenddir ${CMAKE_INSTALL_FULL_LIBDIR})
set(plugindir ${CMAKE_INSTALL_FULL_LIBDIR})


set(CC ${CMAKE_C_COMPILER})
set(CCVERSION ${CMAKE_CXX_COMPILER_VERSION})
set(CXX ${CMAKE_CXX_COMPILER})
set(CXXVERSION ${CMAKE_CXX_COMPILER_VERSION})

set(job_email "root@localhost")
set(dump_email "root@localhost")
set(smtp_host "localhost")


set(dir_port "9101" )
set(fd_port "9102" )
set(sd_port "9103" )

set(dir_user "" )
set(dir_group "" )
set(sd_user "" )
set(sd_group "" )
set(fd_user "" )
set(fd_group "" )

IF( "${HAVE_OPENSSL}" OR "${HAVE_GNUTLS}")
   set(HAVE_TLS "1")
ENDIF()


set(largefile_support "" )
set(got_conio "" )
set(got_readline "${READLINE_FOUND}" )
set(have_tls "${HAVE_TLS}" )
set(have_crypto "${HAVE_CRYPTO}" )
set(have_openssl "${HAVE_OPENSSL}" )
set(have_gnutls "${HAVE_GNUTLS}" )
set(have_zlib "${ZLIB_FOUND}" )
set(have_lzo "${HAVE_LZO}" )
set(have_fastlz "${HAVE_FASTLZLIB_H}" )
set(have_jansson "${HAVE_JANSSON_H}" )
set(support_lmdb "${support_ndmp}" )
set(support_ndmp "${support_lmdb}" )
set(support_smartalloc "${support_smartalloc}" )
set(support_lockmgr "${support_lockmgr}" )
set(support_bat "${support_bat}" )
set(support_traymonitor "${support_traymonitor}" )
set(build_client_only "${build_client_only}" )
set(build_dird "${build-dird}" )
set(build_stored "${build-stored}" )
set(have_plugins "${have_plugins}" )
set(have_afs "" )
set(have_acl "" )
set(have_xattr ${HAVE_SYS_XATTR_H} )
set(have_scsi_crypto "" )
set(have_glusterfs "" )
set(have_droplet "" )
set(have_ceph_rados "" )
set(have_ceph_rados_striper "" )
set(have_cephfs "" )
set(have_elasto "" )
set(support_python "${PYTHONLIBS_FOUND} ${PYTHONLIBS_VERSION_STRING} ${PYTHON_INCLUDE_PATH}" )
set(support_systemd "" )
set(batch_insert_db_backends "" )
set(have_cmocka "" )

set(_PATH_BAREOS_BACKENDDIR \"${backenddir}\")
set(_PATH_BAREOS_PIDDIR \"${piddir}\")
set(_PATH_BAREOS_WORKINGDIR \"${working_dir}\")

set(DISTNAME ${LSB_RELEASE_ID_SHORT})
set(DISTVER ${LSB_RELEASE_VERSION})

# give configure output


MESSAGE(" ")
MESSAGE("Configuration on `date`: ")
MESSAGE(" ")

MESSAGE("   Host:                         ${host}${post_host} -- ${DISTNAME} ${DISTVER} ")
MESSAGE("   Bareos version:               ${BAREOS} ${VERSION} (${DATE}) ")
MESSAGE("   Distribution:                 ${DISTNAME} ")
MESSAGE("   Source code location:         ${srcdir} ")
MESSAGE("   Modify package list:          ${DEBIAN_CONTROL} ")
MESSAGE("   Install binaries:             ${bindir} ")
MESSAGE("   Install system binaries:      ${sbindir} ")
MESSAGE("   Install libraries:            ${libdir} ")
MESSAGE("   Install system config files:  ${sysconfdir} ")
MESSAGE("   Install Bareos config files:  ${confdir} ")
MESSAGE("   Scripts directory:            ${scriptdir} ")
MESSAGE("   Archive directory:            ${archivedir} ")
MESSAGE("   Working directory:            ${working_dir} ")
MESSAGE("   PID directory:                ${piddir} ")
MESSAGE("   Subsys directory:             ${subsysdir} ")
MESSAGE("   Man directory:                ${mandir} ")
MESSAGE("   Data directory:               ${datarootdir} ")
MESSAGE("   Backend directory:            ${backenddir} ")
MESSAGE("   Plugin directory:             ${plugindir} ")
MESSAGE("   C Compiler:                   ${CC} ${CCVERSION} ")
MESSAGE("   C++ Compiler:                 ${CXX} ${CXXVERSION} ")
MESSAGE("   Compiler flags:               ${CMAKE_CXX_FLAGS} ")
MESSAGE("   Linker flags:                 ${CMAKE_EXE_LINKER_FLAGS} ${CMAKE_MODULE_LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS} ${CMAKE_STATIC_LINKER_FLAGS} ")
MESSAGE("   Libraries:                    ${LIBS} ")
MESSAGE("   Statically Linked Tools:      ${support_static_tools} ")
MESSAGE("   Statically Linked FD:         ${support_static_fd} ")
MESSAGE("   Statically Linked SD:         ${support_static_sd} ")
MESSAGE("   Statically Linked DIR:        ${support_static_dir} ")
MESSAGE("   Statically Linked CONS:       ${support_static_cons} ")
MESSAGE("   Database backends:            ${db_backends} ")
MESSAGE("   Database port:                ${db_port} ")
MESSAGE("   Database name:                ${db_name} ")
MESSAGE("   Database user:                ${db_user} ")
MESSAGE("   Database version:             ${BDB_VERSION} ")
MESSAGE(" ")
MESSAGE("   Job Output Email:             ${job_email} ")
MESSAGE("   Traceback Email:              ${dump_email} ")
MESSAGE("   SMTP Host Address:            ${smtp_host} ")
MESSAGE(" ")
MESSAGE("   Director Port:                ${dir_port} ")
MESSAGE("   File daemon Port:             ${fd_port} ")
MESSAGE("   Storage daemon Port:          ${sd_port} ")
MESSAGE(" ")
MESSAGE("   Director User:                ${dir_user} ")
MESSAGE("   Director Group:               ${dir_group} ")
MESSAGE("   Storage Daemon User:          ${sd_user} ")
MESSAGE("   Storage DaemonGroup:          ${sd_group} ")
MESSAGE("   File Daemon User:             ${fd_user} ")
MESSAGE("   File Daemon Group:            ${fd_group} ")
MESSAGE(" ")
MESSAGE("   Large file support:           ${largefile_support}")
MESSAGE("   Bareos conio support:         ${got_conio} ${CONS_LIBS} ")
MESSAGE("   readline support:             ${got_readline} ")
MESSAGE("   TCP Wrappers support:         ${HAVE_TCPD_H} ")
MESSAGE("   TLS support:                  ${have_tls} ")
MESSAGE("   Encryption support:           ${have_crypto} ")
MESSAGE("   OpenSSL support:              ${have_openssl} ")
MESSAGE("   GNUTLS support:               ${have_gnutls} ")
MESSAGE("   ZLIB support:                 ${have_zlib} ")
MESSAGE("   LZO support:                  ${have_lzo} ")
MESSAGE("   FASTLZ support:               ${have_fastlz} ")
MESSAGE("   JANSSON support:              ${have_jansson} ")
MESSAGE("   LMDB support:                 ${support_lmdb} ")
MESSAGE("   NDMP support:                 ${support_ndmp} ")
MESSAGE("   enable-smartalloc:            ${support_smartalloc} ")
MESSAGE("   enable-lockmgr:               ${support_lockmgr} ")
MESSAGE("   bat support:                  ${support_bat} ")
MESSAGE("   tray-monitor support:         ${support_traymonitor} ")
MESSAGE("   client-only:                  ${build_client_only} ")
MESSAGE("   build-dird:                   ${build_dird} ")
MESSAGE("   build-stored:                 ${build_stored} ")
MESSAGE("   Plugin support:               ${have_plugins} ")
MESSAGE("   AFS support:                  ${have_afs} ")
MESSAGE("   ACL support:                  ${have_acl} ")
MESSAGE("   XATTR support:                ${have_xattr} ")
MESSAGE("   SCSI Crypto support:          ${have_scsi_crypto} ")
MESSAGE("   GLUSTERFS support:            ${have_glusterfs} ")
MESSAGE("   DROPLET support:              ${have_droplet} ")
MESSAGE("   CEPH RADOS support:           ${have_ceph_rados} ")
MESSAGE("   RADOS striping support:       ${have_ceph_rados_striper} ")
MESSAGE("   CEPHFS support:               ${have_cephfs} ")
MESSAGE("   ELASTO support:               ${have_elasto} ")
MESSAGE("   Python support:               ${support_python}")
MESSAGE("   systemd support:              ${support_systemd} ${SYSTEMD_UNITDIR} ")
MESSAGE("   Batch insert enabled:         ${batch_insert_db_backends} ")
MESSAGE("   cmocka support:               ${have_cmocka} ")

# install log and working dir
INSTALL(CODE "FILE(MAKE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LOCALSTATEDIR}/${CMAKE_PROJECT_NAME}/logs)")
INSTALL(CODE "FILE(MAKE_DIRECTORY ${working_dir})")




CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.in
               ${CMAKE_CURRENT_SOURCE_DIR}/src/include/config.h)


CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/manpages/Makefile.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/manpages/Makefile @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-config.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-config @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-config-lib.sh.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-config-lib.sh @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-explorer.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-explorer @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-glusterfind-wrapper.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-glusterfind-wrapper @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/btraceback.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/btraceback @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bconsole.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bconsole @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-dir.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-dir @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-fd.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-fd @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-sd.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bareos-ctl-sd @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/devel_bareos.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/devel_bareos @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/Makefile.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/Makefile @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/logrotate.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/logrotate @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/mtx-changer.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/mtx-changer @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/disk-changer.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/disk-changer @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/logwatch/Makefile.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/logwatch/Makefile @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/logwatch/logfile.bareos.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/logwatch/logfile.bareos.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/scripts/bat.console_apps.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/bat.console_apps @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/include/host.h.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/include/host.h @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/console/bconsole.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/console/bconsole.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/bareos-tray-monitor.desktop.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/bareos-tray-monitor.desktop @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/tray-monitor.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/tray-monitor.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/tray-monitor.pro.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-tray-monitor/tray-monitor.pro @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.desktop.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.desktop @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.pro.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/bat.pro @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/install_conf_file.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/qt-console/install_conf_file @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/catalog/MyCatalog.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/catalog/MyCatalog.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/client/bareos-fd.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/client/bareos-fd.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/console/bareos-mon.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/console/bareos-mon.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/director/bareos-dir.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/director/bareos-dir.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/Catalog.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/Catalog.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/LinuxAll.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/LinuxAll.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/SelfTest.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/fileset/SelfTest.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/job/BackupCatalog.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/job/BackupCatalog.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/jobdefs/DefaultJob.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/jobdefs/DefaultJob.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/messages/Daemon.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/messages/Daemon.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/messages/Standard.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/messages/Standard.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/storage/File.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-dir.d/storage/File.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/device/FileStorage.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/device/FileStorage.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/director/bareos-dir.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/director/bareos-dir.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/director/bareos-mon.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/director/bareos-mon.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/storage/bareos-sd.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-sd.d/storage/bareos-sd.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/client/myself.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/client/myself.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/director/bareos-dir.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/director/bareos-dir.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/director/bareos-mon.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/bareos-fd.d/director/bareos-mon.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/client/FileDaemon-local.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/client/FileDaemon-local.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/director/Director-local.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/director/Director-local.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/monitor/bareos-mon.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/monitor/bareos-mon.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/storage/StorageDaemon-local.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/tray-monitor.d/storage/StorageDaemon-local.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/dird/bareos-dir.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/dird/bareos-dir.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/filed/bareos-fd.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/filed/bareos-fd.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_catalog_backup.pl.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_catalog_backup.pl @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_catalog_backup.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_catalog_backup @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/delete_catalog_backup.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/delete_catalog_backup @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/create_bareos_database.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/create_bareos_database @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/update_bareos_tables.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/update_bareos_tables @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/grant_bareos_privileges.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/grant_bareos_privileges @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_bareos_tables.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/make_bareos_tables @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/drop_bareos_tables.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/drop_bareos_tables @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/drop_bareos_database.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/drop_bareos_database @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/install-default-backend.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/install-default-backend @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/cats/ddl/versions.map.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/cats/ddl/versions.map @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/plugins/filed/python-ldap-conf.d/bareos-dir.d/fileset/plugin-ldap.conf.example.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/plugins/filed/python-ldap-conf.d/bareos-dir.d/fileset/plugin-ldap.conf.example @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/diskonly/bareos-sd.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/diskonly/bareos-sd.conf @ONLY)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/diskonly/bareos-dir.conf.in
                 ${CMAKE_CURRENT_SOURCE_DIR}/src/defaultconfigs/diskonly/bareos-dir.conf @ONLY)











add_subdirectory(scripts)
add_subdirectory(manpages)
add_subdirectory(src)
