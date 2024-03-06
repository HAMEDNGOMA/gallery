import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:gallery/data_layer/model/image_model.dart';

class GridViewItem extends StatefulWidget {
  final bool isSelected;
  final ImageModel imageModel;
  final Function(ImageModel imageModel) onSelected;
  const GridViewItem(
      {Key? key,
      required this.imageModel,
      required this.isSelected,
      required this.onSelected})
      : super(key: key);

  @override
  State<GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //select the image
      onLongPress: () {
        widget.onSelected(widget.imageModel);
      },

      //show the image in the image viewer
      onTap: () {
        final imageProvider =
            Image.file(File(widget.imageModel.imagePath)).image;
        showImageViewer(context, imageProvider, onViewerDismissed: () {
          print("dismissed");
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(File(widget.imageModel.imagePath)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: widget.isSelected
                ? Colors.blue.withOpacity(0.4)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
