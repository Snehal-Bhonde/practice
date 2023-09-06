
// main.dart
import 'dart:convert';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  // This is the file that will be used to store the image
  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

Future<void> _uploadImg() async {
   print(_image!.path);
    AwsS3.uploadFile(
        accessKey: "Access key",
        secretKey: "secret key",
        file:_image!,
        bucket: "snehal-bucket",
        region: "ap-south-1",
        key: "image",
        metadata: {"test": "test"} // optional
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kindacode.com'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Center(
                // this button is used to open the image picker
                child: ElevatedButton(
                  onPressed: _openImagePicker,
                  child: const Text('Select An Image'),
                ),
              ),
              const SizedBox(height: 35),
              // The picked image will be displayed here
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Text('Please select an image'),
              ),
              _image != null
                  ?
                  Center(
                // this button is used to open the image picker
                child: ElevatedButton(
                  onPressed: _uploadImg,
                  child: const Text('upload An Image'),
                ),
              ): const Text(''),
            ]),
          ),
        ));
  }
}



class ProfileSelectionScreen extends StatefulWidget {
  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  List<Map<String, dynamic>> accounts = <Map<String, dynamic>>[];
  //var preferences = Preferences();
  @override
  void initState() {
    super.initState();
    getAccounts();
  }

  getAccounts() async {
   // String userList = await preferences.getUserAccounts();
    String userList = "await preferences.getUserAccounts()";
    var userListObj = await jsonDecode(userList);
    List<Map<String, dynamic>> accountList = [];
    for (var i = 0; i < userListObj.length; i++) {
      accountList.add(userListObj[i]);
    }
    // print(accounts);
    setState(() {
      accounts = accountList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Color(0xfff1f1f1),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title:
            Text("Choose Account", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
          ),
          body: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                    //  preferences.setUserCode(accounts[index]["user"]["code"]);
                    //  preferences.setUserDetails(jsonEncode(accounts[index]));
                    //  preferences.setUserAccounts(jsonEncode(accounts));
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (r) => false);
                    },
                    child: Card(
                      margin:
                      EdgeInsets.only(bottom: 25, left: 10, right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Image.asset("images/ic_profile.png",
                                width: 40, height: 40),
                            SizedBox(width: 10),
                            Text(accounts[index]["user"]["first_name"])
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ))
        // ListView.builder(
        //   padding: EdgeInsets.all(10),
        //             itemCount: accounts.length,
        //             itemBuilder: (context, index) {
        //               return Card(
        //                 child: Row(children: [
        //                   Image.asset("images/ic_profile.png",
        //                                     width: 25, height: 25),
        //                   Text("dsfkgskjdfgskdfg")
        //                 ],)
        //               );
        //             },
        //           ),
      ),
    );
  }
}
