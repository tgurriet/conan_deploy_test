cmake_minimum_required(VERSION 3.16)
project(my_lib VERSION 0.7.0 LANGUAGES CXX)

# ---------------------------------------------------------------------------------------
# INCLUDES
# ---------------------------------------------------------------------------------------
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

find_package(httplib 0.12.2 REQUIRED)

# Static library
add_library(my_lib STATIC src/my_lib.cpp)
target_include_directories(my_lib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(my_lib PUBLIC
  httplib::httplib
)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/my_lib
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  TARGETS my_lib
  EXPORT my_lib_targets
)

install(
  EXPORT my_lib_targets
  FILE my_libTargets.cmake
  NAMESPACE my_lib::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/my_lib
)
