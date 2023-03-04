import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/book_quote.dart';

class QuoteCard extends StatefulWidget {
  final BookQuote quote;

  const QuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  //final VoidCallback press;
  late BookQuote quote;

  @override
  void initState() {
    quote = widget.quote;
    super.initState();
  }

  void onQuoteClick() {
    if (!quote.isQuoteSaved()) {
      // add to quotes
      quote.reverseQuoteSaved();
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      //onTap: press,
      child: Container(
        width: size.width,
        decoration: const BoxDecoration(
            color: secondaryColor,
            image: DecorationImage(
              image: NetworkImage(
                  'https://ie.wampi.ru/2023/03/04/imageef4a214a62549bba.png'),
              alignment: Alignment.topRight,
              fit: BoxFit.contain,
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
            ),
            if (!quote.isQuoteSaved())
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: onQuoteClick,
                  child: SizedBox(
                    height: 30,
                    child: Image.asset('assets/images/save_quote.png'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
