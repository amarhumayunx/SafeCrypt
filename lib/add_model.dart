import 'package:flutter/material.dart';
import 'package:safecrypt/colors/colors.dart';
import 'package:safecrypt/website_search.dart';
import 'website_save.dart';

import 'constants.dart';

class AddModal extends StatefulWidget {
  const AddModal({super.key});

  @override
  _AddModalState createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {
  List<String> websiteList = List.from(websites_names.websiteList); // Copy of predefined list
String selectedWebsite = "Selected Website Name"; // Default website

  final _formKey = GlobalKey<FormState>(); // Form Key

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validation Functions
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  @override
Widget build(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
    child: SingleChildScrollView(  // ✅ Wrap with ScrollView
      child: Form(
        key: _formKey, // Attach form key
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevent extra blank space
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: screenWidth * 0.4,
                height: 5,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 156, 156, 156),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20),
              WebsiteSearch(
              "Search for a website or app",
              websiteList: websiteList, // ✅ Pass the list of websites
              onWebsiteSelected: (String website) { // ✅ Handle selection
                setState(() {
                  selectedWebsite = website;
                });
              },
            ),
            SizedBox(height: 10),
            Column(
              children: [
                websiteContainer(context, (String website) {
                  setState(() {
                    selectedWebsite = website;
                  });
                }),

                // ✅ Rounded Rectangle for Selected Website
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1), // Light background color
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      border: Border.all(color: Colors.blueAccent, width: 1.5), // Border color
                    ),
                    child: Text(
                      selectedWebsite,
                      style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 16, 
                        color: Colors.blueAccent, // Text color
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                formHeading("Username"),
                formTextField("Enter Username", Icons.person, _usernameController, _validateUsername),
                formHeading("E-mail"),
                formTextField("Enter Email", Icons.email, _emailController, _validateEmail),
                formHeading("Password"),
                formTextField("Enter Password", Icons.lock_outline, _passwordController, _validatePassword, obscureText: true),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              height: screenHeight * 0.065,
              width: screenWidth * 0.7,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(5),  // ✅ Fix incorrect property
                      shadowColor: WidgetStatePropertyAll(Constants.buttonBackground),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              side: BorderSide(color: Constants.buttonBackground))),
                      backgroundColor: WidgetStatePropertyAll(Constants.buttonBackground)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Show a snackbar on successful submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form Submitted Successfully')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Okie Done", style: TextStyle(fontSize: 16, color: Colors.white))),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}


  /*@override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: screenWidth * 0.4,
              height: 5,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 156, 156, 156),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          searchText("Search for a website or app"),
          SizedBox(
            height: 10,
          ),
          websiteContainer(context),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
            child: Text(
              "www.twitter.com",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Column(
            children: [
              formHeading("Username"),
              formTextField("Enter Username", Icons.person),
              formHeading("E-mail"),
              formTextField("Enter Email", Icons.email),
              formHeading("Password"),
              formTextField("Enter Password", Icons.lock_outline)
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: screenHeight * 0.065,
            width: screenWidth * 0.7,
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(5),
                    shadowColor:
                        MaterialStatePropertyAll(Constants.buttonBackground),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            side:
                                BorderSide(color: Constants.buttonBackground))),
                    backgroundColor:
                        MaterialStatePropertyAll(Constants.buttonBackground)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Okie Done",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }*/

  Widget formTextField(String hintText, IconData icon, TextEditingController controller, String? Function(String?)? validator, {bool obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      controller: controller,
      validator: validator, // Adding validation logic
      obscureText: obscureText, // Allow hiding password
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
            child: Icon(icon, color: AppColors.secondary),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: TextStyle(color: Constants.searchGrey, fontWeight: FontWeight.w500),
          fillColor: Color.fromARGB(247, 232, 235, 237),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(20))),
      style: TextStyle(),
    ),
  );
}


  Widget formHeading(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

 Widget websiteContainer(BuildContext context, Function(String) onWebsiteSelected) {
  return Row(
    children: [
      // ✅ "Add" Button
      GestureDetector(
        onTap: () {
          _showAddWebsiteDialog(context, onWebsiteSelected); // ✅ Show input dialog
        },
        child: Container(
          height: 55,
          width: 120,
          decoration: BoxDecoration(
            color: Constants.logoBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 18),
                SizedBox(width: 4),
                Text("Add", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),

      // ✅ Horizontal Scrollable Website List
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: websiteList
                  .map((website) => websiteBlock(website, onWebsiteSelected)) // ✅ Display updated list
                  .toList(),
            ),
          ),
        ),
      ),
    ],
  );
}


void _showAddWebsiteDialog(BuildContext context, Function(String) onWebsiteSelected) {
  TextEditingController websiteController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // ✅ Rounded corners
        ),
        backgroundColor: Constants.logoBackground, // ✅ Themed background color
        title: Text(
          "Add a Website Name or URL",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary, // ✅ Themed text color
          ),
        ),
        content: TextField(
          controller: websiteController,
          style: TextStyle(color: Colors.black), // ✅ Input text color
          decoration: InputDecoration(
            hintText: "Enter website Name or URL",
            hintStyle: TextStyle(color: Colors.grey), // ✅ Themed hint color
            filled: true,
            fillColor: Colors.white, // ✅ Light background for input field
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Constants.lightBlue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Constants.buttonBackground, width: 2),
            ),
          ),
        ),
        actions: [
          // ✅ Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Constants.darkRed),
            ),
          ),

          // ✅ Add Button (With Themed Styling)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.buttonBackground, // ✅ Themed button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () async {
              String website = websiteController.text.trim();
              
              if (website.isNotEmpty) {
                // ✅ Add the website to the list & persist
                setState(() {
                  websites_names.websiteList.add(website);
                });

                await websites_names.saveWebsites(); // ✅ Save to SharedPreferences
                
                onWebsiteSelected(website); // ✅ Notify selection
              }
              
              Navigator.pop(context); // ✅ Close dialog
            },
            child: Text(
              "Add",
              style: TextStyle(fontSize: 16, color: Colors.white), // ✅ Themed button text color
            ),
          ),
        ],
      );
    },
  );
}







Widget websiteBlock(String websiteString, Function(String) onWebsiteSelected) {
  return GestureDetector(
    onTap: () {
      onWebsiteSelected(websiteString); // ✅ Updates selected website on tap
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          color: Constants.logoBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            websiteString,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    ),
  );
}






  Widget searchText(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 5, 5, 5), // add padding to adjust icon
              child: Icon(
                Icons.search,
                color: Constants.searchGrey,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Constants.searchGrey, fontWeight: FontWeight.w500),
            fillColor: Color.fromARGB(247, 232, 235, 237),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(20))),
        style: TextStyle(),
      ),
    );
  }
}