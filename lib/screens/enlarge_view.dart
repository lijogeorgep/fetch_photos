import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnlargeView extends StatefulWidget {
  final String? image;
  const EnlargeView({Key? key, required this.image}) : super(key: key);

  @override
  _EnlargeViewState createState() => _EnlargeViewState();
}

class _EnlargeViewState extends State<EnlargeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// close button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            /// large image
            Expanded(
              child: SizedBox(
                width: 4000,
                height: 3039,
                child: CachedNetworkImage(
                  imageUrl:
                  widget.image!,
                  placeholder: (context,url)=>Center(child: CircularProgressIndicator()),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
