cmake_minimum_required(VERSION 3.22)
project(__GAME_ID__)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT DEFINED AXE_PLATFORM)
    set(AXE_PLATFORM "desktop")
endif()

if(NOT TARGET axe)
    add_subdirectory(../../engine engine)
endif()

function(copy_runtime_assets target_name)
    add_custom_command(TARGET ${target_name} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_CURRENT_SOURCE_DIR}/assets
            $<TARGET_FILE_DIR:${target_name}>/assets
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_CURRENT_SOURCE_DIR}/data
            $<TARGET_FILE_DIR:${target_name}>/data
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_CURRENT_SOURCE_DIR}/scripts
            $<TARGET_FILE_DIR:${target_name}>/scripts
        COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_CURRENT_SOURCE_DIR}/game.json
            $<TARGET_FILE_DIR:${target_name}>/game.json
        COMMAND ${CMAKE_COMMAND} -E make_directory
            $<TARGET_FILE_DIR:${target_name}>/third_party/bgfx.cmake/bgfx/examples/runtime
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_CURRENT_SOURCE_DIR}/../../engine/third_party/bgfx.cmake/bgfx/examples/runtime/shaders
            $<TARGET_FILE_DIR:${target_name}>/third_party/bgfx.cmake/bgfx/examples/runtime/shaders
    )
endfunction()

if(AXE_PLATFORM STREQUAL "desktop")
    add_executable(__GAME_ID__
        src/main_desktop.cpp
    )

    target_link_libraries(__GAME_ID__ PRIVATE axe)
    target_include_directories(__GAME_ID__ PRIVATE
        ../../engine/include
    )
    copy_runtime_assets(__GAME_ID__)
endif()
