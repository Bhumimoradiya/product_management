import 'dart:developer';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_management/productServices.dart';
import 'package:product_management/widget.dart';

class AddProudct extends StatefulWidget {
  const AddProudct({Key? key}) : super(key: key);

  @override
  State<AddProudct> createState() => _AddProudctState();
}

class _AddProudctState extends State<AddProudct> {
  final _formkey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();

  ProductService _productService = ProductService();
   Set<String> uniqueValues = Set<String>();


  TextEditingController productcontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  bool isLoading = false;
  File? img1;
  File? img2;
  File? img3;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Product"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild1(),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      2);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild2(),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      3);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild3(),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        "Enter product name with 10 characters at minimum",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25),
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          controller: productcontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must enter the product name";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: textInputDecorationblue.copyWith(
                              hintText: "Enter Product name")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25),
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: TextFormField(
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.grey,
                          controller: pricecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must enter the Price";
                            }
                            return null;
                          },
                          // initialValue: '0.00',
                          keyboardType: TextInputType.number,
                          decoration: textInputDecorationblue.copyWith(
                              hintText: "Enter Price")
                          // InputDecoration(
                          //   hintText: "Price",
                          //   labelText: "Price",
                          //   focusColor: Colors.grey,
                          // ),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          onPressed: () {
                            validateAndUpdate();
                          },
                          child: Text(
                            "Add product",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void selectedImage(Future<XFile?> pickImage, int imageNumber) async {
    XFile? tempImage = await pickImage;
    if (tempImage != null) {
      File newImage = File(tempImage.path);

      switch (imageNumber) {
        case 1:
          setState(() {
            img1 = newImage;
          });
          break;
        case 2:
          setState(() {
            img2 = newImage;
          });
          break;
        case 3:
          setState(() {
            img3 = newImage;
          });
          break;
      }
    }
  }

  _displaychild1() {
    if (img1 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Image.file(
          img1!,
          // fit: BoxFit.cover,
        ),
      );
    }
  }

  _displaychild2() {
    if (img2 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Image.file(img2!));
    }
  }

  _displaychild3() {
    if (img3 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Image.file(
            img3!,
          ));
    }
  }

  void validateAndUpdate() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (img1 != null && img2 != null && img3 != null) {
        try {
          String imageurl1;
          String imageurl2;
          String imageurl3;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String pic1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task1 = storage.ref().child(pic1).putFile(img1!);
          final String pic2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task2 = storage.ref().child(pic2).putFile(img2!);
          final String pic3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task3 = storage.ref().child(pic3).putFile(img3!);
          TaskSnapshot snapshot1 =
              await task1.whenComplete(() {}).then((snapshot) => snapshot);
          TaskSnapshot snapshot2 =
              await task2.whenComplete(() {}).then((snapshot) => snapshot);
          task3.whenComplete(() {}).then((snapshot3) async {
            imageurl1 = await snapshot1.ref.getDownloadURL();
            imageurl2 = await snapshot2.ref.getDownloadURL();
            imageurl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageurl1, imageurl2, imageurl3];
            _productService.uploadProduct(
                productname: productcontroller.text.trim(),
                image: imageList,
                quantity: int.tryParse(quantitycontroller.text) ?? 0,
                price: double.tryParse(pricecontroller.text) ?? 0.0);
            log("product name : ${productcontroller.text}");
            productcontroller.clear();
            pricecontroller.clear();
            quantitycontroller.clear();
            img1 = null;
            img2 = null;
            img3 = null;

            // _formkey.currentState!.reset();
            setState(() {
              isLoading = false;
            });
          return successSnackbar(context,  "Product added successfully!!");
          });
        } catch (e) {
          print('error');
        }
        // // setState(() {
        // // _formkey.currentState?.reset();
        // productcontroller.text = '';
        // img1 = null;
        // img2 = null;
        // img3 = null;
        // quantitycontroller.text = '';
        // pricecontroller.text = '';
        // // productcontroller.text = '';
        // // });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            dismissDirection: DismissDirection.down,
            content: Text(
              "All images must be provided!!",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            // margin: EdgeInsets.only(top: 70),
            duration: Duration(seconds: 2),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 10,
              right: 10,
            ),
          ),
        );
      }
      // setState(() {
      // _formkey.currentState?.reset();
      // productcontroller.text = '';
      // img1 = null;
      // img2 = null;
      // img3 = null;
      // quantitycontroller.text = '';
      // pricecontroller.text = '';
      // productcontroller.text = '';
      // });
    }
  }
}
