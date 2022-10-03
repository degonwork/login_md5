final String tableWard = 'ward';

class WardField {
  static final List<String> values = [
    name,
    type,
    slug,
    name_with_type,
    path,
    path_with_type,
    code,
    parent_code
  ];
  static final String name = 'name';
  static final String type = 'type';
  static final String slug = 'slug';
  static final String name_with_type = 'name_with_type';
  static final String path = 'path';
  static final String path_with_type = 'path_with_type';
  static final String code = 'code';
  static final String parent_code = 'parent_code';
}

class Ward {
  Ward({
    required this.name,
    required this.type,
    required this.slug,
    required this.name_with_type,
    required this.path,
    required this.path_with_type,
    required this.code,
    required this.parent_code,
  });

  final String? name;
  final TypeWard? type;
  final String? slug;
  final String? name_with_type;
  final String? path;
  final String? path_with_type;
  final int? code;
  final int? parent_code;

  static Ward fromJson(Map<String, dynamic> json) => Ward(
        name: json["name"],
        type: typeValues.map[json["type"]],
        slug: json["slug"],
        name_with_type: json["name_with_type"],
        path: json["path"],
        path_with_type: json["path_with_type"],
        code: json["code"],
        parent_code: json["parent_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": typeValues.reverse[type],
        "slug": slug,
        "name_with_type": name_with_type,
        "path": path,
        "path_with_type": path_with_type,
        "code": code,
        "parent_code": parent_code,
      };
}

enum TypeWard { PHUONG, THI_TRAN, XA }

final typeValues = EnumValues({
  "phuong": TypeWard.PHUONG,
  "thi-tran": TypeWard.THI_TRAN,
  "xa": TypeWard.XA,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
