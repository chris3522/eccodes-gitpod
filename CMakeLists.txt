cmake_minimum_required(VERSION 3.19)

#project(test C)

#add_executable(test.out src/main.c src/test.c)

project(grib C)

add_executable(grib.out src/grib_message.c)
target_link_libraries(grib.out eccodes)