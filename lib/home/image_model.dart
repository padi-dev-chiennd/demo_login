class ImageModel {
  final int id;
  String name;
  final String path;
  final double size;
  late final bool isAsset;

  ImageModel({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'size': size,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      size: map['size'],
    );
  }
}
