# cmake version, project name, language
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(compare)
enable_language(Fortran)

# set output paths for modules, archives, and executables
set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/include)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(LIB_NAME lib${project})

file ( STRINGS "${CMAKE_SOURCE_DIR}/.VERSION" VERSION )
string( REPLACE "." ";" VERSION_LIST ${VERSION} )
list(GET VERSION_LIST 0 VERSION_MAJOR)
list(GET VERSION_LIST 1 VERSION_MINOR)
list(GET VERSION_LIST 2 VERSION_PATCH)
set(PROJECT_VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")
message ( STATUS "CMake build configuration for libcompare ${PROJECT_VERSION}" )

# if build type not specified, default to release
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "release")
endif()

# compiler flags for gfortran
if(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -Wall -Wextra -fbacktrace -fprofile-arcs -ftest-coverage")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -fprofile-arcs -ftest-coverage")
endif()

# compiler flags for ifort
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -assume realloc_lhs -heap-arrays")
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -traceback")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
endif()

# library to archive (libcompare)
# Build shared and static libraries
add_library(${LIB_NAME} SHARED src/lib/compare.f90)
set_target_properties ( ${LIB_NAME}
  PROPERTIES
  OUTPUT_NAME ${LIB_NAME}
  SOVERSION ${VERSION_MAJOR}.${VERSION_MINOR}
  INTERFACE_POSITION_INDEPENDENT_CODE ON
  VERSION ${VERSION} )
add_library(${LIB_NAME}-static STATIC src/lib/compare.f90)
set_target_properties ( ${LIB_NAME}-static 
  PROPERTIES 
  OUTPUT_NAME ${LIB_NAME} 
  VERSION ${VERSION} )

# tests
enable_testing()
add_executable(compare_tests src/test/mod_testing.f90 src/test/test.f90)
target_link_libraries(compare_tests ${LIB_NAME})
add_executable(compare_tests-static src/test/mod_testing.f90 src/test/test.f90)
target_link_libraries(compare_tests-static ${LIB_NAME}-static "-static")

add_test(compare_tests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/compare_tests)
add_test(compare_tests-static ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/compare_tests-static)

# install
install(DIRECTORY "${CMAKE_Fortran_MODULE_DIRECTORY}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
install(DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
