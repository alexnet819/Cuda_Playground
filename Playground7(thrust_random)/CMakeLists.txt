CMAKE_MINIMUM_REQUIRED(VERSION 3.18)
project(Cuda_Playground7 CXX)
message("project name is automaically set as: ${PROJECT_NAME}")

set(PROJECT_VERSION 1.0.0)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_OPTIMIZE_DEPENDENCIES ON)

set(CMAKE_BUILD_TYPE RelWithDebInfo)


# For CUDAToolkit
# Cudaのライブラリを検索する
# CUDAToolkit.cmakeというファイルがcmakeのディレクトリのどこかにあり、そのファイルの設定を読み込む
find_package(CUDAToolkit REQUIRED)
#find_package(CUDNN)


# CUDAToolkitが見つかった場合はCUDA言語を有効化する
if(CUDAToolkit_FOUND)
	enable_language(CUDA)
endif()

# GPUのアーキクチャを指定する
set(CMAKE_CUDA_ARCHITECTURES 89)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_EXTENSIONS OFF)
set(CUDA_LINK_LIBRARIES_KEYWORD PUBLIC)
set(CMAKE_CUDA_SEPARABLE_COMPILATION ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# 実行ファイルの生成
# add_executable(Main main.cu)
add_subdirectory(Rand)
add_executable(Main main.cu)
target_link_libraries(Main PRIVATE rand ${CUDA_LIBRARIES})

#arget_link_libraries(Main CUDAToolkit::cudart)


MESSAGE(STATUS "--------------------------------------------")
MESSAGE(STATUS "Info :")
MESSAGE(STATUS "  Project Name = ${PROJECT_NAME}")
MESSAGE(STATUS "  Version =     ${PROJECT_VERSION}")
MESSAGE(STATUS "  CMAKE_VERSION =        ${CMAKE_VERSION}")
MESSAGE(STATUS "  CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
MESSAGE(STATUS "  CMAKE_BUILD_TYPE =     ${CMAKE_BUILD_TYPE}")
MESSAGE(STATUS "  CMAKE_INSTALL_LIBDIR = ${CMAKE_INSTALL_LIBDIR}")
message(STATUS "  PCL_VERSION =          ${PCL_VERSION}")
message(STATUS "  -- CUDA --")
message(STATUS "    Version: " ${CUDAToolkit_VERSION})
message(STATUS "    Library: " ${CUDAToolkit_LIBRARY_DIR})
message(STATUS "    Include: " ${CUDAToolkit_INCLUDE_DIRS})