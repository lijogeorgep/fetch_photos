import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_image_controller.dart';
import 'enlarge_view.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SearchImageController _searchImageController =
      Get.put(SearchImageController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController keywordController = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _searchImageController.loading.value == true
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('PixaBay'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  /// search section
                  search(),

                  /// images grid
                  imageBox(),
                ],
              ),
            );
    });
  }

  Widget search() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //---search box
          padding: const EdgeInsets.only(left: 2),

          child: Center(
            child: TextFormField(
              controller: keywordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter search keyword';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  visible = true;
                });
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _searchImageController.filtered.value = true;
                              _searchImageController.page = 1;
                              _searchImageController.keyword =
                                  keywordController.text;
                              _searchImageController
                                  .fetchImages()
                                  .then((value) {});
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visible,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              keywordController.clear();

                              _searchImageController.keyword = null;
                              _searchImageController.image_ids.clear();
                              _searchImageController.image_preview.clear();
                              _searchImageController.image_large.clear();
                              visible = false;
                              _searchImageController.fetchImages();
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: "Search",
                hintStyle: const TextStyle(fontSize: 11),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageBox() {
    final orientation = MediaQuery.of(context).orientation;
    return _searchImageController.image_ids.isEmpty
        ? const Center(
            child: Text(
            'No search result available',
            style: TextStyle(color: Colors.grey),
          ))
        : Expanded(
            child: GridView.builder(
              controller: _searchImageController.scrollController,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              itemCount: _searchImageController.image_ids.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 150 / 99,
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 2),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(EnlargeView(
                          image: _searchImageController.image_large[index],
                        ));
                      },
                      child: Card(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            _searchImageController.image_preview[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: FavoriteButton(
                          isFavorite: _searchImageController.favourite_images
                                  .contains(
                                      _searchImageController.image_large[index])
                              ? true
                              : false,
                          iconDisabledColor: Colors.white,
                          iconSize: 35.0,
                          valueChanged: (_isFavorite) {
                            _searchImageController.favourite_images.contains(
                                    _searchImageController.image_large[index])
                                ? _searchImageController.favourite_images
                                    .remove(_searchImageController
                                        .image_large[index])
                                : _isFavorite
                                    ? _searchImageController.favourite_images
                                        .add(_searchImageController
                                            .image_large[index])
                                    : _searchImageController.favourite_images
                                        .remove(_searchImageController
                                            .image_large[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
