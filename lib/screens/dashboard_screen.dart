import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safecrypt/add_model.dart';
import 'package:safecrypt/password_model.dart';
import 'package:safecrypt/constants.dart';
import 'package:safecrypt/category_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/bell.svg';
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => bottomModal(context),
          backgroundColor: Constants.fabBackground,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    print("Categories Clicked");
                    // TODO: Navigate to categories screen
                  },
                  child: SvgPicture.asset("assets/images/4square.svg"),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    print("Shield Clicked");
                    // TODO: Navigate to security settings screen
                  },
                  child: SvgPicture.asset("assets/images/shield.svg"),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profilePicAndBellIcon(assetName, screenHeight),
                const SizedBox(height: 20),
                searchText("Search Password"),
                const SizedBox(height: 10),
                HeadingText("Category"),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    print("Category Clicked");
                    // TODO: Implement category navigation
                  },
                  child: CategoryBoxes(),
                ),
                const SizedBox(height: 10),
                HeadingText("Recently Used"),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Constants.passwordData.length,
                  itemBuilder: (context, index) {
                    final password = Constants.passwordData[index];
                    return GestureDetector(
                      onTap: () {
                        print("Password Clicked: ${password.websiteName}");
                        // TODO: Navigate to password details screen
                      },
                      child: PasswordTile(password, context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PasswordTile(passwords password, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              LogoBox(password, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      password.websiteName,
                      style: TextStyle(
                        color: Color.fromARGB(255, 22, 22, 22),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      password.email,
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 39, 39),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SvgPicture.asset("assets/images/copy.svg", height: screenHeight * 0.030),
        ],
      ),
    );
  }

  Widget LogoBox(passwords password, BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Constants.logoBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 0.5,
        child: Image.network(password.logoUrl),
      ),
    );
  }

  Widget HeadingText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget CategoryBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryBox(
            outerColor: Constants.lightBlue,
            innerColor: Constants.darkBlue,
            logoAsset: "assets/images/codesandbox.svg"),
        CategoryBox(
            outerColor: Constants.lightGreen,
            innerColor: Constants.darkGreen,
            logoAsset: "assets/images/compass.svg"),
        CategoryBox(
            outerColor: Constants.lightRed,
            innerColor: Constants.darkRed,
            logoAsset: "assets/images/creditcard.svg"),
      ],
    );
  }

  Widget profilePicAndBellIcon(String assetName, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 35, 20.0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              circleAvatarRound(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Muhammad Humayun",
                      style: TextStyle(
                        color: Color.fromARGB(255, 22, 22, 22),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Good morning",
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 39, 39),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SvgPicture.asset(assetName, height: screenHeight * 0.035),
        ],
      ),
    );
  }

  Widget circleAvatarRound() {
    return CircleAvatar(
      radius: 28,
      backgroundColor: Color.fromARGB(255, 213, 213, 213),
      child: CircleAvatar(
        radius: 26.5,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profilepic.jpg"),
            radius: 25,
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
            padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
            child: Icon(
              Icons.search,
              color: Constants.searchGrey,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Constants.searchGrey,
            fontWeight: FontWeight.w500,
          ),
          fillColor: Color.fromARGB(247, 232, 235, 237),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        style: TextStyle(),
      ),
    );
  }

  Future<dynamic> bottomModal(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors
                        .white, //forDialog ? Color(0xFF737373) : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: AddModal(),
              ),
            )
          ]);
        });
  }

  Widget bottomSheetWidgets(BuildContext context) {
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
          Row(
            children: [
              Container(
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                    color: Constants.logoBackground,
                    borderRadius: BorderRadius.circular(20)),
                child: FractionallySizedBox(
                  heightFactor: 0.5,
                  widthFactor: 0.5,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Add",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
