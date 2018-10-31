#
# srecord - Manipulate EPROM load files
# Copyright (C) 2018 Scott Finneran
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

# Build Documentation and man pages
configure_file(${CMAKE_SOURCE_DIR}/script/groff.sh ${CMAKE_BINARY_DIR}/groff.sh COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/etc/ref-ptx.sh  ${CMAKE_BINARY_DIR}/ref_ptx.sh COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/etc/new.sh  ${CMAKE_BINARY_DIR}/new.sh COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/etc/build_ref_index.sh
  ${CMAKE_BINARY_DIR}/build_ref_index.sh COPYONLY)

set(GROFF sh ${CMAKE_BINARY_DIR}/groff.sh)
set(NEW_CH sh ${CMAKE_BINARY_DIR}/new.sh)
set(REF_PTX sh ${CMAKE_BINARY_DIR}/ref_ptx.sh)
set(BUILD_REF_INDEX sh ${CMAKE_BINARY_DIR}/build_ref_index.sh)

# man pages
file(GLOB_RECURSE MAN_PAGES RELATIVE ${CMAKE_SOURCE_DIR} "man/man*/*.[135]")
file(GLOB_RECURSE MAN_COMMON RELATIVE ${CMAKE_SOURCE_DIR} "man/man*/[zo]_*.so")
file(GLOB_RECURSE NEW_CHANGE_NOTES RELATIVE ${CMAKE_SOURCE_DIR} "etc/new.*.so")

FOREACH(m_src ${MAN_PAGES})
  set(m_target ${CMAKE_BINARY_DIR}/${m_src})
  add_custom_command(OUTPUT ${m_src}
    COMMAND ${GROFF} -I${CMAKE_SOURCE_DIR} -Tascii -t -man ${m_src} > ${m_target}
    DEPENDS ${m_src} ${MAN_COMMON}
    COMMENT "Building ${m_target}"
    VERBATIM)
  LIST(APPEND MAN_PAGE_OUTPUTS ${m_src})
ENDFOREACH(m_src)

add_custom_target(man ALL DEPENDS ${MAN_PAGE_OUTPUTS})

# Reference Manual Components
set(REF_INDEX ${CMAKE_BINARY_DIR}/doc/ref-index.so)
add_custom_command(OUTPUT ${REF_INDEX}
  COMMAND ${BUILD_REF_INDEX} ${CMAKE_SOURCE_DIR} ${REF_INDEX} ${MAN_PAGES}
  DEPENDS ${MAN_PAGES} ${CMAKE_SOURCE_DIR}/etc/ref-ptx.ignore ${CMAKE_SOURCE_DIR}/etc/ref-ptx1.awk ${CMAKE_SOURCE_DIR}/etc/ref-ptx2.awk
  COMMENT "Building ${REF_INDEX}"
  VERBATIM
  )

set(REF_PARTS ${CMAKE_BINARY_DIR}/doc/ref-parts.so)
add_custom_command(OUTPUT ${REF_PARTS}
  COMMAND ${REF_PTX} ${MAN_PAGES} > ${REF_PARTS}
  DEPENDS ${MAN_PAGES} ${CMAKE_SOURCE_DIR}/etc/ref-ptx.sh
  COMMENT "Building ${REF_PARTS}"
  VERBATIM
  )

set(NEW_CHANGES ${CMAKE_BINARY_DIR}/doc/new.so)
add_custom_command(OUTPUT ${NEW_CHANGES}
  COMMAND ${NEW_CH} -r ${NEW_CHANGE_NOTES} > ${NEW_CHANGES}
  DEPENDS ${NEW_CHANGE_NOTES} ${CMAKE_SOURCE_DIR}/etc/ref-ptx.sh
  COMMENT "Building ${NEW_CHANGES}"
  VERBATIM
  )

# Docs
set(DOC_TARGETS "")

FUNCTION(ADD_DOC T S DEPS)
  set(TARGET ${CMAKE_BINARY_DIR}/doc/${T})
  set(SRC ${CMAKE_SOURCE_DIR}/etc/${S})
  add_custom_command(OUTPUT ${TARGET}
    COMMAND ${GROFF} -Tps -s -I${CMAKE_SOURCE_DIR} -I${CMAKE_BINARY_DIR} -t -man ${SRC} > ${TARGET}.ps
    COMMAND ps2pdf ${TARGET}.ps ${TARGET}
    COMMAND rm ${TARGET}.ps
    DEPENDS ${SRC} ${DEPS}
    COMMENT "Building ${TARGET}"
    VERBATIM)
  LIST(APPEND DOC_TARGETS ${TARGET})
  set(DOC_TARGETS ${DOC_TARGETS} PARENT_SCOPE)
ENDFUNCTION(ADD_DOC)

# Target directories
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/doc)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/man)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/man/man1)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/man/man3)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/man/man5)

ADD_DOC(BUILDING.pdf BUILDING.man "")
ADD_DOC(README.pdf README.man "")
ADD_DOC(change_log.pdf change_log.man "${CMAKE_BINARY_DIR}/doc/new.so")
ADD_DOC(reference.pdf reference.man "${CMAKE_BINARY_DIR}/doc/ref-parts.so;${CMAKE_BINARY_DIR}/doc/ref-index.so")

add_custom_target(doco ALL DEPENDS ${DOC_TARGETS})
