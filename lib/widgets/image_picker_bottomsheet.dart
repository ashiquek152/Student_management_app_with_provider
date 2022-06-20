
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_model_provider.dart';

class ImagePickBottomSheet extends StatelessWidget {
  const ImagePickBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async =>
                        Provider.of<ImageNotifier>(context, listen: false)
                            .pickCameraImage(),
                    icon: const Icon(Icons.camera,
                        color: Colors.yellow, size: 40)),
                const SizedBox(height: 15),
                const Text(
                  "Camera",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async =>Provider.of<ImageNotifier>(context, listen: false).pickGalleryImage(),
                    icon: const Icon(Icons.image_search_outlined,
                        color: Colors.yellow, size: 40)),
                const SizedBox(height: 15),
                const Text(
                  "Gallery",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
