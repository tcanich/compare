# cmake version, project name, language
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(compare)
enable_language(Fortran)

# set output paths for modules, archives, and executables
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/include)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

file ( STRINGS ".VERSION" VERSION )
string( REPLACE "." ";" VERSION_LIST ${VERSION} )
list(GET VERSION_LIST 0 VERSION_MAJOR)
list(GET VERSION_LIST 1 VERSION_MINOR)
list(GET VERSION_LIST 2 VERSION_PATCH)
set(PROJECT_VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")
string ( TOLOWER ${CMAKE_PROJECT_NAME}-${CMAKE_Fortran_COMPILER_ID} PACKAGE_NAME )
set(PACKAGE_VERSION "${PACKAGE_NAME}-${VERSION}" )
message ( STATUS "CMake build configuration for libcompare ${PROJECT_VERSION}" )
file(STRINGS "URL" PROJECT_URL )

# if build type not specified, default to release
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()

# compiler flags for gfortran
if(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -Wall -Wextra -fbacktrace -fprofile-arcs -ftest-coverage")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3" )
endif()

# compiler flags for ifort
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -assume realloc_lhs -heap-arrays")
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -traceback")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
endif()

set (USE_GNU_INSTALL_CONVENTION FALSE
  CACHE BOOL
  "Install library, module file, and documentation to standard GNU locations.  Do not use this if supporting multiple Fortran compilers." 
  )

if (USE_GNU_INSTALL_CONVENTION)
  set ( EXPORT_INSTALL_DIR "${INSTALL_LIB_DIR}/cmake/${PACKAGE_VERSION}" )
else ()
  set ( INSTALL_MOD_DIR "${PACKAGE_VERSION}/include" )
  set ( INSTALL_LIB_DIR "${PACKAGE_VERSION}/lib" )
  set ( ABS_LIB_INSTALL_DIR "\${CMAKE_INSTALL_PREFIX}/${INSTALL_LIB_DIR}" )
  set ( EXPORT_INSTALL_DIR "${PACKAGE_VERSION}/cmake" )
endif ()

set(CMAKE_SOURCE_DIR src )

# library to archive (libcompare)
# Build shared and static libraries
set ( LC_LIB_SRCS ${CMAKE_SOURCE_DIR}/lib/compare.f90 )
file ( GLOB LC_TEST_SRCS "${CMAKE_SOURCE_DIR}/test/*.f90" )
set ( LIB_NAME ${CMAKE_PROJECT_NAME} )
add_library(${LIB_NAME} SHARED ${LC_LIB_SRCS} )
add_library(${LIB_NAME}-static STATIC ${LC_LIB_SRCS} )

set_target_properties ( ${LIB_NAME}
  PROPERTIES
  OUTPUT_NAME ${CMAKE_PROJECT_NAME}
  SOVERSION ${VERSION_MAJOR}.${VERSION_MINOR}
  INTERFACE_POSITION_INDEPENDENT_CODE ON
  VERSION ${VERSION} )
set_target_properties ( ${LIB_NAME}-static 
  PROPERTIES 
  OUTPUT_NAME ${CMAKE_PROJECT_NAME}
  VERSION ${VERSION} )

# tests
enable_testing()
add_executable(${CMAKE_PROJECT_NAME}_tests ${LC_TEST_SRCS} )
target_link_libraries(${CMAKE_PROJECT_NAME}_tests ${LIB_NAME} )
add_executable(${CMAKE_PROJECT_NAME}_tests-static ${LC_TEST_SRCS} )
target_link_libraries ( ${CMAKE_PROJECT_NAME}_tests-static ${LIB_NAME}-static "-static" )

add_test(${CMAKE_PROJECT_NAME}_tests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${CMAKE_PROJECT_NAME}_tests)
add_test(${CMAKE_PROJECT_NAME}_tests-static ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${CMAKE_PROJECT_NAME}_tests-static)

# install
install(DIRECTORY "${CMAKE_Fortran_MODULE_DIRECTORY}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
install(DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
install(TARGETS ${LIB_NAME} ${LIB_NAME}-static EXPORT ${PACKAGE_NAME}-targets LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}" ARCHIVE DESTINATION "${CMAKE_INSTALL_PREFIX}")


# Make this available to other CMake projects
install ( EXPORT ${PACKAGE_NAME}-targets DESTINATION "${EXPORT_INSTALL_DIR}" )

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/${PACKAGE_NAME}-config-version.cmake"
  VERSION ${VERSION}
  COMPATIBILITY SameMajorVersion
  )

configure_package_config_file (
  "${CMAKE_SOURCE_DIR}/cmake/pkg/${CMAKE_PROJECT_NAME}-config.cmake.in"
  "${CMAKE_BINARY_DIR}/pkg/${PACKAGE_NAME}-config.cmake"
  INSTALL_DESTINATION "${EXPORT_INSTALL_DIR}"
  PATH_VARS EXPORT_INSTALL_DIR INSTALL_MOD_DIR )

install ( FILES
  "${CMAKE_BINARY_DIR}/pkg/${PACKAGE_NAME}-config.cmake"
  "${CMAKE_BINARY_DIR}/${PACKAGE_NAME}-config-version.cmake"
  DESTINATION "${EXPORT_INSTALL_DIR}" )

export ( TARGETS ${LIB_NAME} ${LIB_NAME}-static FILE ${PACKAGE_NAME}-targets.cmake )

# build tree package config file, NOT installed
configure_file (
  "${CMAKE_SOURCE_DIR}/cmake/pkg/${CMAKE_PROJECT_NAME}-config.cmake.in"
  "${CMAKE_BINARY_DIR}/${PACKAGE_NAME}-config.cmake"
  @ONLY )

set ( ENABLE_BUILD_TREE_EXPORT FALSE CACHE BOOL
  "Add the ${PACKAGE_NAME} build tree to the CMake package registry?" )
if ( ENABLE_BUILD_TREE_EXPORT )
  export ( PACKAGE ${PACKAGE_NAME} )
endif ()

# pkg-config stuff
#configure_file(
#   "${CMAKE_CURRENT_SOURCE_DIR}/${LIB_NAME}.pc.cmake.in"
#   "${CMAKE_CURRENT_BINARY_DIR}/${LIB_NAME}.pc"
#   @ONLY
#)
#install(FILES
#   "${CMAKE_CURRENT_BINARY_DIR}/${LIB_NAME}.pc"
#   DESTINATION "${INSTALL_LIB_DIR}/pkgconfig"
#)
#
#if(MSVC_IDE)
#   INCLUDE_DIRECTORIES("src")
#   SET(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fpp")
#endif()
#
#
#install(
#  FILES "${CMAKE_CURRENT_BINARY_DIR}/compareConfig.cmake"
#  "${CMAKE_CURRENT_BINARY_DIR}/compareConfigVersion.cmake"
#  DESTINATION "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/cmake/compare"
#  )
