import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faiward2/services/auth.dart';
import 'package:faiward2/services/database.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController topicController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();
  AuthMethods authMethods = new AuthMethods();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add topics'),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  children: <Widget>[
                    TextFormField(
                      controller: topicController,
                      maxLines: null,
                      decoration:
                          InputDecoration(labelText: 'Title of the topic'),
                      validator: (String value) {
                        // if (value.trim().length <= 0) {
                        if (value.isEmpty || value.length < 10) {
                          return 'Description is required and should be 10+ characters long.';
                        }
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration:
                          InputDecoration(labelText: 'Content of the topic'),
                      validator: (String value) {
                        // if (value.trim().length <= 0) {
                        if (value.isEmpty || value.length < 10) {
                          return 'Content is required and should be 10+ characters long.';
                        }
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        child: Text(
                          'POST',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                        textColor: Colors.blue,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Firestore.instance.collection("posts").add({
                            "topic": topicController.text,
                            'description': descriptionController.text,
                          });

                          setState(() {
                            isLoading = false;
                            topicController.clear();
                            descriptionController.clear();
                          });
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
