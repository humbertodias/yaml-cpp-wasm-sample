cmake_minimum_required(VERSION 3.5)
project(wasm_yaml)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(yaml-cpp)
include_directories(yaml-cpp/include)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} yaml-cpp)

# target copy_data
add_custom_target(copy_data
    COMMAND ${CMAKE_COMMAND} -E copy
    "${CMAKE_SOURCE_DIR}/config.yaml"
    "${CMAKE_BINARY_DIR}/config.yaml"
    COMMENT "Copying config.yaml to build folder"
)
# always copy the file
add_dependencies(${PROJECT_NAME} copy_data)

if(EMSCRIPTEN)

    set(CMAKE_EXECUTABLE_SUFFIX ".html")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --preload-file config.yaml")
    # Define explicit output for the HTML file
    set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "index")

else()

    target_link_libraries(${PROJECT_NAME} yaml-cpp)

endif()