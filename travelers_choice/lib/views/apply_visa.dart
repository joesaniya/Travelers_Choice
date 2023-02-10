import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/builder.dart';
import 'package:flutx/core/state_management/controller_store.dart';

import '../controllers/apply_visa_controller.dart';

class ApplyVisa extends StatefulWidget {

  const ApplyVisa({Key? key,}) : super(key: key);

  @override
  State<ApplyVisa> createState() => _ApplyVisaState();
}

class _ApplyVisaState extends State<ApplyVisa> {


  // late ApplyVisaController controller;
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late FocusNode nameNode;


  @override
  void initState() {
    nameNode = FocusNode();
    nameNode.addListener(() {
      setState(() {});
    });
    super.initState();

  }


  @override
  void dispose() {
    nameNode.dispose();

    super.dispose();
  }

  String? _name = "";

  @override
  Widget build(BuildContext context){
    return   Scaffold(
      appBar: AppBar(
        title: Text("Visa Details",style: TextStyle(color: Colors.black),),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: nameController,
              focusNode: nameNode,
              onSaved: (value){
                value = _name;
              },
              validator:  (_name) {
                if (_name!.isEmpty) {
                  return "Enter your name";
                } else if (_name.length <= 3) {
                  return "Enter up to name three characters";
                } else {
                  return null;
                }
              },
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                prefixIcon:Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Enter your name",
                errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold),

                // suffix:(isLocationEnable != null)? Icon(Icons.my_location,color: Colors.red,) : null,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              if(formKey.currentState!.validate()){

                formKey.currentState!.save();
                print(nameController.text);

              }
            }, child: Text("Submit"))
          ],
        ),
      )
    );



  }
}
