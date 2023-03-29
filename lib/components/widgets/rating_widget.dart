import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final void Function(int index) onChanged;
  final int value;

  const StarRating({
    Key? key,
    required this.onChanged,
    this.value = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(spacing: 0.01, children: [
        for (int index = 0; index < 10; ++index)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
                onTap: () {
                  onChanged(value == index + 1 ? index : index + 1);
                },
                child: Icon(
                  index < value
                      ? Icons.star_rate_rounded
                      : Icons.star_border_rounded,
                  color: index < value ? Colors.amber : Colors.black,
                  size: size.width / 14,
                )),
          )
      ]),
    );
  }
}
