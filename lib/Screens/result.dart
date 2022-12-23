import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sioc_scanner/Widgets/resultField.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.itemName});
  final String itemName;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  //Retrieve Assets Information
  Stream<List<Assets>> readAssets() => FirebaseFirestore.instance
      .collection('assets')
      .where('Item', isEqualTo: widget.itemName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Assets.fromJson(doc.data())).toList());

//Widget to build Information
  Widget buildInfoField(String lable, String assetInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        ResultField(
          lable: assetInfo,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Scanned Item",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            )),
      ),
      body: Container(
          color: Colors.grey[200],
          child: StreamBuilder<List<Assets>>(
              stream: readAssets(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Something Went Wrong. \n Error: ${snapshot.error}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 25),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          final assets = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildInfoField(
                                    "Item Name:", "${assets[index].item}"),
                                buildInfoField(
                                    "Asset Number:",
                                    assets[index].assetNumber!.isNotEmpty
                                        ? "${assets[index].assetNumber}"
                                        : "Not Available"),
                                buildInfoField("Description:",
                                    "${assets[index].description}"),
                                buildInfoField("Relationships:",
                                    "${assets[index].relationships}"),
                                buildInfoField("Location/User:",
                                    "${assets[index].locationOrUser}"),
                                buildInfoField(
                                    "Type:", "${assets[index].type}"),
                                buildInfoField("Manufacturer:",
                                    "${assets[index].manufacturer}"),
                                buildInfoField("Serial Number:",
                                    "${assets[index].serialNumber}"),
                                buildInfoField("Mobdel Number:",
                                    "${assets[index].modelNumber}"),
                                buildInfoField("Supply Date:",
                                    "${assets[index].supplyDate}"),
                                buildInfoField(
                                    "Supplier:", "${assets[index].supplier}"),
                                buildInfoField(
                                    "Remark:",
                                    assets[index].remark!.isNotEmpty
                                        ? "${assets[index].remark}"
                                        : "Not Available"),
                              ],
                            ),
                          );
                        }));
                  } else {
                    return const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Invalid Code",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 25),
                        ),
                      ),
                    );
                  }
                }
              })),
    );
  }
}

class Assets {
  Assets({
    this.item,
    this.assetNumber,
    this.description,
    this.status,
    this.relationships,
    this.locationOrUser,
    this.type,
    this.manufacturer,
    this.serialNumber,
    this.modelNumber,
    this.supplyDate,
    this.supplier,
    this.remark,
  });

  String? item;
  String? assetNumber;
  String? description;
  String? status;
  String? relationships;
  String? locationOrUser;
  String? type;
  String? manufacturer;
  String? serialNumber;
  String? modelNumber;
  String? supplyDate;
  String? supplier;
  String? remark;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        item: json["Item"],
        assetNumber: json["Asset Number"],
        description: json["Description"],
        status: json["Status"],
        relationships: json["Relationships"],
        locationOrUser: json["LocationOrUser"],
        type: json["Type"],
        manufacturer: json["Manufacturer"],
        serialNumber: json["Serial Number"],
        modelNumber: json["Model Number"],
        supplyDate: json["Supply Date"],
        supplier: json["Supplier"],
        remark: json["Remark"],
      );

  Map<String, dynamic> toJson() => {
        "Item": item,
        "Asset Number": assetNumber,
        "Description": description,
        "Status": status,
        "Relationships": relationships,
        "LocationOrUser": locationOrUser,
        "Type": type,
        "Manufacturer": manufacturer,
        "Serial Number": serialNumber,
        "Model Number": modelNumber,
        "Supply Date": supplyDate,
        "Supplier": supplier,
        "Remark": remark,
      };
}
