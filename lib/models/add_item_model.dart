import 'package:flutter_app5/database/app_database.dart';

class AddItemModel {
  final Person? bayer;
  final List<Person> partners;
  final String price;
  final String label;

  AddItemModel(
      {this.bayer,
      required this.partners,
      required this.price,
      required this.label});

  AddItemModel copyWith(
      {String? label, String? price, List<Person>? partners, Person? bayer}) {
    return AddItemModel(
      label: label ?? this.label,
      partners: partners ?? this.partners,
      price: price ?? this.price,
      bayer: bayer ?? this.bayer,
    );
  }
}
