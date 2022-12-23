import 'package:flutter/material.dart';
import 'package:sioc_scanner/Api/sheets_api.dart';
import 'package:sioc_scanner/Model/assets.dart';

import '../Widgets/resultField.dart';

class ScanResult extends StatefulWidget {
  final String itemID;
  const ScanResult({super.key, required this.itemID});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  Assets? asset;
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
  void initState() {
    super.initState();
    getAssets();
  }

  Future getAssets() async {
    final asset = await AssetsSheetsApi.getById(widget.itemID);

    this.asset = asset;
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                  future: getAssets(),
                  builder: (c, s) {
                    if (s.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoField("Item Name:", "${asset!.item}"),
                            buildInfoField(
                                "Asset Number:",
                                asset!.assetNumber!.isNotEmpty
                                    ? "${asset!.assetNumber}"
                                    : "Not Available"),
                            buildInfoField(
                                "Description:", "${asset!.description}"),
                            buildInfoField(
                                "Relationships:", "${asset!.relationships}"),
                            buildInfoField(
                                "Location/User:", "${asset!.locationOrUser}"),
                            buildInfoField("Type:", "${asset!.type}"),
                            buildInfoField(
                                "Manufacturer:", "${asset!.manufacturer}"),
                            buildInfoField(
                                "Serial Number:", "${asset!.serialNumber}"),
                            buildInfoField(
                                "Mobdel Number:", "${asset!.modelNumber}"),
                            buildInfoField(
                                "Supply Date:", "${asset!.supplyDate}"),
                            buildInfoField("Supplier:", "${asset!.supplier}"),
                            buildInfoField(
                                "Remark:",
                                asset!.remark!.isNotEmpty
                                    ? "${asset!.remark}"
                                    : "Not Available"),
                          ],
                        ),
                      );
                    }
                    return Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator.adaptive(),
                          Text(
                            "Loading data...",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )));
  }
}
