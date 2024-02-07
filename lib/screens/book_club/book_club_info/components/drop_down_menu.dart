import 'package:flutter/material.dart';

import '../../../../components/constants.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<DropDownMenu> {
  late String selectedItem = 'Не приду';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
        width: size.width * 0.5,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
              Radius.circular(15)
          ),
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.1,
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                isDense: true,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                dropdownColor: primaryColor,
                value: selectedItem,
                style: TextStyle(fontWeight: FontWeight.bold),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: whiteColor,
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                items: eventAttendance.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),

              ),
            ),
          ),
      ),
    );
  }
}
