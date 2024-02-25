import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallery/data_layer/model/image_model.dart';
import 'package:gallery/data_layer/service/sqflite.dart';
import 'package:image_picker/image_picker.dart';

part 'image_management_state.dart';

class ImageManagementCubit extends Cubit<ImageManagementState> {
  ImageManagementCubit() : super(ImageManagementInitial());

  List<ImageModel> images = [];

//add an image to the database
  void addImage(XFile? image) {
    //emit the loading state
    emit(ImageManagementLoading());
    //if the image is null emit an error
    if (image == null) {
      //emit the error state
      emit(ImageManagementAddError("Error adding image"));
    } else {
      //create an image model and insert it into the database
      ImageModel(imagePath: image.path);
      //get the images from the database
      SqliteService.createItem(ImageModel(imagePath: image.path));
      //get the images from the database

      getImages();
      emit(ImageManagementAddSuccess(ImageModel(imagePath: image.path)));
    }
  }

  //delete an image from the database
  void deleteImage(int id) {
    //emit the loading state
    emit(ImageManagementLoading());
    //delete the image from the database
    SqliteService.deleteItem(id).then((value) {
      //if the value is 1 emit the success state
      if (value == 1) {
        emit(ImageManagementDeleteSuccess(id.toString()));
        getImages();
        //if the value is not 1 emit the error state
      } else {
        emit(ImageManagementDeleteError("Error deleting image"));
      }
    });
  }

//get the images from the database
  void getImages() {
    //emit the loading state
    emit(ImageManagementLoading());
    //get the images from the database
    SqliteService.getItems().then((value) {
      //set the images to the value
      images = value;
      //if the images are empty emit the empty state
      if (images.isEmpty) {
        emit(Empty());
      } else {
        //if the images are not empty emit the loaded state
        emit(ImageManagementLoaded(images));
      }
    });
  }
}
