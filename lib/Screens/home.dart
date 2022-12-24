import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sioc_scanner/Screens/addAssets.dart';
import 'package:sioc_scanner/Screens/scanRes.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

//Function to Scan QR
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#2196f3', 'Cancel', false, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    if (barcodeScanRes.contains("SIOC-Asset-")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanResult(itemID: barcodeScanRes)));
    } else if (barcodeScanRes == "-1") {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: const Center(
                child: Text(
                  "No Code Was Scanned!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              content: const Text(
                  "You have not scanned any code. \n Please Try again."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      scanQR();
                    },
                    child: const Text("Scan Again")),
              ],
            );
          });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: const Center(
                child: Text(
                  "Invalid Code!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              content: const Text(
                  "The QR Code you scan is invalid. \n Please Try again."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      scanQR();
                    },
                    child: const Text("Scan Again")),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddAssets()));
              },
              child: const Text(
                "Add Assets",
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
          width: width,
          height: height,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Scan the Code!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                  ),
                ),
              ),
              Image.asset(
                "assets/QRscan.png",
                width: width * 0.9,
                height: height * 0.55,
              ),
              SizedBox(
                width: width * 0.6,
                height: 50,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      scanQR();
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      size: 25,
                    ),
                    label: const Text(
                      "Scan Code",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          )),
        ));
  }
}
