TEMPLATE = app
TARGET = aspia-console

QT += gui widgets

CONFIG += lrelease

HEADERS += \
    client/client_authenticator.h \
    client/client_config.h \
    client/client_desktop.h \
    client/client_file_transfer.h \
    client/client.h \
    client/config_factory.h \
    client/desktop_control_proxy.h \
    client/desktop_control.h \
    client/desktop_window_proxy.h \
    client/desktop_window.h \
    client/file_control_proxy.h \
    client/file_control.h \
    client/file_manager_window_proxy.h \
    client/file_manager_window.h \
    client/file_remove_queue_builder.h \
    client/file_remove_window_proxy.h \
    client/file_remove_window.h \
    client/file_remover_proxy.h \
    client/file_remover.h \
    client/file_transfer_proxy.h \
    client/file_transfer_queue_builder.h \
    client/file_transfer_window_proxy.h \
    client/file_transfer_window.h \
    client/file_transfer.h \
    client/frame_factory_qimage.h \
    client/frame_factory.h \
    client/status_window_proxy.h \
    client/status_window.h \
    client/ui/address_bar_model.h \
    client/ui/address_bar.h \
    client/ui/authorization_dialog.h \
    client/ui/client_dialog.h \
    client/ui/client_window.h \
    client/ui/desktop_config_dialog.h \
    client/ui/desktop_panel.h \
    client/ui/desktop_settings.h \
    client/ui/desktop_widget.h \
    client/ui/file_error_code.h \
    client/ui/file_item_delegate.h \
    client/ui/file_list_model.h \
    client/ui/file_list.h \
    client/ui/file_manager_settings.h \
    client/ui/file_mime_data.h \
    client/ui/file_name_validator.h \
    client/ui/file_panel.h \
    client/ui/file_path_validator.h \
    client/ui/file_remove_dialog.h \
    client/ui/file_transfer_dialog.h \
    client/ui/qt_desktop_window.h \
    client/ui/qt_file_manager_window.h \
    client/ui/select_screen_action.h \
    client/ui/status_dialog.h \
    client/ui/system_info_window.h \
    client/ui/tree_to_html.h

SOURCES += \
    client/client_authenticator.cc \
    client/client_config.cc \
    client/client_desktop.cc \
    client/client_file_transfer.cc \
    client/client.cc \
    client/config_factory.cc \
    client/desktop_control_proxy.cc \
    client/desktop_window_proxy.cc \
    client/file_control_proxy.cc \
    client/file_manager_window_proxy.cc \
    client/file_remove_queue_builder.cc \
    client/file_remove_window_proxy.cc \
    client/file_remover_proxy.cc \
    client/file_remover.cc \
    client/file_transfer_proxy.cc \
    client/file_transfer_queue_builder.cc \
    client/file_transfer_window_proxy.cc \
    client/file_transfer.cc \
    client/frame_factory_qimage.cc \
    client/status_window_proxy.cc \
    client/ui/address_bar_model.cc \
    client/ui/address_bar.cc \
    client/ui/authorization_dialog.cc \
    client/ui/client_dialog.cc \
    client/ui/client_window.cc \
    client/ui/desktop_config_dialog.cc \
    client/ui/desktop_panel.cc \
    client/ui/desktop_settings.cc \
    client/ui/desktop_widget.cc \
    client/ui/file_error_code.cc \
    client/ui/file_item_delegate.cc \
    client/ui/file_list_model.cc \
    client/ui/file_list.cc \
    client/ui/file_manager_settings.cc \
    client/ui/file_mime_data.cc \
    client/ui/file_name_validator.cc \
    client/ui/file_panel.cc \
    client/ui/file_path_validator.cc \
    client/ui/file_remove_dialog.cc \
    client/ui/file_transfer_dialog.cc \
    client/ui/qt_desktop_window.cc \
    client/ui/qt_file_manager_window.cc \
    client/ui/status_dialog.cc \
    client/ui/system_info_window.cc \
    client/ui/tree_to_html.cc

RESOURCES += \
    client/resources/client.qrc \
    client/translations/client_translations.qrc

EXTRA_TRANSLATIONS += \
    client/translations/aspia_client_de.ts \
    client/translations/aspia_client_nl.ts \
    client/translations/aspia_client_pt_BR.ts \
    client/translations/aspia_client_ru.ts \
    client/translations/aspia_client_uk.ts

FORMS += \
    client/ui/authorization_dialog.ui \
    client/ui/client_dialog.ui \
    client/ui/desktop_config_dialog.ui \
    client/ui/desktop_panel.ui \
    client/ui/file_panel.ui \
    client/ui/file_remove_dialog.ui \
    client/ui/file_transfer_dialog.ui \
    client/ui/qt_file_manager_window.ui \
    client/ui/status_dialog.ui \
    client/ui/system_info_window.ui
