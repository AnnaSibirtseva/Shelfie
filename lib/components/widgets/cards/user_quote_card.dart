import 'package:flutter/material.dart';
import '../../../models/user_quote.dart';
import '../../constants.dart';
import '../../image_constants.dart';

class UserQuoteCard extends StatefulWidget {
  final UserQuote quote;

  const UserQuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  _UserQuoteCardState createState() => _UserQuoteCardState();
}

class _UserQuoteCardState extends State<UserQuoteCard> {
  late UserQuote quote;
  bool showFlag = false;

  @override
  void initState() {
    quote = widget.quote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
          color: secondaryColor,
          image: DecorationImage(
            image: NetworkImage(quoteImg),
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
            maxLines: showFlag ? null : 7,
            style: TextStyle(
                fontSize: size.width / 22, fontWeight: FontWeight.bold),
          ),
          if (quote.getQuoteText().isNotEmpty &&
              quote.getQuoteText().length > 200)
            InkWell(
                onTap: () {
                  setState(() {
                    showFlag = !showFlag;
                  });
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(showFlag ? "Свернуть" : "Развернуть",
                            style: const TextStyle(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                )),
          const Divider(
            color: Colors.white70,
          ),
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
                    style: TextStyle(
                        fontSize: size.width / 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    quote.getAuthors(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: size.width / 27, fontWeight: FontWeight.w300),
                  ),
                ],
              )),
              const SizedBox(width: 10),
              Container(
                width: size.width * 0.1,
                height: size.height * 0.075,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: primaryColor),
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
    );
  }
}
