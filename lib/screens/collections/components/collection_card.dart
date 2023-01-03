import 'package:flutter/material.dart';

import '../../../models/collection.dart';


class CollectionCard extends StatelessWidget {
  final VoidCallback press;
  final Collection collection;

  const CollectionCard({
    Key? key,
    required this.collection,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.05),
          padding: const EdgeInsets.all(5),
          height: size.height * 0.3,
          width: size.width * 0.9,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 5,
                        offset: Offset(0, 7),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(collection.getImageUrl()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(collection.getName(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text(collection.getDescription(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
