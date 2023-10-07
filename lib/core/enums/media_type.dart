enum MediaType {
  Photo,
  YoutubeURL,
  GIF,
  None;

  int get id => index + 1;

  @override
  String toString() => name;
}
