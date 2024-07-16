import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_management/widget.dart';
import 'package:readmore/readmore.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.sliderpic,

    // required this.sliderpic,

    required this.name,
    required this.price,
    // required this.hideprice,
    // required this.rate,
    // required this.discount,
    // required this.quantity,
    // required this.favourite
  });
  final List sliderpic;

  final name;

  // final Product product;
  final price;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Function to get the current user ID

// Example usage in a Flutter widget

  String? selectedValue;
  TextEditingController newProductnamecontroller = TextEditingController();
  TextEditingController newPricecontroller = TextEditingController();
  String newname = '';
  String newPrice = '';

  // final Product product;
  late Color screenPickerColor;
  List colorname = ["Black", "Grey", "Blue", "Green"];
  List colors = [
    Colors.black,
    Colors.grey,
    Colors.blue,
    Color.fromARGB(255, 40, 110, 83),
  ];
  var size, height, width;
  int sliderindex = 0;
  bool isReadMore = false;
  bool currentindex = false;
  bool iconindex = false;

  int myindex = 0;
  final List<String> items = ["3×3", "4×3", "5×3", "5×4", "C type", "Single"];
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

  final _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context as BuildContext).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _Formkey,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 14 / 4,
                        height: height * 0.5,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          setState(() {
                            sliderindex = index;
                          });
                        },
                      ),
                      items: widget.sliderpic.map((e) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: width,
                              // height: height * 0.2,
                              child: Image(
                                image: NetworkImage(e),
                                // height: height * 2,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                      child: AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 20,
                        )),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          maxRadius: 18,
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_outlined,
                                color: Colors.black,
                                size: 20,
                              )),
                        ),
                      )
                    ],
                  )),
                  Positioned(
                    top: height * 0.465,
                    left: width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Container(
                            height: 6,
                            width: index == sliderindex ? 18 : 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: index == sliderindex
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(202, 236, 189, 164)
                                  .withOpacity(0.4)),
                          child: Center(
                            child: Text(
                              "9,742 sold",
                              style: TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // nextscreen(context, reviewScreen());
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 6),
                                child: RatingBar(
                                    itemSize: 19,
                                    glow: false,
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 1,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.grey),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Colors.grey,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.grey,
                                        )),
                                    onRatingUpdate: (value) {
                                      setState(() {});
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "₹${widget.price}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: ReadMoreText(
                      "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                      style: TextStyle(color: Colors.grey.shade500),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'view more..',
                      trimExpandedText: 'view less',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Row(
                      children: [],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 85,
                width: width,
                // color: Colors.green,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, -1),
                          blurRadius: 13,
                          spreadRadius: 0.22,
                          blurStyle: BlurStyle.outer),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 15, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(width: 1, color: Colors.grey)),
                              minimumSize: Size(167, 54)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Text("Edit Product!!"),
                                    content: SizedBox(
                                      height: 220,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Product name",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: TextFormField(
                                              controller:
                                                  newProductnamecontroller,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                              cursorColor: Colors.grey,
                                              keyboardType: TextInputType.text,
                                              decoration: textInputDecorationblue
                                                  .copyWith(
                                                      hintText: "Product name",
                                                      prefixIcon: Icon(
                                                        Icons.person,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      )),
                                              onChanged: (value) {
                                                setState(() {
                                                  newname = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "*Product name cannot be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Price",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: TextFormField(
                                              controller: newPricecontroller,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                              cursorColor: Colors.grey,
                                              keyboardType: TextInputType.number,
                                              decoration: textInputDecorationblue
                                                  .copyWith(
                                                      hintText: "Price",
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                12),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "assets/images/money.png"),
                                                          color: Colors.grey,
                                                          size: 2,
                                                        ),
                                                      )),
                                              onChanged: (value) {
                                                setState(() {
                                                  newPrice = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "*Price cannot be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.grey)),
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (_Formkey.currentState!.validate()) {
                                            setState(() {
                                              newname =
                                                  newProductnamecontroller.text;
                                              newPrice = newPricecontroller.text;
                                            });
                                          }
                                          _updateProduct(
                                              widget.name, newname, newPrice);
                                          Navigator.pop(context);
                                          newProductnamecontroller.clear();
                                          newPricecontroller.clear();
                                        },
                                      ),
                                      TextButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.grey)),
                                        child: Text(
                                          'No',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ]);
                              },
                            );
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              minimumSize: Size(167, 54)),
                          onPressed: () async {
                             showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                title: Text('Confirm Deletion!!'),
                                                content: Text(
                                                  'Are you sure you want to delete ${widget.name}?',
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.grey)),
                                                    child: Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      deleteProductByName(
                                                          widget.name);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.grey)),
                                                    child: Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ]);
                                          },
                                        );
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
