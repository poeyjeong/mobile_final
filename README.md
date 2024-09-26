## Android Studio
1. Click ที่ **More Actions** เลือก **SDK Manager**
2. Click ที่ **SDK Tools** และโหลด Android SDK Command-line Tools (lastest)

## json_server

1. https://pub.dev/packages/json_server/install
2. cd lib\assets
3. json-server --host 172.16.43.62 --port 3000 data.json
>เช็คว่ามี git อยู่ในเครื่องไหม พิมพ์ `git --version` ใน Terminal หากไม่มีให้ download ที่ [Downloads - Git](https://git-scm.com/downloads) หรือพิมพ์ `dart pub global activate json_server`

## Error ที่อาจพบ

**ไม่สามารถโหลด json_server ได้เนื่องจาก SDK sever** 

1. พิมพ์ `flutter doctor -v` ใน Terminal เพื่อแสดง SDK path
2. `cd <flutter_sdk_path>`
3. `git checkout <version>`

**เชื่อมต่อ server.json ไม่ได้**

1. 
