class UrlHelper {
  String removeSignature(String url) => url.split('?').first;

  String getFileName(String url) {
    url = removeSignature(url);

    final fileNameWithExtension = url.split('/').last.split('.');
    final fileName = (fileNameWithExtension..removeLast()).join('.');
    return fileName;
  }

  String getFileExtension(String url) {
    url = removeSignature(url);

    final fileNameWithExtension = url.split('/').last.split('.');
    return fileNameWithExtension.last;

  }
}
