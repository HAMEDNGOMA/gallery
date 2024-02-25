import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/business_logic_layer/cubit/image_management_cubit.dart';
import 'package:gallery/data_layer/model/image_model.dart';
import 'package:gallery/helpers/font.dart';
import 'package:gallery/helpers/widgets/fab.dart';
import 'package:gallery/presentation_layer/widgets/grid_view_item.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //image picker instance
  final picker = ImagePicker();
  //list of images
  List<ImageModel> images = [];
  @override
  void initState() {
    setState(() {
      //get the images from the database
      images = context.read<ImageManagementCubit>().images;
    });
    super.initState();
  }

  ImageModel? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // app bar with title
        appBar: AppBar(
          title: Text(
            'معرض الصور',
            style: FontStyles.tajawalRegular(color: Colors.white),
          ),
          actions: [
            //if an image is selected show a delete button
            selectedImage != null
                ? IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //delete the selected image from the database
                      context
                          .read<ImageManagementCubit>()
                          .deleteImage(selectedImage!.id!);
                      setState(() {
                        //set the selected image to null
                        selectedImage = null;
                      });
                    },
                  )
                //if no image is selected show an empty container
                : const SizedBox()
          ],
          backgroundColor: Colors.deepPurple[400],
        ),

        // floating action button
        floatingActionButton: AnimatedFab(picker: picker),
        body: Container(
          padding: const EdgeInsets.all(8),
          //bloc builder to get images from the database
          child: BlocBuilder<ImageManagementCubit, ImageManagementState>(
            builder: (context, state) {
              //check the state of the bloc
              //if the state is loading show a circular progress indicator
              if (state is ImageManagementLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
                //if the state is loaded show the images in a grid view
              } else if (state is ImageManagementLoaded) {
                images = state.images;
                return GridView.builder(
                  //
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //show 2 images in a row
                    crossAxisCount: 2,
                    //space between the images
                    crossAxisSpacing: 8,
                    //space between the rows
                    mainAxisSpacing: 8,
                  ),
                  //number of items in the grid view
                  itemCount: images.length,
                  //grid view item
                  itemBuilder: (context, index) {
                    return GridViewItem(
                      //pass the image model to the grid view item
                      imageModel: images[index],
                      //check if the image is selected
                      isSelected: selectedImage?.id == images[index].id,
                      //function to select the image
                      onSelected: (selected) {
                        setState(() {
                          //set the selected image to the selected image
                          selectedImage = selected;
                        });
                      },
                    );
                  },
                );
              } else if (state is Empty) {
                //if there are no images in the database show a text
                return Center(
                  child: Text(
                    'لايوجد صور حالياً',
                    style: FontStyles.tajawalRegular(color: Colors.black),
                  ),
                );
              } else {
                //if there is an error show a text with the error message
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
