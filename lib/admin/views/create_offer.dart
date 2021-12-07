import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:samrajya_admin/admin/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateOffer extends StatefulWidget {
  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  String productName,price,description,companyName,contact;


  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  final picker = ImagePicker();

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images')
          .child('${randomAlphaNumeric(9)}.png');

      final firebase_storage.UploadTask task =
      firebaseStorageRef.putFile(selectedImage);

      // final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "productName": productName,
        "price": price,
        "description": description,
        "companyName": companyName,
        "contact": contact,
      };
      crudMethods.addData4(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Add Data'),
      ),
      body: _isLoading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: selectedImage != null
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(6)),
                    width: MediaQuery.of(context).size.width,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black45,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Product Name",
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (val) {
                          productName = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Price",
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (val) {
                          price = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Description",
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (val) {
                          description = val;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Company Name",
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (val) {
                          companyName = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.deepPurple)),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Contact",
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (val) {
                          contact = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      uploadBlog();
                    },
                    label: Text('Add'),
                    icon: Icon(Icons.roofing_rounded),
                    backgroundColor: Colors.teal,
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
