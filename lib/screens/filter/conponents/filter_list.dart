import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key}) : super(key: key);

  @override
  _FilterList createState() => _FilterList();
}

class _FilterList extends State<FilterList> {
  List data = [
    'жАнРррР',
    'Зуянр',
    'Боба',
    'Буба',
    'суперпупердлинныйжанрогокактаконтакойдлинныйэтовообщежанр',
    'а тут нужно много просто',
    'и еще',
    'бебебебе',
    'фыр'
  ];
  List selectedItemsList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      //height: size.height * 0.8,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(children: [
              for (var item = 0; item < selectedItemsList.length; item++)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(15),
                    //color: primaryColor
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(selectedItemsList[item].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: primaryColor,
                          ),
                          onTap: () {
                            setState(() {
                              selectedItemsList.remove(selectedItemsList[item]);
                            });
                          })
                    ],
                  ),
                ),
            ]),
          ),
          const Divider(
              color: secondaryColor, endIndent: 16, thickness: 1, indent: 16),
          SizedBox(
            height: size.height * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => selectTappedItem(index),
                          title: Text(
                            data[index],
                            maxLines: 2,
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: selectedItemsList.contains(data[index])
                                    ? primaryColor
                                    : secondaryColor),
                            child:
                                const Icon(Icons.check, color: secondaryColor),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void selectTappedItem(int index) {
    if (selectedItemsList.contains(data[index])) {
      setState(() {
        selectedItemsList.remove(data[index]);
      });
    } else {
      setState(() {
        selectedItemsList.add(data[index]);
      });
    }
  }
}
