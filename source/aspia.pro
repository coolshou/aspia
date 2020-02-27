
include(aspia_proto.pro)
include(aspia-common.pro)
include(aspia-console.pro)
include(aspia-host.pro)

DISTFILES += \
    debian/aspia-docs.docs \
    debian/control \
    debian/copyright \
    debian/changelog \
    debian/rules \
    debian/README.Debian \
    debian/README.source \
    debian/source/format \
    common/translations/aspia_common_de.ts \
    common/translations/aspia_common_nl.ts \
    common/translations/aspia_common_pt_BR.ts \
    common/translations/aspia_common_ru.ts \
    common/translations/aspia_common_uk.ts

HEADERS += \
    build/build_config.h \
    build/version.h \
    common/win/file_enumerator.h



win32{
    CONFIG -= \
        embed_manifest_exe
    RC_FILE = \
        build/version.rc
}

