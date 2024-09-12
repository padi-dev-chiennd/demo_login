import 'package:demologin/home/image_model.dart';
import 'package:flutter/material.dart';

List<ImageModel> getImageModels() {
  return [
    ImageModel(id: 0, name: 'image1.jpg', path: 'images/img1.png', size: 1024),
    ImageModel(id: 1, name: 'image2.jpg', path: 'images/img2.jpg', size: 2048),
    ImageModel(id: 2, name: 'image3.jpg', path: 'images/img1.png', size: 3072),
  ];
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

List<DropdownMenuItem> dropDown() {
  List<DropdownMenuItem<String>> dropDownItems = [];

  for (String currency in currenciesList) {
    //for every currency in the list we create a new dropdownmenu item
    var newItem = DropdownMenuItem(
      value: currency,
      child: Text(currency),
    );
    // add to the list of menu item
    dropDownItems.add(newItem);
  }
  return dropDownItems;
}
