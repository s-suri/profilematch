import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  var _carouselImageList = [];
  int _currentImage = 0;

  CarouselController _imageCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    fetchShopData();
  }


   void fetchShopData() async {
    final response = await http.get(
        Uri.parse("https://gorest.co.in/public/v1/users?page=1"),);

    var items = json.decode(response.body)['data'];

    if(response.statusCode == 200)
      {
        print("surender ${items}");

        setState(() {
          _carouselImageList = items;
        });
      }
    else
      {
        print("Something went wrong");
      }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home,color: _currentIndex == 0 ? Colors.pinkAccent : Colors.grey),
            title: Text("Home",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.message_outlined,color: _currentIndex == 1 ? Colors.pinkAccent : Colors.grey),
            title: Text("Message",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.mail_outline_sharp,color: _currentIndex == 2 ? Colors.pinkAccent : Colors.grey),
            title: Text("Main",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person,color: _currentIndex == 3 ? Colors.pinkAccent : Colors.grey),
            title: Text("Profile",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF06292),
        child: Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                              image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                              fit: BoxFit.cover
                          ),
                        ),

                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.topLeft,
                        child: Text("Uddesh Rajoriya",style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w900
                        ),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.topLeft,
                        child: Text("Gwalior, India",style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(

                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30),
                            child: Text("Religion:",style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Hindu",style: TextStyle(
                                fontSize: 18,
                                color: Colors.pink,
                                fontWeight: FontWeight.w400
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        color: Colors.red,
                        child: Text("My Visitors",style: TextStyle(fontSize: 16),),
                      )

                    ],
                  ),//Container
                ), //Flexible
                SizedBox(
                  width: 20,
                ), //SizedBox
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: buildProductImageCarouselSlider(),//Container
                ),
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildProductImageCarouselSlider() {
    if (_carouselImageList.length == 0) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return Container(
        child: Column(
          children: [
            Container(

              child: CarouselSlider(
                carouselController: _imageCarouselController,
                options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImage = index;
                      });
                    }),
                items: _carouselImageList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.gif',
                            image: "https://i.pinimg.com/564x/1e/88/93/1e889313773c6f02fe21a878d73d437f.jpg",
                            fit: BoxFit.cover,
                          )
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30,top: 20),
                    alignment: Alignment.topLeft,
                    child: Text("${_carouselImageList[_currentImage]['name']}",style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                    ),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    alignment: Alignment.topLeft,
                    child: Text("${_carouselImageList[_currentImage]['status']}",style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400
                    ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        color: Colors.red,
                        child: Icon(Icons.message_outlined,color: Colors.white,),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        color: Colors.red,
                        child: Icon(Icons.arrow_downward,color: Colors.white,),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

}


