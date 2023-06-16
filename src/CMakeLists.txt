set(SOURCE_FILES
    main.cpp
)
set(HEADER_FILES
)
add_executable(imgui-sfml-example
    ${SOURCE_FILES} ${HEADER_FILES}
)
target_compile_features(imgui-sfml-example PRIVATE cxx_std_17)
include(Install.cmake)
