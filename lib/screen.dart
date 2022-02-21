import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class Fire extends StatefulWidget {
  @override
  _FireState createState() => _FireState();
}

class _FireState extends State<Fire> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _Mobilenumbercontroller = TextEditingController();
  String radio = " ";

  CollectionReference adddata =
      FirebaseFirestore.instance.collection("adddata");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => data(),
              ),
            );
          },
        ),
        title: const Text(
          "Firebase",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (_namecontroller) {
                    if (_namecontroller!.isEmpty) {
                      return '****Enter Your Name****';
                    }
                    return null;
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter Your Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (_emailcontroller) {
                    if (_emailcontroller!.isEmpty) {
                      return '****Enter Your Email Address****';
                    }
                    return null;
                  },
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    hintText: "Enter your email id",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (_Mobilenumbercontroller) {
                    if (_Mobilenumbercontroller!.isEmpty) {
                      return '****Enter Your Mobile Numbera****';
                    }
                    return null;
                  },
                  controller: _Mobilenumbercontroller,
                  decoration: InputDecoration(
                    labelText: "Mobile number",
                    hintText: "Enter Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Radio(
                      value: 'male',
                      groupValue: radio,
                      onChanged: (value) {
                        setState(
                          () {
                            radio = value.toString();
                          },
                        );
                      },
                    ),
                    const Text("Male"),
                    Radio(
                      value: 'female',
                      groupValue: radio,
                      onChanged: (value) {
                        setState(
                          () {
                            radio = value.toString();
                          },
                        );
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      adddata
                          .add(
                            {
                              'name': _namecontroller.text,
                              'email': _emailcontroller.text,
                              'number': _Mobilenumbercontroller.text,
                              'gender': radio,
                            },
                          )
                          .then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Data add Successfully"),
                              ),
                            ),
                          )
                          .catchError(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Data add Successfully"),
                              ),
                            ),
                          );

                      _Mobilenumbercontroller.clear();
                      _emailcontroller.clear();
                      _namecontroller.clear();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => data(),
                      ),
                    );
                  },
                  child: const Text("Submit your data"),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
