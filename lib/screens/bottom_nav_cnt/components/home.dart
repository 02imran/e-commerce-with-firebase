import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_ecommerce_app/constants.dart';
import 'package:firebase_ecommerce_app/screens/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> _cursolImages = [];
  List _product = [];
  var _dotPositon = 0;
  var _firebaseFireStore = FirebaseFirestore.instance;

  fatchCaursolImage() async {
    QuerySnapshot querySnapshot =
        await _firebaseFireStore.collection('carousel-images').get();
    setState(() {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        _cursolImages.add(querySnapshot.docs[i]['img-path']);
        print(querySnapshot.docs[i]['img-path']);
      }
    });
    return querySnapshot.docs;
  }

  fetchProduct() async {
    QuerySnapshot querySnapshot =
        await _firebaseFireStore.collection('products').get();
    setState(() {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        _product.add({
          'prod-name': querySnapshot.docs[i]['prod-name'],
          'prod-desc': querySnapshot.docs[i]['prod-desc'],
          'prod-img': querySnapshot.docs[i]['product-img'],
          'prod-price': querySnapshot.docs[i]['price']
        });
        print(_product);
      }
    });
    return querySnapshot.docs;
  }

  @override
  void initState() {
    fatchCaursolImage();
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Evaly',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child:

            /// Container
            Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search product here',
                            hintStyle: TextStyle(fontSize: 20.sp),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 58.h,
                        width: 60.h,
                        color: AppColor.deep_orange.withOpacity(0.9),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              AspectRatio(
                aspectRatio: 2.5,
                child: CarouselSlider(
                  items: _cursolImages
                      .map((e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(e),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (val, carPageChangedReason) {
                        setState(() {
                          _dotPositon = val;
                        });
                      }),
                ),
              ),
              SizedBox(height: 10.h),
              DotsIndicator(
                dotsCount: _cursolImages.length == 0 ? 1 : _cursolImages.length,
                position: _dotPositon.toDouble(),
                decorator: DotsDecorator(
                    activeColor: AppColor.deep_orange,
                    color: Colors.black12.withOpacity(0.1),
                    spacing: EdgeInsets.all(2)),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 200.h,
                child: Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _product.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          DetailsScreen(_product[index])));
                            },
                            child: Card(
                              elevation: 3,
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: Image.network(
                                      _product[index]['prod-img'][0],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    _product[index]['prod-name'],
                                    style: TextStyle(),
                                  ),
                                  Text(
                                      _product[index]['prod-price'].toString()),
                                ],
                              ),
                            ),
                          );
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
