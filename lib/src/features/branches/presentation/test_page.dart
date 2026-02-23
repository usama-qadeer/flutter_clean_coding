// Future<dynamic> updateProfile({
//   required String name,
//   required String email,
//   File? image,
// }) async {
//   final formData = await MultipartHelper.build(
//     fields: {
//       'name': name,
//       'email': email,
//     },
//     singleFile: image,
//     singleFileKey: 'image', // backend key
//   );

//   return api.postMultipart(
//     '/update-profile',
//     formData: formData,
//   );
// }

// Future<dynamic> uploadBlog({
//   required String title,
//   required String content,
//   required List<File> images,
// }) async {
//   final formData = await MultipartHelper.build(
//     fields: {
//       'title': title,
//       'content': content,
//     },
//     files: images,
//     filesKey: 'images[]', // backend expects array
//   );

//   return api.postMultipart(
//     '/create-blog',
//     formData: formData,
//   );
// }


// final formData = await MultipartHelper.build(
//   fields: {
//     'title': title,
//     'description': desc,
//     'category_id': categoryId,
//   },
//   singleFile: thumbnail,
//   singleFileKey: 'thumbnail',
//   files: galleryImages,
//   filesKey: 'gallery[]',
// );

