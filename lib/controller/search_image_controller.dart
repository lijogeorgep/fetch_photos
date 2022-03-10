import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../model/search_image.dart';
import '../services/search_image_service.dart';

class SearchImageController extends GetxController {
  var imageList = SearchImage().obs;
  var loading = true.obs;
  var keyword;
  var page = 1;
  var filtered = false.obs;
  List image_ids = [].obs;
  List image_preview = [];
  List image_large = [];
  List favourite_images = [].obs;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    fetchImages();
    paginateUniversityList();
    super.onInit();
  }

  Future fetchImages() async {
    if (filtered.value == true) {
      image_ids.clear();
      image_preview.clear();
      image_large.clear();
    }

    var images =
        await SearchImageService.fetchImagesService(this.keyword, this.page);
    if (images != null) {
      imageList.value = images;
      loading.value = false;
      filtered.value = false;
      for (var e in imageList.value.hits!) {
        image_ids.add(e.id);
        image_preview.add(e.previewUrl);
        image_large.add(e.largeImageUrl);
      }
    }
  }

  void paginateUniversityList() async {
    scrollController.addListener(() {
      var totalPages = imageList.value.totalHits! / 20.toInt();
      if ((scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) &&
          (page < totalPages)) {
        page++;
        fetchImages();
        update();
      }
    });
  }
}
