final String tableDistrict = 'district';

class DistrictField {
  static final List<String> values = [name, type, slug, path, id, parent_id];
  static final String name = 'name';
  static final String type = 'type';
  static final String slug = 'slug';
  static final String path = 'path';
  static final String id = 'id';
  static final String parent_id = 'parent_id';
}

class District {
  District({
    required this.name,
    required this.type,
    required this.slug,
    required this.path,
    required this.id,
    required this.parent_id,
  });

  final String? name;
  final String? type;
  final String? slug;
  final String? path;
  final String? id;
  final String? parent_id;

  static District fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        type: typeValues.map[json["type"]],
        slug: json["slug"],
        path: json["path"],
        id: json["code"] ?? json["id"],
        parent_id: json["parent_code"] ?? json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": typeValues.reverse[type],
        "slug": slug,
        "path": path,
        "id": id,
        "parent_id": parent_id,
      };
}

Map<String, dynamic> typeDistrict = {
  "quan": "Quận",
  "huyen": "Huyện",
  "thi-xa": "Thị Xã",
  "thanh-pho": "Thành Phố",
};

final typeValues = EnumValues({
  "quan": typeDistrict['quan'],
  "huyen": typeDistrict['huyen'],
  "thi-xa": typeDistrict['thi-xa'],
  "thanh-pho": typeDistrict['thanh-pho']
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
