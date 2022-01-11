import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wallpaper.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            
            padding: const EdgeInsets.all(16.0),
            child: SearchField(
              

              suggestions: [
                 "Andhra Pradesh",
                  "Arunachal Pradesh",
                  "Assam",
                  "Bihar",
                  "Chhattisgarh",
                  "Goa",
                  "Gujarat",
                  "Haryana",
                  "Himachal Pradesh",
                  "Jammu and Kashmir",
                  "Jharkhand",
                  "Karnataka",
                  "Kerala",
                  "Madhya Pradesh",
                  "Maharashtra",
                  "Manipur",
                  "Meghalaya",
                  "Mizoram",
                  "Nagaland",
                  "Odisha",
                  "Punjab",
                  "Rajasthan",
                  "Sikkim",
                  "Tamil Nadu",
                  "Telangana",
                  "Tripura",
                  "Uttarakhand",
                  "Uttar Pradesh",
                  "West Bengal",
                  "Chandigarh",
                  "Delhi",
              ],
    maxSuggestionsInViewPort: 10,
                itemHeight: 50,
                onTap: (value) {
                  print(value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      /* builder: (_) => ChooseYourPlanPage(),*/
                        builder: (_) => Details(value)
                      // MobileOTPVerificationScreen(
                      // response.data['response_data']['sid']),
                    ),
                  );
                },
                // suggestionsDecoration:BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/search.png"),
                //     fit: BoxFit.cover,
                //   ),
                //   // color: Color(0xFF9754C7)
                // ) ,
    searchInputDecoration:
    InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.white,
        ),
        // borderSide: BorderSide(
        //   color: Colors.grey,
        //   width: 1.0,
        // ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius:
        BorderRadius.all(Radius.circular(12.0)),
      ),
      hintText: 'Search state',
      hintStyle: TextStyle(color: Colors.white),

    ),
                searchStyle: TextStyle(color: Colors.white),


            ),
          ),
        ),
      ),
    );
  }
}
