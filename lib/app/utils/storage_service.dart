import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:unorm_dart/unorm_dart.dart" as unorm;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String category, String imageName) async {
    print(unorm.nfc('$category/$imageName'));
    String downloadURL =
        await storage.ref(unorm.nfd('$category/$imageName')).getDownloadURL();

    return downloadURL;
  }
}
