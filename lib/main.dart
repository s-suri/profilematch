import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:profilemachingapp/heart.dart';
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
      backgroundColor: Color(0xFFF8BBD0),
      bottomNavigationBar: bottomNavigationVar(),
      body: screenBody(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Container screenBody()
  {
    return Container(
      color: Color(0xFFF8BBD0),
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width/2.5,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    image: DecorationImage(
                        image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text("Uddesh Rajoriya",style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900
                  ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 10),
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
                      margin: EdgeInsets.only(left: 10),
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
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),

                  child: Text("My Visitors",style: TextStyle(fontSize: 16,color: Colors.white),),
                ),

                SizedBox(height: 50,),
              ],
            ),
          ), //Flexible

          Container(
            margin: EdgeInsets.only(top: 120),
            alignment: Alignment.center,
            child: Container(
                width: 50,
                height: MediaQuery.of(context).size.height,
                child: HeartWidget()),//Container
          ),


          Container(
            alignment: Alignment.bottomRight,
            child: buildProductImageCarouselSlider(),//Container
          ),



          // Container(
          //   margin: EdgeInsets.only(top: 100),
          //   padding: EdgeInsets.only(bottom: 20),
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: <Widget>[
          //
          //         Container(
          //           alignment: Alignment.topCenter,
          //           width: 40,
          //           child: HeartWidget(),
          //         ),
          //
          //
          //       ], //<Widget>[]
          //       mainAxisAlignment: MainAxisAlignment.center,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Container bottomNavigationVar()
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),

      ),
      child: SalomonBottomBar(
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
            title: Text("Mail",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),

          SalomonBottomBarItem(
            icon: Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.cover
                ),
              ),
            ),
            title: Text("Profile",style:
            TextStyle(
                color: Colors.pinkAccent
            ),),
            selectedColor: Colors.white,
          ),
        ],
      ),
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
        height: 300,
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.bottomRight,
        child: CarouselSlider(
          carouselController: _imageCarouselController,
          options: CarouselOptions(
              aspectRatio: 0.5,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: 130,
                      width: MediaQuery.of(context).size.width/2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        image: DecorationImage(
                            image: NetworkImage("https://i.pinimg.com/564x/1e/88/93/1e889313773c6f02fe21a878d73d437f.jpg"),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),

                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      alignment: Alignment.topLeft,
                      child: Text("${_carouselImageList[_currentImage]['name']}",style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w900
                      ),),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      alignment: Alignment.topLeft,
                      child: Text("${_carouselImageList[_currentImage]['status']}",style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          child: Icon(Icons.wallet_membership_rounded,color: Colors.white,),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          child: Icon(Icons.message_outlined,color: Colors.white,),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          child: Icon(Icons.arrow_downward,color: Colors.white,),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),

                  ],
                );
              },
            );
          }).toList(),
        ),
      );
    }
  }

}


