import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shelfie/components/routes/route.gr.dart';
import 'package:shelfie/models/book.dart';
import 'package:shelfie/models/inherited_id.dart';
import 'package:auto_route/auto_route.dart';

import '../constants.dart';
import '../image_constants.dart';
import '../widgets/dialogs/nothing_found_dialog.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.50,
      height: size.height * 0.04,
      child: ElevatedButton(
        child: Row(
          children: [
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.06,
              child: Image.asset('assets/icons/code_scanner.png'),
            ),
            SizedBox(
              width: size.width * 0.025,
            ),
            Text(
              'Сканировать ISBN',
              style: TextStyle(
                  fontSize: size.width * 0.032,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
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

  Future<Book> getBookByISBN(int id, String isbn, BuildContext context) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(url, '/books/search/$isbn'),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return Book.allInfoFromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else if (response.statusCode == 404) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const NothingFoundDialog(
                'Ой! \nКажется, у нас в библиотеке нет книги с таким кодом.',
                searchGif,
                'Не найдено'));
        throw Exception();
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<void> barcodeScan(BuildContext context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3949AB', 'Отмена', true, ScanMode.BARCODE);
      if (barcodeScanRes != '-1') {
        if (barcodeScanRes.length != 13) {
          showDialog(
              context: context,
              builder: (BuildContext context) => const NothingFoundDialog(
                  'Похоже, что вы отсканировали не штрих-код.\nПопробуйте еще раз.',
                  barcodeGif,
                  'Не найдено'));
        } else {
          final inheritedWidget = IdInheritedWidget.of(context);
          Book book =
              await getBookByISBN(inheritedWidget.id, barcodeScanRes, context);
          context.router.push(BookInfoRoute(bookId: book.getId()));
        }
      }
    } on PlatformException catch (_) {
      barcodeScanRes = 'Failed to get platform version.';
      showDialog(
          // If set to true allow to close popup by tapping out of the popup.
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
