# - Find LZO (lzo.h, liblzo2.a)
# This module defines
#  LZO_INCLUDE_DIR, directory containing headers
#  LZO_STATIC_LIB, path to libslzo2.a
#  HAVE_LZO, whether lzo has been found

find_path(LZO_INCLUDE_DIR NAMES lzo/lzoconf.h)

find_library(LZO_LIB  NAMES liblzo2.so)

if (LZO_LIB)
  if (LZO_INCLUDE_DIR)
    set(HAVE_LZO TRUE)
  else ()
    set(HAVE_LZO FALSE)
  endif()
else ()
  set(HAVE_LZO FALSE)
endif ()

if (HAVE_LZO)
  if (NOT LZO_FIND_QUIETLY)
    message(STATUS "Lzo Library ${LZO_LIB}")
    message(STATUS "Lzo Include Found in ${LZO_INCLUDE_DIR}")
  endif ()
else ()
  message(STATUS "Lzo includes and libraries NOT found. ")
endif ()

#mark_as_advanced(
#  LZO_INCLUDE_DIR
#  LZO_LIBS
#  HAVE_LZO
#)
