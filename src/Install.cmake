# Yep, that's it!
target_compile_options(ImGui-SFML PRIVATE     -w)
target_compile_options(sfml-graphics PRIVATE -w)
target_compile_options(sfml-audio PRIVATE    -w)
target_compile_options(sfml-system PRIVATE   -w)

target_link_libraries(imgui-sfml-example
    PUBLIC
    ImGui-SFML::ImGui-SFML
)

include(GNUInstallDirs)

install(TARGETS imgui-sfml-example
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Installing is not easy, when we're dealing with shared libs
if(NOT LINK_DEPS_STATIC)
    set_target_properties(imgui-sfml-example PROPERTIES
        INSTALL_RPATH $ORIGIN/../${CMAKE_INSTALL_LIBDIR}
    )

    set_target_properties(
        ImGui-SFML
        sfml-graphics sfml-system sfml-window
        PROPERTIES
        INSTALL_RPATH $ORIGIN
    )

    install(TARGETS
        ImGui-SFML
        sfml-graphics sfml-system sfml-window
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        NAMELINK_SKIP # don't need versionless .so's
    )
endif()
if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(TARGET CMakeSFMLProject POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:CMakeSFMLProject> $<TARGET_FILE_DIR:CMakeSFMLProject> COMMAND_EXPAND_LISTS)
endif()

#install(SCRIPT PostInstall.cmake)

include(CPack)