import 'package:flutter/material.dart';
import 'constants.dart'; // Import your constants file

class WebsiteSearch extends StatefulWidget {
  final String hintText; // ✅ Custom placeholder text
  final List<String> websiteList;
  final Function(String) onWebsiteSelected;

  const WebsiteSearch(this.hintText, {super.key, required this.websiteList, required this.onWebsiteSelected});

  @override
  _WebsiteSearchState createState() => _WebsiteSearchState();
}

class _WebsiteSearchState extends State<WebsiteSearch> {
  final TextEditingController _searchController = TextEditingController();
  String? _searchResult; // Store search result

  void _searchWebsite(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResult = null; // Reset if empty
      });
      return;
    }

    if (widget.websiteList.contains(query)) {
      setState(() {
        _searchResult = query; // ✅ Website found
      });
      widget.onWebsiteSelected(query); // ✅ Select website
    } else {
      setState(() {
        _searchResult = "Website not found."; // ❌ Website not found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: _searchController,
            onChanged: _searchWebsite, // ✅ Search as user types
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                child: Icon(Icons.search, color: Constants.searchGrey),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(16),
              hintText: widget.hintText, // ✅ Use custom placeholder
              hintStyle: TextStyle(color: Constants.searchGrey, fontWeight: FontWeight.w500),
              fillColor: Color.fromARGB(247, 232, 235, 237),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),

        SizedBox(height: 10),

        // ✅ Search Result Display
        _searchResult != null
            ? Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  _searchResult!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _searchResult == "Website not found." ? Colors.red : Constants.darkRed,
                  ),
                ),
              )
            : SizedBox(), // Hide if no search result
      ],
    );
  }
}
