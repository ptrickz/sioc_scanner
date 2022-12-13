import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sioc_scanner/Screens/result.dart';

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
          '#0000ff', 'Cancel', false, ScanMode.QR);
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
    if (barcodeScanRes != "-1") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Result(itemName: barcodeScanRes)));
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
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
                      scanQR();
                    },
                    child: const Text("Scan Again")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
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
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: SizedBox(
          width: width,
          height: height,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                width: width * 0.8,
                height: height * 0.5,
              ),
              SizedBox(
                width: width * 0.8,
                height: 50,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      scanQR();
                    },
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text("Scan Code")),
              )
            ],
          )),
        ));
  }
}
