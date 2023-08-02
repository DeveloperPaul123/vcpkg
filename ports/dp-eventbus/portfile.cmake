vcpkg_from_github(ARCHIVE
    OUT_SOURCE_PATH SOURCE_PATH
    REPO DeveloperPaul123/eventbus
    REF ${VERSION}
    SHA512 ed375c6aaa106abdb260fc6f3de17a89458dbf730ec7b9ac03ccb7c1e1c6c7cd84ad45cfa792a7e913c0df2bc2f7c2e3d1a3829daca884e46aa57687cc0928dc
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR "Ninja"
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DEVENTBUS_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
    PACKAGE_NAME eventbus
    CONFIG_PATH lib/cmake/eventbus-${VERSION}
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
