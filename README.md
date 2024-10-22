# radio_app

A radio app in flutter using a icecast audio stream. 

## Requirements 

- Working and running android emulator 
  - tested with Android 14
- Flutter Version >= 3.24.3
- Dart Version >= 3.5.3
- Docker Version >= 27.0.3

## Start

1. Installing the dependencies:
````bash
flutter pub get
````

2. Start the WireMock as REST Stubbing:
```bash
cd wiremock

# Linux
docker run -it --rm \
  -p 8080:8080 \
  -v $PWD/stubs:/home/wiremock \
  wiremock/wiremock:3.9.1
  
# Powershell
docker run -it --rm -p 8080:8080 -v ${PWD}/stubs:/home/wiremock wiremock/wiremock:3.9.1
```


3.Running the application:
```bash
flutter run
```



