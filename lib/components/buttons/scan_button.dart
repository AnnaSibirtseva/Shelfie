import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shelfie/screens/search/search_page.dart';

import '../constants.dart';

class ScanButton extends StatelessWidget {
  final String _bar_code = '';

  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.52,
      height: size.height * 0.04,
      // Indents top and bottom.
      //margin: const EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
        child: Row(
          children: [
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.06,
              child: Image.asset('assets/icons/code_scanner.png'),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              'Сканировать ISBN',
              style: TextStyle(
                  fontSize: size.width * 0.035, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: primaryColor,
            // Moves text in the button.
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
        onPressed: () {
          barcodeScan(context);


        },
      ),
    );
  }

  Future<void> barcodeScan(BuildContext context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3949AB', 'Cancel', true, ScanMode.BARCODE);

      showDialog(
        //if set to true allow to close popup by tapping out of the popup
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Код успешно отсканирован!"),
              content: Text(barcodeScanRes),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                )
              ],
            );
          });
      print(barcodeScanRes);
    } on PlatformException catch (e){
      barcodeScanRes = 'Failed to get platform version.';
      showDialog(
        //if set to true allow to close popup by tapping out of the popup
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("❌ Error!"),
              content: const Text("Failed to get platform version."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                )
              ],
            );
          });
    }
  }
}
