import 'package:flutter/material.dart';

import '../../../../components/image_constants.dart';
import '../../../../components/widgets/cards/user_quote_card.dart';
import '../../../../components/widgets/nothing_found.dart';
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
        height: size.height * 0.9,
        width: size.width,
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              const HeaderWidget(
                text: 'Цитаты',
                icon: 'quote',
              ),
              if (quotes.isEmpty)
                const NothingFoundWidget(
                  image: noTop10,
                  message: "Ой!\n У вас еще нет сохраненных цитат",
                  space: true,
                ),
              for (UserQuote quote in quotes)
                UserQuoteCard(
                  quote: quote,
                ),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }
}
