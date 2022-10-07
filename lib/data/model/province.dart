final String tableProvinces = 'provinces';

class ProvinceField {
  static final List<String> values = [id, name, slug, type];
  static final String id = 'id';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String type = 'type';
}

class Province {
  Province({
    required this.name,
    required this.slug,
    required this.type,
    required this.id,
  });
  final String? name;
  final String? slug;
  final String? type;
  final String? id;

  static Province fromJson(Map<String, dynamic> json) => Province(
        name: json["name"],
        slug: json["slug"],
        type: typeValues.map[json["type"]]!,
        id: json["code"] ?? json["id"],
      );

  Map<String, dynamic> toJson() => {
        ProvinceField.name: name,
        ProvinceField.slug: slug,
        ProvinceField.type: typeValues.reverse[type],
        ProvinceField.id: id,
      };
}

Map<String, dynamic> typeProvinces = {
  "thanh-pho": "Thành Phố",
  "tinh": "Tỉnh",
};

final typeValues = EnumValues(
    {"thanh-pho": typeProvinces['thanh-pho'], "tinh": typeProvinces['tinh']});

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
