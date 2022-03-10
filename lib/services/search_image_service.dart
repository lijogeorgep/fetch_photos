import 'package:http/http.dart' as http;

import '../model/search_image.dart';

class SearchImageService {
  static var client = http.Client();
  static Future<SearchImage?> fetchImagesService(keyword, page) async {
    var url =
        "https://pixabay.com/api/?key=26049763-23821d51cdc88f7bf18f0aba5&q=$keyword&image_type=photo&page=$page";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      return searchImageFromJson(response.body);
    } else {
      print('no response');
      return null;
    }
  }
}
