cmake_minimum_required(VERSION 3.19)

# Grib project

project(grib C)
include(CTest)


# Build SRC FILES

add_executable(grib.out src/grib_message.c)
target_link_libraries(grib.out eccodes)


# Test TEST FILES

enable_testing()
add_executable(test.out test/test.c)
add_test(Mytest test.out)



# project(test C)
# add_executable(test.out src/main.c src/test.c)