import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class data extends StatefulWidget {
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller1 = TextEditingController();
  final TextEditingController _emailcontroller1 = TextEditingController();
  final TextEditingController _Mobilenumbercontroller1 =
      TextEditingController();
  String radio1 = " ";
  CollectionReference adddata =
      FirebaseFirestore.instance.collection("adddata");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("adddata").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print("ConnectionState==>>${ConnectionState}");
            return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map(
                  (docs) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            flex: 2,
                            onPressed: (val) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Flutter Crud Opration"),
                                  content:
                                      Text("Do you want to delete this data"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        adddata.doc(docs.id).delete().then(
                                              (value) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Your Data was Delete"),
                                                ),
                                              ),
                                            );
                                      },
                                      child: Text("Yes"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("No"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SlidableAction(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              keyboardType: TextInputType.name,
                                              validator: (_namecontroller1) {
                                                if (_namecontroller1!.isEmpty) {
                                                  return '****Enter Your Name****';
                                                }
                                                return null;
                                              },
                                              controller: _namecontroller1,
                                              decoration: InputDecoration(
                                                labelText: "Name",
                                                hintText:
                                                    "Enter Your Full Name",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (_emailcontroller) {
                                                if (_emailcontroller!.isEmpty) {
                                                  return '****Enter Your Email Address****';
                                                }
                                                return null;
                                              },
                                              controller: _emailcontroller1,
                                              decoration: InputDecoration(
                                                labelText: "Email Address",
                                                hintText: "Enter your email id",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              validator:
                                                  (_Mobilenumbercontroller1) {
                                                if (_Mobilenumbercontroller1!
                                                    .isEmpty) {
                                                  return '****Enter Your Mobile Numbera****';
                                                }
                                                return null;
                                              },
                                              controller:
                                                  _Mobilenumbercontroller1,
                                              decoration: InputDecoration(
                                                labelText: "Mobile number",
                                                hintText: "Enter Your Name",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            //
                                            SizedBox(
                                              height: 25,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                adddata.doc(docs.id).update(
                                                  {
                                                    'name':
                                                        _namecontroller1.text,
                                                    'email':
                                                        _emailcontroller1.text,
                                                    'number':
                                                        _Mobilenumbercontroller1
                                                            .text,
                                                    'gender': radio1,
                                                  },
                                                ).then(
                                                  (value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                        "Data update Successfully",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                _emailcontroller1.clear();
                                                _namecontroller1.clear();
                                                _Mobilenumbercontroller1
                                                    .clear();
                                              },
                                              child: const Text("Update data"),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text("${docs["name"]}"),
                        subtitle: Text("${docs["number"]}"),
                        trailing: Text("${docs["email"]}"),
                        leading: Text("${docs["gender"]}"),
                      ),
                    );
                  },
                ).toList());
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
