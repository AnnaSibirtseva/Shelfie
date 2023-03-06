import 'package:flutter/material.dart';

import '../../../../components/widgets/cards/user_quote_card.dart';
import '../../../../components/widgets/dialogs/add_quote_dialog.dart';
import '../../../../models/user_quote.dart';
import '../header_widget.dart';

class Body extends StatelessWidget {
  final List<UserQuote> quotes;

  const Body({Key? key, required this.quotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: 15, right: 15, top: 15, bottom: size.height * 0.1),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => const AddQuoteDialog()),
            child: const HeaderWidget(
              text: 'Цитаты',
              icon: 'quote',
            ),
          ),
          for (UserQuote quote in quotes)
            UserQuoteCard(
            quote: quote,
          )
        ],
      ),
    );
  }
}
