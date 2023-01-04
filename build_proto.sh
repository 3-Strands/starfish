protoc --dart_out=grpc:lib/src/generated --proto_path=lib/src/generated/google -Iprotos protos/starfish.proto
protoc --dart_out=grpc:lib/src/generated --proto_path=lib/src/generated/google -Iprotos protos/file_transfer.proto
protoc --dart_out=grpc:lib/src/generated --proto_path=lib/src/generated/google -Iprotos protos/error_handling.proto
