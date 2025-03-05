cmake_minimum_required(VERSION 3.10)
set(CMAKE_SYSTEM_NAME linux)
# set(CMAKE_SYSTEM_NAME darwin) # mac build
if(ARM_TARGET_LANG STREQUAL "gcc")
    set(ANDROID_ARM_NEON True)
    set(CMAKE_NDK_ROOT_TOOLCHAIN_VERSION ${ARM_TARGET_LANG})
    set(ANDROID_TOOLCHAIN gcc)
    set(CMAKE_TOOLCHAIN_FILE ${NDK_ROOT}/build/cmake/android.toolchain.cmake)
    set(CMAKE_C_FLAGS gcc)
    set(CMAKE_CXX_FLAGS g++)
endif()

if(ARM_TARGET_LANG STREQUAL "clang")
    set(ANDROID_ARM_NEON True)
    set(CMAKE_NDK_ROOT_TOOLCHAIN_VERSION ${ARM_TARGET_LANG})
    set(ANDROID_TOOLCHAIN clang)
    set(ANDROID_PLATFORM "android-21")
    if (${ARM_ABI} STREQUAL "arm64-v8a")
        set(CMAKE_C_COMPILER ${NDK_ROOT}/toolchains/llvm/prebuilt/${CMAKE_SYSTEM_NAME}-x86_64/bin/aarch64-linux-android21-clang)
        set(CMAKE_CXX_COMPILER ${NDK_ROOT}/toolchains/llvm/prebuilt/${CMAKE_SYSTEM_NAME}-x86_64/bin/aarch64-linux-android21-clang++)
    else()
        set(CMAKE_TOOLCHAIN_FILE ${NDK_ROOT}/build/cmake/android.toolchain.cmake)
    endif()
endif()

project(ppocr_demo)
message(STATUS "TARGET ARM LANG: ${ARM_TARGET_LANG}")
message(STATUS "TARGET ARCH ABI: ${ARM_ABI}")
message(STATUS "PADDLE LITE DIR: ${PADDLE_LITE_DIR}")
message(STATUS "PADDLE LITE DIR: ${OPENCV_LITE_DIR}")

set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# 1. path to Paddle-Lite lib
set(LITE_DIR "${PROJECT_SOURCE_DIR}/../../../../cxx")

# 2. link Paddle-Lite directory
link_directories(${LITE_DIR}/lib)

include_directories(${LITE_DIR}/include)

set(PaddleLite_LIBS ${LITE_DIR}/lib/libpaddle_light_api_shared.so)

#include_directories(${PADDLE_LITE_DIR}/include)
#message(STATUS "PaddleLite_LIBS is ${PaddleLite_LIBS}")

#set(OPENCV_PATH "${OPENCV_LITE_DIR}/${ARM_ABI}")
set(OPENCV_PATH "${CURRENT_DIR}/../3rd/libs/opencv")

message(STATUS "OPENCV_PATH: ${OPENCV_PATH}")
set(OPENCV_INCLUDE_DIRS "${OPENCV_PATH}/include/opencv4/")
set(OPENCV_LIBS ${OPENCV_PATH}/lib/libopencv_imgcodecs.so.405
                    ${OPENCV_PATH}/lib/libopencv_imgproc.so.405
                    ${OPENCV_PATH}/lib/libopencv_core.so.405)
include_directories(${OPENCV_INCLUDE_DIRS})

add_executable(ppocr_demo pipeline.cc utils.cc cls_process.cc rec_process.cc det_process.cc clipper.cpp db_post_process.cc)
target_link_libraries(ppocr_demo ${OPENCV_LIBS} ${PaddleLite_LIBS} -lz)
