import '../model/district.dart';
import '../model/province.dart';
import '../model/ward.dart';
import '../provider/api/api.dart';
import '../provider/db/address_database.dart';

class AddressRepo {
  final Api api;

  AddressRepo({required this.api});

  // Provinces
  Future<void> createProvincesToDB({List<Province>? provinces}) async {
    for (int i = 0; i < provinces!.length; i++) {
      if (provinces[i] is Province) {
        Province? province;
        province = await readProvinceByID(id: provinces[i].id);
        if (province == null) {
          await AddressDatabase.instance.createProvinceToDB(provinces[i]);
        }
      }
    }
  }

  Future<Province?> readProvinceByID({String? id}) async {
    Province? province = await AddressDatabase.instance.readProvinceByID(id);
    return province;
  }

  Future<Province?> readProvinceByName(String? name) async {
    Province? province =
        await AddressDatabase.instance.readProvinceByName(name);
    return province;
  }

  Future<List<Province>> readAllProvinces() async {
    List<Province> provinces = await AddressDatabase.instance.readAllProvince();
    return provinces;
  }

  // District
  Future<void> createDistrictToDB({List<District>? districts}) async {
    for (int i = 0; i < districts!.length; i++) {
      if (districts[i] is District) {
        District? district;
        district = await readDistrictByID(id: districts[i].id);
        if (district == null) {
          await AddressDatabase.instance.createDistrictToDB(districts[i]);
        }
      }
    }
  }

  Future<District?> readDistrictByID({String? id}) async {
    District? district = await AddressDatabase.instance.readDistrictByID(id);
    return district;
  }

  Future<District?> readDistrictByName(String? name) async {
    District? district =
        await AddressDatabase.instance.readDistrictByName(name);
    return district;
  }

  Future<List<District>> readAllDistrict() async {
    List<District> districts = await AddressDatabase.instance.readAllDistrict();
    return districts;
  }

  Future<List<District>> readAllDistrictByParentID(String provinceId) async {
    List<District> districts =
        await AddressDatabase.instance.readAllDistrictByParentID(provinceId);
    return districts;
  }

  // Ward
  Future<void> createWardToDB({List<Ward>? wards}) async {
    for (int i = 0; i < wards!.length; i++) {
      if (wards[i] is Ward) {
        Ward? ward;
        ward = await readWardByID(id: wards[i].id);
        if (ward == null) {
          await AddressDatabase.instance.createWardToDB(wards[i]);
        }
      }
    }
  }

  Future<Ward?> readWardByID({String? id}) async {
    Ward? ward = await AddressDatabase.instance.readWardByID(id!);
    return ward;
  }

  Future<Ward?> readWardByname(String? name) async {
    Ward? ward = await AddressDatabase.instance.readWardByName(name);
    return ward;
  }

  Future<List<Ward>> readAllWardByParentID(String districtId) async {
    List<Ward> wards =
        await AddressDatabase.instance.readAllWardByParentID(districtId);
    return wards;
  }
}
