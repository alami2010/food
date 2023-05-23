/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:driver/app/controller/reviews_controller.dart';
import 'package:driver/app/env.dart';
import 'package:driver/app/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          title: Text(
            'Reviews'.tr,
            style: const TextStyle(
                fontFamily: 'bold',
                fontSize: 18,
                color: ThemeProvider.whiteColor),
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: value.reviews.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                "assets/images/no-data.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No Reviews Found'.tr,
                              style: const TextStyle(
                                color: ThemeProvider.appColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: List.generate(
                            value.reviews.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: FadeInImage(
                                          height: 60,
                                          width: 60,
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.reviews[index].cover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/error.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                height: 60,
                                                width: 60,
                                                'assets/images/error.png',
                                                fit: BoxFit.cover);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${value.reviews[index].firstName} ${value.reviews[index].lastName}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'medium'),
                                              ),
                                              Text(value.reviews[index].msg
                                                  .toString()),
                                              Text(
                                                value.reviews[index].createdAt
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .greyColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
              ),
      );
    });
  }
}
