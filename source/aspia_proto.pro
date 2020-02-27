
message("Generating protocol buffer classes from .proto files.")

#protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/addressbook.proto

PROTOFILES += \
    proto/common.proto \
    proto/desktop_extensions.proto \
    proto/desktop_internal.proto \
    proto/desktop.proto \
    proto/file_transfer.proto \
    proto/host.proto \
    proto/key_exchange.proto \
    proto/system_info.proto \
    proto/address_book.proto

# protoc.exe --cpp_out=./ *.proto


#protobuf_decl.name = protobuf headers
#protobuf_decl.input = PROTOS
#protobuf_decl.output = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.h
#protobuf_decl.commands = protoc --cpp_out=${QMAKE_FILE_IN_PATH} --proto_path=${QMAKE_FILE_IN_PATH} ${QMAKE_FILE_NAME}
#protobuf_decl.variable_out = HEADERS
#QMAKE_EXTRA_COMPILERS += protobuf_decl
