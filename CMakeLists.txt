cmake_minimum_required(VERSION 2.8.7)
project(appl)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules")

enable_language(D)

set(SOURCE_FILES appl.d)

add_executable(appl ${SOURCE_FILES})