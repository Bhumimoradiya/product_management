import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'products';
  void uploadProduct(
      {required String productname,
      required int  quantity,
      required double price,
      required List image}) {
    var id = Uuid();
    int productId = id.hashCode;
    bool isFavourite=false;
    _firestore.collection(ref).doc().set({
      'name': productname,
      'id': productId,
      // 'brand': brand,
      'price': price,
      // 'category': category,
      'image': image,
      'isFavourite':isFavourite
    });
    log("${productname}");
  }

  Future getProduct() {
    return _firestore.collection(ref).get().then((value) {
      // print("Product : ${value.docs}");
      return value.docs;
    });
  }
}
