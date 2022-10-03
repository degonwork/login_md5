import '../model/district.dart';
import '../model/province.dart';
import '../model/wards.dart';
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
        province = await readProvinceFromDB(code: provinces[i].code);
        if (province == null) {
          await AddressDatabase.instance.createProvince(provinces[i]);
        }
      }
    }
  }

  Future<Province?> readProvinceFromDB({int? code}) async {
    Province? province = await AddressDatabase.instance.readProvince(code!);
    return province;
  }

  Future<List<Province>> readAllProvincesFromDB() async {
    List<Province> provinces = await AddressDatabase.instance.readAllProvince();
    return provinces;
  }

  // District
  Future<void> createDistrictToDB({List<District>? districts}) async {
    for (int i = 0; i < districts!.length; i++) {
      if (districts[i] is District) {
        District? district;
        district = await readDistrictFromDB(code: districts[i].code);
        if (district == null) {
          await AddressDatabase.instance.createDistrict(districts[i]);
        }
      }
    }
  }

  Future<District?> readDistrictFromDB({int? code}) async {
    District? district = await AddressDatabase.instance.readDistrict(code!);
    return district;
  }

  Future<List<District>> readAllDistrictFromDB() async {
    List<District> districts = await AddressDatabase.instance.readAllDistrict();
    return districts;
  }

  Future<void> deleteDistrictTable() async {
    List<District> districts = await readAllDistrictFromDB();
    if (districts.isNotEmpty) {
      await AddressDatabase.instance.deleteDistrict();
    }
  }

  // Ward
  Future<void> createWardToDB({List<Ward>? wards}) async {
    for (int i = 0; i < wards!.length; i++) {
      if (wards[i] is Ward) {
        Ward? ward;
        ward = await readWardFromDB(code: wards[i].code);
        if (ward == null) {
          await AddressDatabase.instance.createWard(wards[i]);
        }
      }
    }
  }

  Future<Ward?> readWardFromDB({int? code}) async {
    Ward? ward = await AddressDatabase.instance.readWard(code!);
    return ward;
  }

  Future<List<Ward>> readAllWardFromDB() async {
    List<Ward> wards = await AddressDatabase.instance.readAllWard();
    return wards;
  }

  Future<void> deleteWardTable() async {
    List<Ward> wards = await readAllWardFromDB();
    if (wards.isNotEmpty) {
      await AddressDatabase.instance.deleteWard();
    }
  }
}
