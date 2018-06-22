# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/cisst)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jhu-cisst/cisst
    REF 1.0.10
    SHA512 a564a011ad3d0f9f46207678cc1447e4e20312620b33a76aca1836b2b042c6b9434e3b09312281372a4493015fe7fe0ee8db229101efe065ccb3999a1bc2f48b
    HEAD_REF master
)

set(HAS_QT5 OFF)
if("qt5" IN_LIST FEATURES)
    set(HAS_QT5 ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
        -DCISST_BUILD_APPLICATIONS=OFF
        -DCISST_HAS_CISSTNETLIB=OFF
        -DCISST_HAS_QT5=${HAS_QT5}
        -DCISST_cisstCommonXML=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
# Clean
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
# Handle copyright
file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/cisst RENAME copyright)
