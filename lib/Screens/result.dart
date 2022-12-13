import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.itemName});
  final String itemName;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result for ${widget.itemName}"),
      ),
      body: SizedBox(
          child: Center(
        child: Column(children: []),
      )),
    );
  }
}

//Widget to build itemInfo
Widget buildItemInfo(
  int? itemCount,
  String itemName,
  String assetNumber,
  String description,
  String relationship,
  String locationUser,
  String type,
  String manufacturer,
  String serialNumber,
  String modelNumber,
  String supplyDate,
  String supplier,
  String remark,
) {
  return ListView.builder(
      itemCount: itemCount,
      itemBuilder: ((context, index) {
        return Column(
          children: [
            Text("Item Name: \n $itemName"),
            Text("Asset Number: \n $assetNumber"),
            Text("Description: \n $description"),
            Text("Relationship: \n $relationship"),
            Text("Location/User: \n $locationUser"),
            Text("Type: \n $type"),
            Text("Manufacturer: \n $manufacturer"),
            Text("Serial Number: \n $serialNumber"),
            Text("Model Number: \n $modelNumber"),
            Text("Supply Date: \n $supplyDate"),
            Text("Supplier: \n $supplier"),
            Text("Remark: \n $remark"),
          ],
        );
      }));
}
