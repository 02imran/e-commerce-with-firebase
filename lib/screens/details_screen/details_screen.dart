import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_ecommerce_app/constants.dart';
import 'package:firebase_ecommerce_app/helpers/components/custom_button.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final _product;

  DetailsScreen(this._product);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: AppColor.deep_orange,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2.1,
                child: CarouselSlider(
                  items: widget._product['prod-img']
                      .map<Widget>((image) => Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (val, carPageChangedReason) {
                        setState(() {
                          // widget._dotPositon = val;
                        });
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: Text(
                  widget._product['prod-name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '\$ ${widget._product['prod-price'].toString()}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  widget._product['prod-desc'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(),
              customButton('Add to Cart', () {})

              // DotsIndicator(
              //   dotsCount: widget._cursolImages.length == 0
              //       ? 1
              //       : widget._cursolImages.length,
              //   position: widget._dotPositon.toDouble(),
              //   decorator: DotsDecorator(
              //       activeColor: AppColor.deep_orange,
              //       color: Colors.black12.withOpacity(0.1),
              //       spacing: EdgeInsets.all(2)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
