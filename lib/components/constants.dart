import 'package:flutter/material.dart';

// shelfie-api-gateway-shlf-16
const String url = 'shelfie-api-gateway-shlf-18.onrender.com';

const int iconSplitPart = 5;
const int aliasesAmount = 9;

const primaryColor = Color(0xFF3949AB);
const secondaryColor = Color(0xFFE8EAF6);
const menuIconsGrayColor = Color(0xFFADADAD);
const redColor = Color(0xFFE57373);
const lightGrayColor = Color(0xFFE0DCDC);
const grayColor = Colors.black38;
const darkGrayColor = Colors.black54;
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greenColor = Color(0xFF00A550);
const brightRedColor = Color(0xFFDD5D50);

const defaultCollectionName = '-';
const defaultCollectionDesc = '-';

const List mainUserMenu = [
  'Книги',
  'Рецензии',
  'Цитаты',
  'Сборники',
  'События',
  'Достижения',
//  'Статистика'
];
const List extraUserMenu = [
//  'Настройки',
  'О приложении',
  'Выйти'
];

const List<String> eventAttendance = ['Не решил', 'Приду', 'Не приду'];

const noInternetErrorMessage =
    "Ой!\nНе удалось подключиться к интернету\nПроверьте подключение и попробуйте снова";

const int minName = 2;
const int maxName = 30;
const int minMail = 7;
const int maxMail = 100;
const int minPassword = 8;
const int maxPassword = 30;

const int minRevText = 10;
const int minCollectionTitle = 2;
const int minQuoteText = 2;

const List<int> errorWithMsg = [400, 403, 404];
