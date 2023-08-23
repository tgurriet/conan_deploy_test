cmake_minimum_required(VERSION 3.16)
project(my_app VERSION 1.0.0 LANGUAGES CXX)

find_package(my_lib 1.0 REQUIRED)

# Static library
add_executable(my_app src/app.cpp)
target_link_libraries(my_app PUBLIC
  my_lib::my_lib
)
