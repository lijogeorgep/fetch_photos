import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_image_controller.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  SearchImageController searchImageController =
      Get.put(SearchImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: searchImageController.favourite_images.isNotEmpty
            ? Obx(() {
                return ListView.separated(
                  itemCount: searchImageController.favourite_images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2 * 0.6,
                        height: MediaQuery.of(context).size.height / 2 * 0.6,
                        child: Card(
                          child: Image.network(
                            searchImageController.favourite_images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, index) =>
                      const SizedBox(
                    height: 5,
                  ),
                );
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                      child: Text(
                    'No favourite images',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
                ],
              ),
      ),
    );
  }
}
