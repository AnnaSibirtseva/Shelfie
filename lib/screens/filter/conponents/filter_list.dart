import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class FilterList extends StatefulWidget {
  final List<String> data;
  late List<String> selectedItemsList = [];

  FilterList({Key? key, required this.data}) : super(key: key);

  @override
  _FilterList createState() => _FilterList();

  List<String> getList() {
    return selectedItemsList;
  }
}

class _FilterList extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(children: [
              for (var item = 0; item < widget.selectedItemsList.length; item++)
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
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(widget.selectedItemsList[item].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: primaryColor,
                          ),
                          onTap: () {
                            setState(() {
                              widget.selectedItemsList
                                  .remove(widget.selectedItemsList[item]);
                            });
                          })
                    ],
                  ),
                ),
            ]),
          ),
          const Divider(
              color: secondaryColor, endIndent: 16, thickness: 1, indent: 16),
          Flexible(
            child: SizedBox(
              height: size.height * 0.2,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => selectTappedItem(index),
                            title: Text(
                              widget.data[index],
                              maxLines: 2,
                            ),
                            leading: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: widget.selectedItemsList
                                          .contains(widget.data[index])
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
            ),
          )
        ],
      ),
    );
  }

  void selectTappedItem(int index) {
    if (widget.selectedItemsList.contains(widget.data[index])) {
      setState(() {
        widget.selectedItemsList.remove(widget.data[index]);
      });
    } else {
      setState(() {
        widget.selectedItemsList.add(widget.data[index]);
      });
    }
  }
}
