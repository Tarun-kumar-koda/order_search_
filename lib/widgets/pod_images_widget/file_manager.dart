import 'package:image_picker/image_picker.dart';

import '../../Utils/logger.dart';

enum PICK_IMAGE { GALLERY, CAMERA }

class FileManager {
  String? path;

  static String? getTempFile() {
    throw UnimplementedError();
  }

  /// returns image [XFile] path given by the device
  static Future<XFile?> imageHandler({PICK_IMAGE mode = PICK_IMAGE.CAMERA}) async {
    XFile? imgPath;
    try {
      final ImagePicker picker = ImagePicker();
      switch (mode) {
        case PICK_IMAGE.GALLERY:
          imgPath = await picker.pickImage(source: ImageSource.gallery);
          break;
        case PICK_IMAGE.CAMERA:
          imgPath = await picker.pickImage(source: ImageSource.camera);
          break;
      }
    } catch (ex) {
      Logger.logMessenger(msgTitle: "image picker helper class", errorMsg: {"exception": ex}, msgBody: {});
    }
    return imgPath;
  }
}
