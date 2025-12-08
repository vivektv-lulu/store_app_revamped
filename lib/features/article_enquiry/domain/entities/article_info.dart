import 'package:equatable/equatable.dart';

class ArticleInfo extends Equatable {
  // Fields without labels
  final String? itemName;
  final String? amount;
  final String? articleNumber;
  
  // Fields with labels
  final String? mrp;
  final String? brand;
  final String? mc;
  final String? mcText;
  final String? stock;
  final String? uom;
  final String? shelfNo;
  final String? vendor;
  
  // Additional fields
  final String? ean;
  final String? plu;
  final String? description;
  final String? price;

  const ArticleInfo({
    this.itemName,
    this.amount,
    this.articleNumber,
    this.mrp,
    this.brand,
    this.mc,
    this.mcText,
    this.stock,
    this.uom,
    this.shelfNo,
    this.vendor,
    this.ean,
    this.plu,
    this.description,
    this.price,
  });

  @override
  List<Object?> get props => [
        itemName,
        amount,
        articleNumber,
        mrp,
        brand,
        mc,
        mcText,
        stock,
        uom,
        shelfNo,
        vendor,
        ean,
        plu,
        description,
        price,
      ];
}

