import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/book_quote.dart';
import '../../../models/user_quote.dart';
import '../dialogs/confirmation_dialog.dart';

class UserQuoteCard extends StatefulWidget {
  final UserQuote quote;

  const UserQuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  _UserQuoteCardState createState() => _UserQuoteCardState();
}

class _UserQuoteCardState extends State<UserQuoteCard> {
  //final VoidCallback press;
  late UserQuote quote;

  @override
  void initState() {
    quote = widget.quote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(quote.id.toString()),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmationDialog(
                text: 'Вы действительно хотите удалить эту цитату?');
          },
        );
      },
      background: deleteBackGroundItem(),
      child: Container(
        width: size.width,
        decoration: const BoxDecoration(
            color: secondaryColor,
            image: DecorationImage(
              image: NetworkImage(
                  'https://ie.wampi.ru/2023/03/04/imageef4a214a62549bba.png'),
              alignment: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.getQuoteText(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: size.width / 22, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.white70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '"' + quote.getTitle() + '"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: size.width / 24,  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          quote.getAuthors(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: size.width / 27,  fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                ),
                const SizedBox(width: 10),
                Container(
                  width: size.width * 0.1,
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color:primaryColor),
                    image: DecorationImage(
                      image: NetworkImage(quote.getQuoteImg()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deleteBackGroundItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Color(0xFFE57373),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

}
