import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  File? image;
  final picker = ImagePicker();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height/10,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: height/3,
                    width: width/1.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: image == null ? InkWell(
                          onTap: ()async{
                            final file = await picker.pickMedia();
                            setState(() {
                              image = File(file!.path);
                            });

                          },
                          child: Icon(Icons.image,color: Colors.black12,size: 40,)) : Image.file(image!,fit: BoxFit.fill,),
                    ),
                  ),
                ),
                SizedBox(height: height/10,), SizedBox(height: height/10,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                      onPressed: ()async {


                        final response = await http.post(
                          Uri.parse('<-------------Your api--------->'),
                          headers: {
                            'Api-Token':'<---------Your api token>'
                          },
                          body: {
                            'Map attribute':'value'
                          },
                        );

                        final responseJson = json.decode(response.body);

                        print(responseJson);



                      },
                    color: Colors.deepPurpleAccent,
                    minWidth: width/1.2,
                    height: height/12,
                    shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
