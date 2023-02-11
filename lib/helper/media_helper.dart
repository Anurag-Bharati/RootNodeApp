import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MediaHelper {
  static get instance {
    _helper ??= MediaHelper();
    return _helper;
  }

  static MediaHelper? _helper;
  final ImagePicker? _imagePicker;
  final ImageCropper? _imageCropper;
  MediaHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<List<XFile>> pickMultipleImages(
          {ImageSource source = ImageSource.gallery,
          int imageQuality = 80}) async =>
      await _imagePicker!.pickMultiImage(
        imageQuality: imageQuality,
      );
  Future<XFile?> pickVideo(
          {ImageSource source = ImageSource.gallery,
          int imageQuality = 80}) async =>
      await _imagePicker!
          .pickVideo(source: source, maxDuration: const Duration(minutes: 30));

  Future<XFile?> pickImage(
          {ImageSource source = ImageSource.camera,
          int imageQuality = 80}) async =>
      await _imagePicker!.pickImage(source: source, imageQuality: imageQuality);

  Future<CroppedFile?> crop(
          {required XFile file,
          CropStyle cropStyle = CropStyle.rectangle,
          int compressQuality = 100}) async =>
      await _imageCropper!.cropImage(
        sourcePath: file.path,
        compressQuality: compressQuality,
        cropStyle: cropStyle,
      );
}
