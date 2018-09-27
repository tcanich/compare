# cmake version, project name, language
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(compare)
enable_language(Fortran)

# set output paths for modules, archives, and executables
set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/include)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# if build type not specified, default to release
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "release")
endif()

# compiler flags for gfortran
if(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -fbacktrace")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
endif()

# compiler flags for ifort
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -assume realloc_lhs -heap-arrays")
  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -C -traceback")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
endif()

# library to archive (libcompare.a)
add_library(compare src/lib/compare.f90)

# tests
enable_testing()
add_executable(compare_tests src/test/mod_testing.f90 src/test/test.f90)
target_link_libraries(compare_tests compare)
add_test(compare_tests bin/compare_tests)