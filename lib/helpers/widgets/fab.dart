import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/business_logic_layer/cubit/image_management_cubit.dart';
import 'package:image_picker/image_picker.dart';

class AnimatedFab extends StatelessWidget {
  // receive the image picker instance
  final ImagePicker picker;
  const AnimatedFab({super.key, required this.picker});

  @override
  Widget build(BuildContext context) {
    //
    return FloatingActionButton(
      onPressed: () async {
        //pick an image from the gallery
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        //if the image is not null add it to the database
        if (image != null) {
          // ignore: use_build_context_synchronously
          context.read<ImageManagementCubit>().addImage(image);
        } else {
          null;
        }
      },
      //add icon
      child: const Icon(Icons.add),
    );
  }
}
