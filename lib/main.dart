import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_login_ui/routes/routes.dart';
import 'bindings/allbindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: Routes.listRoutes,
      initialBinding: AllBindings(),
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         title: const Text("AutoComplete"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Autocomplete<Country>(
//           optionsBuilder: (textEditingValue) {
//             return controller.countryNames
//                 .where(
//                   (Country country) => country.name.toLowerCase().startsWith(
//                         textEditingValue.text.toLowerCase(),
//                       ),
//                 )
//                 .toList();
//           },
//           displayStringForOption: (Country country) => country.name,
//           fieldViewBuilder: ((
//             BuildContext context,
//             TextEditingController textEditingController,
//             FocusNode focusNode,
//             VoidCallback onFieldSubmitted,
//           ) {
//             return TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Select Country",
//               ),
//               controller: textEditingController,
//               focusNode: focusNode,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             );
//           }),
//           onSelected: (Country selection) {
//             print("Selection ${selection.name}");
//           },
//           optionsViewBuilder: ((BuildContext context,
//               AutocompleteOnSelected<Country> onSelected,
//               Iterable<Country> country) {
//             return Align(
//               alignment: Alignment.topLeft,
//               child: Material(
//                 child: Container(
//                   width: 330,
//                   color: Colors.blueAccent,
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(10.0),
//                     itemCount: country.length,
//                     itemBuilder: ((BuildContext context, int index) {
//                       final Country option = country.elementAt(index);
//                       return GestureDetector(
//                         onTap: () {
//                           onSelected(option);
//                         },
//                         child: ListTile(
//                           title: Text(
//                             option.name,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
