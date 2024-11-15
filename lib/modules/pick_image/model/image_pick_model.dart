// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImagePickModel {
  final String path;
  final String name;
  final String mime;
  const ImagePickModel({
    required this.path,
    required this.name,
    required this.mime,
  });

  @override
  bool operator ==(covariant ImagePickModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.path == path &&
      other.name == name &&
      other.mime == mime;
  }

  @override
  int get hashCode => path.hashCode ^ name.hashCode ^ mime.hashCode;
}
