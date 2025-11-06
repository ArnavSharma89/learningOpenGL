cmake_minimum_required(VERSION 3.16)

# Allow older dependencies (GLAD 1.x etc.) to build with modern CMake
set(CMAKE_POLICY_VERSION_MINIMUM 3.5)

project(graphics LANGUAGES C CXX)

# -------------------------------
#  Compiler and build settings
# -------------------------------
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(FetchContent)

# -------------------------------
#  GLFW (window & input)
# -------------------------------
FetchContent_Declare(
        glfw
        GIT_REPOSITORY https://github.com/glfw/glfw.git
        GIT_TAG 3.4
)

# -------------------------------
#  GLAD 1.x (OpenGL loader)
# -------------------------------
FetchContent_Declare(
        glad
        GIT_REPOSITORY https://github.com/Dav1dde/glad.git
        GIT_TAG v0.1.36
)

# -------------------------------
#  GLM (math library)
# -------------------------------
FetchContent_Declare(
        glm
        GIT_REPOSITORY https://github.com/g-truc/glm.git
        GIT_TAG 1.0.1
)

# Download and make dependencies available
FetchContent_MakeAvailable(glfw glad glm)

# -------------------------------
#  Find OpenGL
# -------------------------------
find_package(OpenGL REQUIRED)

# -------------------------------
#  Source files (auto-detect)
# -------------------------------
file(GLOB_RECURSE SRC_FILES CONFIGURE_DEPENDS
        src/*.cpp
        src/*.h
        src/*.c
        src/*.hpp
)

# -------------------------------
#  Executable target
# -------------------------------
add_executable(${PROJECT_NAME}
        ${SRC_FILES}
        src/vertex_shader.vs
        src/fragment_shader.fs
        src/Shader.h
)

## Copy shaders into build directory after building
#file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/src/vertex_shader.vs
#        DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
#file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/src/fragment_shader.fs
#        DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

# -------------------------------
#  Include directories
# -------------------------------
target_include_directories(${PROJECT_NAME} PRIVATE
        ${glad_SOURCE_DIR}/include
        ${glfw_SOURCE_DIR}/include
        ${glm_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# -------------------------------
#  Link libraries
# -------------------------------
target_link_libraries(${PROJECT_NAME}
        PRIVATE
        glfw
        glad
        glm
        OpenGL::GL
)

# -------------------------------
#  Windows-specific
# -------------------------------
if (WIN32)
    target_link_libraries(${PROJECT_NAME} PRIVATE gdi32)
endif ()

# -------------------------------
#  Status message
# -------------------------------
message(STATUS "")
message(STATUS "✅ Configured successfully with CMake ${CMAKE_VERSION}")
message(STATUS "   Using:")
message(STATUS "   • GLAD v0.1.36")
message(STATUS "   • GLFW 3.4")
message(STATUS "   • GLM 1.0.1")
message(STATUS "   • C++${CMAKE_CXX_STANDARD}")
message(STATUS "")
