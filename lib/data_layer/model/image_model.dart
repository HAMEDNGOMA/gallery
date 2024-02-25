// ImageModel class is used to store the image path and id of the image in the database.
class ImageModel {
  //image path
  String imagePath;
  //  image id
  int? id;

  ImageModel({
    required this.imagePath,
    this.id,
  });
  //convert the image model to a map
  //used to insert the image into the database
  //and to get the image from the database
  //and to delete the image from the database
  //there is no id in toMap because the id is autoincremented in the database

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
    };
  }

//convert the map to an image model
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imagePath: map['imagePath'],
      id: map['id'],
    );
  }
}
