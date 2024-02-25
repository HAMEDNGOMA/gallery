part of 'image_management_cubit.dart';

@immutable
sealed class ImageManagementState {}

final class ImageManagementInitial extends ImageManagementState {}

final class ImageManagementLoading extends ImageManagementState {}

final class ImageManagementLoaded extends ImageManagementState {
  final List<ImageModel> images;
  ImageManagementLoaded(this.images);
}

final class Empty extends ImageManagementState {}

final class ImageManagementError extends ImageManagementState {
  final String message;
  ImageManagementError(this.message);
}

final class ImageManagementDelete extends ImageManagementState {
  final String id;
  ImageManagementDelete(this.id);
}

final class ImageManagementDeleteError extends ImageManagementState {
  final String message;
  ImageManagementDeleteError(this.message);
}

final class ImageManagementDeleteSuccess extends ImageManagementState {
  final String id;
  ImageManagementDeleteSuccess(this.id);
}

final class ImageManagementAdd extends ImageManagementState {
  final ImageModel image;
  ImageManagementAdd(this.image);
}

final class ImageManagementAddError extends ImageManagementState {
  final String message;
  ImageManagementAddError(this.message);
}

final class ImageManagementAddSuccess extends ImageManagementState {
  final ImageModel image;
  ImageManagementAddSuccess(this.image);
}
