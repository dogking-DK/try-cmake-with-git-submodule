cmake_minimum_required(VERSION 3.11)


project(try_git_submodule
        VERSION 0.0.1
        DESCRIPTION "try cmake with git submodule"
        LANGUAGES CXX
)

# build all examples into the bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# Change the default build type to Release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif(NOT CMAKE_BUILD_TYPE)

if (VULKAN_SDK)
    set(ENV{VULKAN_SDK} ${VULKAN_SDK})
endif()

# set the use of C++20 globally as all examples require it
set(CMAKE_CXX_STANDARD 20)

# 查找所有源文件 (.cpp 和 .hpp)
file(GLOB_RECURSE MAIN_SOURCES "src/main/*.cpp" "src/main/*.hpp" "src/main/*.h") # 主入口
file(GLOB_RECURSE CORE_SOURCES "src/core/*.cpp" "src/core/*.hpp" "src/core/*.h") # 核心
file(GLOB_RECURSE GPU_SOURCES "src/gpu/*.cpp" "src/gpu/*.hpp" "src/gpu/*.h")     # GPU相关
file(GLOB_RECURSE IO_SOURCES "src/io/*.cpp" "src/io/*.hpp" "src/io/*.h")         # IO相关
file(GLOB_RECURSE UI_SOURCES "src/ui/*.cpp" "src/ui/*.hpp" "src/ui/*.h")         # UI相关

# 输出所有的源文件路径
message(STATUS "Main sources: ${MAIN_SOURCES}")
message(STATUS "Core sources: ${CORE_SOURCES}")
message(STATUS "GPU sources: ${GPU_SOURCES}")
message(STATUS "IO sources: ${IO_SOURCES}")
message(STATUS "UI sources: ${UI_SOURCES}")

# 将所有的源文件加入到一个列表
set(ALL_SOURCES
    ${MAIN_SOURCES}
    ${CORE_SOURCES}
    ${GPU_SOURCES}
    ${IO_SOURCES}
    ${UI_SOURCES}
)

# 设置source_group保持文件夹结构
source_group(TREE ${CMAKE_SOURCE_DIR}/src PREFIX "src" FILES ${ALL_SOURCES})

# 添加可执行文件
add_executable(${PROJECT_NAME} ${ALL_SOURCES})

# 为目标添加 include 路径
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_SOURCE_DIR}/src/main
    ${CMAKE_SOURCE_DIR}/src/core
    ${CMAKE_SOURCE_DIR}/src/gpu
    ${CMAKE_SOURCE_DIR}/src/io
    ${CMAKE_SOURCE_DIR}/src/ui)



install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin         # 将可执行文件安装到 bin 目录
    LIBRARY DESTINATION lib         # 将共享库（如 DLL）安装到 lib 目录
    ARCHIVE DESTINATION lib         # 将静态库安装到 lib 目录
)