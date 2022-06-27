
# Starfish

This repository contains code for 'Starfish' flutter application. The app uses gRPC to connect with the backend server.
The app has capabiilty to run offline.

- All user operations are saved locally first, and when user is connected to the internet, it will be synced with the backend,
- All manipulation of the data i.e calculation are done locally.



## Requirements

- Flutter 2.10.5 (stable)
- Android toolchain - develop for Android devices (Android SDK version 31.0.0)
- XCode - develop for iOS and macOS (Xcode 13.x)


## Quick Setup
- Clone this repo, checkout to `dev` branch
- Install dependencies
``` 
flutter pub get
```
- Create a folder `config_reader` in the root directory and put `app_config.json` file in that. Connect with the **admin** to get this config file. 
- Build application for android
```
flutter build apk --flavor dev -t lib/main_dev.dart --no-sound-null-safety
```
```
flutter build apk --flavor prod -t lib/main_prod.dart --no-sound-null-safety
```
- run application for android
```
flutter run -d {device_id}/all --flavor dev -t lib/main_dev.dart --no-sound-null-safety
```
```
flutter run -d {device_id}/all --flavor prod -t lib/main_prod.dart --no-sound-null-safety
```
## Hive Database
In order to store data locally 'Hive' is used. Hive is a NoSQL database. All data stored in Hive is organized in boxes.
In order to store the objects received form `gRPC` custom objects are created by extending `HiveObject`. 

In order to store custom objects, we have to register a `TypeAdapter` wich converts the objects from and to binary form.

Any update in the table fields should be bollowed by the followed by following command so that `TypeAdapter` can ge re-generated.

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```


## gRPC
gRPC allows client application to directly call a method on a server application on a different machine as if it were a local object, making it easier for you to create distributed applications and services. 

### Protocol Buffers
gRPC uses `Protocol Buffers` for serializing structured data. Protocol buffer is an ordinary text file with `.proto` extension, that defines the structure for the data to be serialized.

### Compiling Protocol Buffers
Protocol Buffers file, `.proto` file, in to be compiled in order to generate data access classes in prererred language, `dart` in our case, from the proto definition. All proto files are stored in the `proto` folder in the root directory.
Run following command form the `{root_directory}/proto` directory:

```
$ protoc --dart_out=grpc:lib/src/generated -Iprotos protos/{protofile_name}.proto
```



## Error Reporting

`Sentry` is used to report any error primarily related to gRPC.

In order to configure the Sentry just create a project in `Sentry.io` and update the `_dsn` i.e. project URL in `main_dev.dart` for development and `main_prod.dart` for production environment respectively.
```
const String _dsn =
    'https://{{}}.ingest.sentry.io/{{}}';
```
