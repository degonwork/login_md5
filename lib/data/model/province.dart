final String tableProvinces = 'provinces';

class ProvinceField {
  static final List<String> values = [code, name, slug, type, name_with_type];
  static final String code = 'code';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String type = 'type';
  static final String name_with_type = 'name_with_type';
}

class Province {
  Province({
    required this.name,
    required this.slug,
    required this.type,
    required this.name_with_type,
    required this.code,
  });
  final String? name;
  final String? slug;
  final TypeProvinces? type;
  final String? name_with_type;
  final int? code;

  Province copy({
    String? name,
    String? slug,
    TypeProvinces? type,
    String? name_with_type,
    int? code,
  }) =>
      Province(
        name: name ?? this.name,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        name_with_type: name_with_type ?? this.name_with_type,
        code: code ?? this.code,
      );

  static Province fromJson(Map<String, dynamic> json) => Province(
        name: json["name"],
        slug: json["slug"],
        type: typeValues.map[json["type"]]!,
        name_with_type: json["name_with_type"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        ProvinceField.name: name,
        ProvinceField.slug: slug,
        ProvinceField.type: typeValues.reverse[type],
        ProvinceField.name_with_type: name_with_type,
        ProvinceField.code: code,
      };
}

enum TypeProvinces { THANH_PHO, TINH }

final typeValues = EnumValues(
    {"thanh-pho": TypeProvinces.THANH_PHO, "tinh": TypeProvinces.TINH});

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
