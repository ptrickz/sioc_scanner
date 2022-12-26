import 'package:flutter/material.dart';
import 'package:sioc_scanner/Api/sheets_api.dart';
import 'package:sioc_scanner/Model/assets.dart';
import 'package:sioc_scanner/Screens/home.dart';

class AddAssets extends StatefulWidget {
  const AddAssets({
    super.key,
  });

  @override
  State<AddAssets> createState() => _AddAssetsState();
}

class _AddAssetsState extends State<AddAssets> {
  bool isHelpOn = false;
  final formKey = GlobalKey<FormState>();
  late TextEditingController assetNum = TextEditingController();
  late TextEditingController desc = TextEditingController();
  late TextEditingController stat = TextEditingController();
  late TextEditingController relay = TextEditingController();
  late TextEditingController loc = TextEditingController();
  late TextEditingController type = TextEditingController();
  late TextEditingController manufacturer = TextEditingController();
  late TextEditingController serial = TextEditingController();
  late TextEditingController model = TextEditingController();
  late TextEditingController supplydate = TextEditingController();
  late TextEditingController supplier = TextEditingController();
  late TextEditingController remark = TextEditingController();

  @override
  void initState() {
    super.initState();

    initAsset();
  }

  void initAsset() {
    assetNum = TextEditingController();
    desc = TextEditingController();
    stat = TextEditingController();
    relay = TextEditingController();
    loc = TextEditingController();
    type = TextEditingController();
    manufacturer = TextEditingController();
    serial = TextEditingController();
    model = TextEditingController();
    supplydate = TextEditingController();
    supplier = TextEditingController();
    remark = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Assets",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
              ),
              Text(
                "Home",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              final form = formKey.currentState!;
              final isValid = form.validate();
              if (isValid) {
                final asset = Assets(
                  assetNumber: assetNum.text,
                  description: desc.text,
                  status: stat.text,
                  relationships: relay.text,
                  locationOrUser: loc.text,
                  type: type.text,
                  manufacturer: manufacturer.text,
                  serialNumber: serial.text,
                  modelNumber: model.text,
                  supplyDate: supplydate.text,
                  supplier: supplier.text,
                  remark: remark.text,
                );
                insertAssets(asset);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        title: const Center(
                          child: Text(
                            "Asset was saved!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(asset.description.toString()),
                            const Text('has been added.'),
                            const Text('Tap "Add More" to add more assets.')
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                              },
                              child: const Text("Ok")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        title: const Center(
                                          child: Text(
                                            "Re-enter Asset Data?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                                'Do you want to re-enter new data?'),
                                            Text(
                                                'Tap "Keep Contents" to retain data.'),
                                            Text(
                                              '(Choose "Keep Contents" if you want to retain same contents for most of the fields."Clear Form" to re-enter new data.)',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  const Text("Keep Contents")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddAssets()));
                                              },
                                              child: const Text("Clear Form")),
                                        ],
                                      );
                                    });
                              },
                              child: const Text("Add More")),
                        ],
                      );
                    });
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Note:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "If no data available, please enter: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: '"N/A"',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                    buildAssetFormField("Asset Number", "1234567", assetNum),
                    buildAssetFormField("Description",
                        "EDWARDS SIGI-271 Alarm Bell and Breakglass", desc),
                    buildAssetFormField("Status", "Live", stat),
                    buildAssetFormField(
                        "Relationships", "Firefighting Service", relay),
                    buildAssetFormField("Location/User", "Corridor 1", loc),
                    buildAssetFormField("Type", "Firefighting Service", type),
                    buildAssetFormField(
                        "Manufacturer", "EDWARDS", manufacturer),
                    buildAssetFormField(
                        "Serial Number", "SR012020Z015389", serial),
                    buildAssetFormField(
                        "Model Number", "EDWARDS SIGI-271", model),
                    buildAssetFormField("Supply Date", "5/21/2022", supplydate),
                    buildAssetFormField(
                        "Supplier", "Johan Usahamaju Sdn Bhd", supplier),
                    buildAssetFormField(
                        "Remark", "To create new tagging number", remark),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future insertAssets(Assets asset) async {
    final itemNum = await AssetsSheetsApi.getRowCount() + 1;
    final newAsset = asset.copy(item: "SIOC-Asset-$itemNum");
    await AssetsSheetsApi.insert([newAsset.toJson()]);
  }
}

Widget buildAssetFormField(
    String label, String hint, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: SizedBox(
            width: 375,
            height: 75,
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "e.g. '$hint'",
                hintStyle: const TextStyle(color: Colors.grey),
                focusColor: Colors.blue,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 0, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      color: Colors.blue,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      color: Colors.red,
                    )),
              ),
              validator: (value) {
                return value != null && value.isEmpty
                    ? '⚠️ Field cannot be empty. If no data available, please enter: "N/A"'
                    : null;
              },
            )),
      ),
    ],
  );
}
