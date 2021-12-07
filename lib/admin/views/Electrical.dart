import 'package:cached_network_image/cached_network_image.dart';
import 'package:samrajya_admin/admin/views/create_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Electrical extends StatefulWidget {
  @override
  _ElectricalState createState() => _ElectricalState();
}

class _ElectricalState extends State<Electrical> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('Elec');
    return Scaffold(
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var dat = snapshot.data.docs[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(dat['imgUrl']),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              dat['productName'],textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'price: ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: dat['price'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Description: ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: dat['description'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Company: ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: dat['companyName'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Contact: ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: dat['contact'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Item: ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: dat['item'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Center(
                            child: FlatButton(
                              color: Color.fromRGBO(161, 108, 164, 1.0),
                              child: const Text('Edit'),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              textColor: Colors.white,
                              onPressed: () {
                                productNameController.text = dat['productName'];
                                priceController.text = dat['price'];
                                descriptionController.text = dat['description'];
                                imageUrlController.text = dat['imgUrl'];
                                companyNameController.text =dat['companyName'];
                                contactController.text =dat['contact'];
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Container(
                                        color: Colors.greenAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 28),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              _buildTextField(productNameController,
                                                  'Product Name'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  priceController, 'Price'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  descriptionController, 'Description'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  companyNameController, 'Company Name'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  contactController, 'Contact'),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  snapshot.data.docs[index]
                                                      .reference
                                                      .update({
                                                    "productName": productNameController.text,
                                                    "price": priceController.text,
                                                    "description": descriptionController.text,
                                                    "companyName":companyNameController.text,
                                                    "contact": contactController.text,
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      18.0),
                                                  child:
                                                  Text('Update product'),
                                                ),
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  snapshot.data.docs[index]
                                                      .reference
                                                      .delete();
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      18.0),
                                                  child:
                                                  Text('Delete product'),
                                                ),
                                                color: Colors.green,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Text("");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateBlog());
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

_buildTextField(TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: Colors.blue, border: Border.all(color: Colors.deepPurple)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    ),
  );
}
