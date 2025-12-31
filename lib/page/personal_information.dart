import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/page/deliveryprogress.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';

class PersonalInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalInformationState();
  }
}

class _PersonalInformationState extends State<PersonalInformation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void Finish() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deliveryprogress()),
    );
    context.read<Restaurant>().addUser(
      nameController.text,
      emailController.text,
      numberController.text,
    );

    // add the current user to the database
    FirestoreService db = FirestoreService();
    db.saveUsersToFirestore(
      nameController.text,
      emailController.text,
      numberController.text,
    );
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('User details')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 10),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Your details here...',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  maxLength: 50,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white54,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  maxLength: 50,

                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email_rounded),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white54,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  maxLength: 50,
                  controller: numberController,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    icon: Icon(Icons.call_end),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white54,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: MyButton(onTap: Finish, text: 'Finish'),
          ),
        ],
      ),
    );
  }
}
