/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/app/controller/add_category_controller.dart';
import 'package:vender/app/util/theme.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCategoryController>(builder: (value) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            title: Text(
              'Categories'.tr,
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18,
                  color: ThemeProvider.whiteColor),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (value.tabController.index == 1) {
                    value.onStoreCategory();
                  } else {
                    value.onAdminCategory();
                  }
                },
                icon: const Icon(Icons.add),
              )
            ],
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: TabBar(
                  controller: value.tabController,
                  labelColor: ThemeProvider.appColor,
                  labelStyle: const TextStyle(fontFamily: 'semibold'),
                  unselectedLabelColor: Colors.black,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  indicator: const UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.0, color: ThemeProvider.appColor),
                  ),
                  tabs: [
                    Tab(
                      text: 'Admin'.tr,
                    ),
                    Tab(
                      text: 'Store'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: value.tabController,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.adminData)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Are you sure'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      fontFamily: 'semi-bold'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'After confirming it, this category will disappear from your outlet. later you can activate it again.'
                                                      .tr,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ThemeProvider
                                                              .greyColor,
                                                          onPrimary:
                                                              ThemeProvider
                                                                  .whiteColor,
                                                          minimumSize: const Size
                                                              .fromHeight(35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Cancel'.tr,
                                                          style:
                                                              const TextStyle(
                                                            color: ThemeProvider
                                                                .whiteColor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Get.find<
                                                                  AddCategoryController>()
                                                              .onAdminStatus(
                                                            item.id as int,
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ThemeProvider
                                                              .appColor,
                                                          onPrimary:
                                                              ThemeProvider
                                                                  .whiteColor,
                                                          minimumSize: const Size
                                                              .fromHeight(35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Confirm'.tr,
                                                          style:
                                                              const TextStyle(
                                                            color: ThemeProvider
                                                                .whiteColor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.visibility_outlined,
                                  color: ThemeProvider.appColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.storeData)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  value.onEditStoreCategory(item.id as int);
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: ThemeProvider.appColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/delete.png',
                                                fit: BoxFit.cover,
                                                height: 80,
                                                width: 80,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Are you sure'.tr,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: 'semi-bold'),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('to delete Italian ?'.tr),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: ThemeProvider
                                                            .greyColor,
                                                        onPrimary: ThemeProvider
                                                            .whiteColor,
                                                        minimumSize: const Size
                                                            .fromHeight(35),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Cancel'.tr,
                                                        style: const TextStyle(
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Get.find<
                                                                AddCategoryController>()
                                                            .getDelete(
                                                                item.id as int);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: ThemeProvider
                                                            .appColor,
                                                        onPrimary: ThemeProvider
                                                            .whiteColor,
                                                        minimumSize: const Size
                                                            .fromHeight(35),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Delete'.tr,
                                                        style: const TextStyle(
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: ThemeProvider.appColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return disabledialog(
                                            item.id as int, item.status as int);
                                      });
                                },
                                icon: Icon(
                                  item.status == 1
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: ThemeProvider.appColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget addNewdialog() {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 10),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Add New!'.tr,
                    style: const TextStyle(fontFamily: 'semi-bold'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          border: const OutlineInputBorder(),
                          hintText: 'Category Name'.tr,
                          hintStyle: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeProvider.greyColor.shade300),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel'.tr,
                        style: const TextStyle(
                            color: ThemeProvider.appColor,
                            fontFamily: 'medium'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              color: ThemeProvider.greyColor.shade300),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.appColor,
                              fontFamily: 'medium'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget editdialog() {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 10),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Edit'.tr,
                    style: const TextStyle(fontFamily: 'semi-bold'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          border: const OutlineInputBorder(),
                          hintText: 'Category Name'.tr,
                          hintStyle: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeProvider.greyColor.shade300),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel'.tr,
                        style: const TextStyle(
                            color: ThemeProvider.appColor,
                            fontFamily: 'medium'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              color: ThemeProvider.greyColor.shade300),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.appColor,
                              fontFamily: 'medium'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget deletedialog(int id) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/delete.png',
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Are you sure'.tr,
              style: const TextStyle(fontSize: 24, fontFamily: 'semi-bold'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('to delete Italian ?'.tr),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.greyColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.find<AddCategoryController>().getDelete(id);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.appColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Delete'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget disabledialog(int id, int status) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Are you sure'.tr,
              style: const TextStyle(fontSize: 24, fontFamily: 'semi-bold'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'After confirming it, this category will disappear from your outlet. later you can activate it again.'
                  .tr,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.greyColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.find<AddCategoryController>()
                          .onStatusChange(id, status);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeProvider.appColor,
                      onPrimary: ThemeProvider.whiteColor,
                      minimumSize: const Size.fromHeight(35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Confirm'.tr,
                      style: const TextStyle(
                        color: ThemeProvider.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
