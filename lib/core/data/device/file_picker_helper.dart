import 'package:image_picker/image_picker.dart';
import 'package:masaj/core/domain/exceptions/exceed_file_size_limit_exception.dart';

enum PickerType {
  camera,
  galleryImage,
  galleryVideo,
  attachment,
}

abstract class FileSize {
  static const size512KB = 524288;
  static const size1MB = 1048576;
  static const size2MB = 2097152;
  static const size5MB = 5242880;
  static const size10MB = 10485760;
  static const size25MB = 26214400;
  static const size50MB = 52428800;
}

abstract class FilePickerHelper {
  static const _compressionPercentage = 40;
  final PickerType _type;

  ///returns `filePath`
  Future<String> pick();

  FilePickerHelper(this._type);

  factory FilePickerHelper.gallery() => _GalleryImagePicker();

  factory FilePickerHelper.camera() => _CameraPicker();

  PickerType get type => _type;
}

class _GalleryImagePicker extends FilePickerHelper {
  _GalleryImagePicker() : super(PickerType.galleryImage);

  @override
  Future<String> pick() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: FilePickerHelper._compressionPercentage,
    );

    if (pickedImage == null) throw Exception('User didn\'t pick an image');

    final imageSize = await pickedImage.length();

    if (imageSize > FileSize.size5MB) {
      throw ExceedFileSizeLimitException(fileSizeLimit: FileSize.size5MB);
    }

    return pickedImage.path;
  }
}

class _CameraPicker extends FilePickerHelper {
  _CameraPicker() : super(PickerType.camera);

  @override
  Future<String> pick() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: FilePickerHelper._compressionPercentage,
    );

    if (pickedImage == null) throw Exception('User didn\'t pick an image');

    final imageSize = await pickedImage.length();

    if (imageSize > FileSize.size5MB) {
      throw ExceedFileSizeLimitException(fileSizeLimit: FileSize.size5MB);
    }

    return pickedImage.path;
  }
}
