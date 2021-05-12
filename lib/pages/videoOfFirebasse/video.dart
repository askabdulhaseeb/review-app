// import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';

// final fb = FirebaseDatabase.instance.reference().child("VideoLink");
// List<String> itemList = List();
// FirebaseAuth mAuth = FirebaseAuth.instance;
// PickedFile file;

// final metadata = firebase_storage.SettableMetadata(
//     contentType: 'video/quicktime',
//     customMetadata: {
//       'picked-file-path': file.path,
//     });
// Future uploadToStorage() async {
//   var uuid = Uuid();
//   dynamic id = uuid.v1();
//   try {
//     mAuth.signInAnonymously().then((value) async {
//       file = await ImagePicker().getImage(source: ImageSource.gallery);
//       Reference ref = FirebaseStorage.instance.ref().child("video").child(id);
//       UploadTask uploadTask = ref.putFile(File(file.path), metadata);

//       var downloadUrl = await (await uploadTask).ref.getDownloadURL();
//       final String url = downloadUrl.toString();
//       fb.child(id).set({
//         "id": id,
//         "link": url,
//       }).then((value) {
//         print("Done");
//       });
//     });
//   } catch (error) {
//     print(error);
//   }
// }
