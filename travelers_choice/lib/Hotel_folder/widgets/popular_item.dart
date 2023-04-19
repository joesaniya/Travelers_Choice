import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PopularItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String rating;

  const PopularItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        height: 239,
        width: 178,
        child: InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //       imageUrl: imageUrl,
            //       title: name,
            //       price: price,
            //       rawRating: rating,
            //     ),
            //   ),
            // );
          },
          child: Stack(
            children: [
              Hero(
                tag: imageUrl,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(
                      imageUrl,
                      scale: 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child:       Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: ClipOval(
                              child: Material(
                                color: const Color(0xff1529e8).withAlpha(24),
                                child: Container(
                                  child: InkWell(
                                    highlightColor: const Color(0xff1529e8)
                                        .withAlpha(20),
                                    splashColor: const Color(0xff1529e8)
                                        .withAlpha(100),
                                    child: SizedBox(
                                        width: 44,
                                        height: 44,
                                        child: Icon(
                                          MdiIcons.heartOutline,
                                          // isSelected
                                          //     ? MdiIcons.heart
                                          //     : MdiIcons.heartOutline,
                                          // color: controller
                                          //     .colorAnimation.value,
                                          // size: controller
                                          //     .sizeAnimation.value,

                                         
                                        )),
                                    onTap: ()  {
                                   
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                      
                // child: ClipOval(
                //   child: Container(
                //     height: 23,
                //     width: 23,
                //     color: kTextColor,
                //     child: Padding(
                //       padding: const EdgeInsets.all(5),
                //       child: SvgPicture.asset(
                //         'assets/icons/heart.svg',
                //       ),
                //     ),
                //   ),
                // ),
             
              ),
              Positioned(
                bottom: 15,
                left: 15,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          FxText.bodyMedium(name, fontWeight: 500),
                          FxText.bodyMedium(price, fontWeight: 500),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   children: [
                        //     SvgPicture.asset('assets/icons/star.svg'),
                        //    FxSpacing.width(4),
                        //      FxText.bodyMedium("Rating", fontWeight: 500),
                        //   ],
                        // ),
                        Container(
                          margin: const EdgeInsets.only(left: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FxText.bodyMedium("Rating", fontWeight: 500),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Hero(
                                    tag: "product_raing",
                                    child:
                                        FxText.bodyMedium('4', fontWeight: 700),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: FxStarRating(rating: 2.55))
                                ],
                              )
                            ],
                          ),
                        ),

                        FxText.bodySmall(
                          'per night',
                          // controller.product.bookingType.toString(),
                          fontWeight: 300,
                          color: Colors.white,
                          // color: theme.colorScheme.onPrimary,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
