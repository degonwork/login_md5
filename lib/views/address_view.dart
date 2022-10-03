import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:responsive_login_ui/controller/address_controller.dart';
import 'package:responsive_login_ui/data/model/district.dart';
import 'package:responsive_login_ui/data/model/province.dart';
import '../data/model/wards.dart';

class AddressView extends StatelessWidget {
  const AddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _provinceController = TextEditingController();
    TextEditingController _districtController = TextEditingController();
    TextEditingController _wardController = TextEditingController();

    return Scaffold(
      body: SafeArea(child: GetBuilder<AddressController>(
        builder: (addressController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TypeAheadField<Province?>(
                    hideSuggestionsOnKeyboardHide: true,
                    debounceDuration: const Duration(milliseconds: 500),
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _provinceController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Province',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) async {
                      if (_provinceController.text.isEmpty) {
                        await addressController.deleteDistrict();
                        print("Delete district DB");
                      }
                      return await Get.find<AddressController>()
                          .getProvinceSuggestions(pattern);
                    },
                    itemBuilder: (context, Province? suggestion) {
                      final province = suggestion!;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                province.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (Province? suggestion) async {
                      final province = suggestion!;
                      _provinceController.text = province.name!;
                      addressController.provinceCode = province.code!;
                      await addressController.deleteDistrict();
                      print("Delete district DB");
                      await addressController.districtDBProcessed();
                    },
                    noItemsFoundBuilder: (context) => const Center(
                      child: Text(
                        "No User Found",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TypeAheadField<District?>(
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _districtController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search District',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) async {
                      if (_districtController.text.isEmpty) {
                        await addressController.deleteWard();
                        print("Delete ward DB");
                      }
                      return await Get.find<AddressController>()
                          .getDistrictSuggestions(pattern);
                    },
                    itemBuilder: (context, District? suggestion) {
                      final district = suggestion!;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                district.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (District? suggestion) async {
                      final district = suggestion!;
                      _districtController.text = district.name!;
                      addressController.districtCode = district.code!;
                      await addressController.deleteWard();
                      print("Delete ward DB");
                      await addressController.wardDBProcessed();
                    },
                    noItemsFoundBuilder: (context) => const Center(
                      child: Text(
                        "No User Found",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TypeAheadField<Ward?>(
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _wardController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Ward',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) async {
                      return await Get.find<AddressController>()
                          .getWardSuggestions(pattern);
                    },
                    itemBuilder: (context, Ward? suggestion) {
                      final ward = suggestion!;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                ward.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (Ward? suggestion) {
                      final ward = suggestion!;
                      _wardController.text = ward.name!;
                    },
                    noItemsFoundBuilder: (context) => const Center(
                      child: Text(
                        "No User Found",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_provinceController.text.trim().isEmpty) {
                          Get.snackbar("You have not selected a Province",
                              "Please select a Province",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else if (_districtController.text.trim().isEmpty) {
                          Get.snackbar("You have not selected a District",
                              "Please select a District",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else if (_wardController.text.trim().isEmpty) {
                          Get.snackbar("You have not selected a Ward",
                              "Please select a Ward",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else {
                          print("Province: " + _provinceController.text);
                          print("District: " + _districtController.text);
                          print("Ward: " + _wardController.text);
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
