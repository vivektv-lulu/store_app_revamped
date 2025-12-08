import '../../domain/entities/article_info.dart';

class ArticleInfoModel extends ArticleInfo {
  const ArticleInfoModel({
    super.itemName,
    super.amount,
    super.articleNumber,
    super.mrp,
    super.brand,
    super.mc,
    super.mcText,
    super.stock,
    super.uom,
    super.shelfNo,
    super.vendor,
    super.ean,
    super.plu,
    super.description,
    super.price,
  });

  factory ArticleInfoModel.fromJson(Map<String, dynamic> json) {
    return ArticleInfoModel(
      itemName: json['itemName'] as String?,
      amount: json['amount'] as String?,
      articleNumber: json['articleNumber'] as String?,
      mrp: json['mrp'] as String?,
      brand: json['brand'] as String?,
      mc: json['mc'] as String?,
      mcText: json['mcText'] as String?,
      stock: json['stock'] as String?,
      uom: json['uom'] as String?,
      shelfNo: json['shelfNo'] as String?,
      vendor: json['vendor'] as String?,
      ean: json['ean'] as String?,
      plu: json['plu'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'amount': amount,
      'articleNumber': articleNumber,
      'mrp': mrp,
      'brand': brand,
      'mc': mc,
      'mcText': mcText,
      'stock': stock,
      'uom': uom,
      'shelfNo': shelfNo,
      'vendor': vendor,
      'ean': ean,
      'plu': plu,
      'description': description,
      'price': price,
    };
  }
}

