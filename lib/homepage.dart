import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:product_management/add_product.dart';
import 'package:product_management/detailpage.dart';
import 'package:product_management/productServices.dart';
import 'package:product_management/widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ProductService _productService = ProductService();
  List<DocumentSnapshot> products = <DocumentSnapshot>[];
  String _currentProduct = '';
  TextEditingController newProductnamecontroller = TextEditingController();
  TextEditingController newPricecontroller = TextEditingController();
  String newname = '';
  String newPrice = '';

  _getproducts() async {
    // log("in Product, Gstno : ${widget.gstno.toString()}");
    List<DocumentSnapshot> data = await _productService.getProduct();
    setState(() {
      // print("data.length : ${data.length}");
      products = data;
      // log("Product data : ${products.toString()}");
      // productsDropdown = getproductsDropdown();
      _currentProduct = products[0].get('name');
      // print('current product : ${_currentProduct}');
    });
  }

  // Function to delete product by name
  Future<void> deleteProductByName(String productName) async {
    // Get reference to Firestore collection
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('products');

    // Query for the document by its name
    QuerySnapshot querySnapshot =
        await productsCollection.where('name', isEqualTo: productName).get();

    // Check if there's a document matching the query
    if (querySnapshot.docs.isNotEmpty) {
      // Get the reference to the document to delete
      String documentId = querySnapshot.docs.first.id;
      await productsCollection.doc(documentId).delete();
      print('Product $productName deleted successfully.');
    } else {
      print('Product $productName not found.');
    }
  }

  Future<void> _updateProduct(
      String currentProductname, String newname, String newprice) async {
    String newName = newname;
    int newPrice = int.parse(newprice);
    Map<String, dynamic> newData = {
      'name': newName,
      'price': newPrice,
    };
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('products');
    // Query for the document by its name
    QuerySnapshot querySnapshot = await productsCollection
        .where('name', isEqualTo: currentProductname)
        .get();

    // Check if there's a document matching the query
    if (querySnapshot.docs.isNotEmpty) {
      // Get the reference to the document to delete
      String documentId = querySnapshot.docs.first.id;
      log("Document id : ${documentId}");
      // await productsCollection.doc(documentId).delete();
      await productsCollection.doc(documentId).update(newData);
      print('Product $currentProductname updated successfully.');
    } else {
      print('Product $currentProductname not found.');
    }
//     await _productService.updateProduct(currentProductname,widget.gstno, {
    // 'name': newName,
    // 'price': newPrice,
//       // Add other fields you want to update
//     } as Map<String, dynamic>);
// log("Product name ${currentProductname} updated successfully!!");
//     // Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getproducts();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Product Inventory",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formkey,
        child: FutureBuilder(
            future: _getproducts(),
            builder: (context, snapshot) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.78,
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 4.0, // Spacing between columns
                    mainAxisSpacing: 4.0, // Spacing between rows
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: () {
                      nextscreen(context, DetailPage(sliderpic: products[index]['image'], name: products[index]['name'], price: products[index]['price']));
                    },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: Container(
                          height: 200,
                          // width: 160,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Column(
                            children: [
                              Image.network(
                                products[index]['image'][0],
                                cacheHeight: 146,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    products[index]['name'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "₹ ${products[index]['price']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // GridView.builder(scrollDirection: Axis.vertical,
                    //   itemCount: products.length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top:20,left: 5,right: 5),
                    //       child: Card(
                    //       // height: 00,
                    // shape:
                    // RoundedRectangleBorder(

                    //   borderRadius:
                    //  BorderRadius.circular(12),
                    //   side: BorderSide(width: 2, color: Colors.grey)),

                    //         child: Column(
                    //           children: [
                    // Image.network(products[index]['image'][0],cacheHeight: 136,),
                    // // SizedBox(height: 10,),
                    // // Padding(
                    // //   padding: const EdgeInsets.only(left:5),
                    // //   child: Text(
                    // //     products[index]['name'],
                    // //     style: TextStyle(
                    // //         color: Colors.black,
                    // //         fontWeight: FontWeight.bold,
                    // //         fontSize: 14),
                    // //   ),
                    // // ),
                    //  Padding(
                    //    padding: const EdgeInsets.only(left:5),
                    //    child: Align(
                    //     alignment: Alignment.topLeft,
                    //      child: Text(
                    //       "₹ ${products[index]['price']}",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 14),
                    //                                      ),
                    //    ),
                    //             //  )
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextscreen(context, AddProudct());
        },
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
