import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
pickImage(ImageSource imageSource) async{
  ImagePicker _imagePicker= ImagePicker();
  XFile? _file= await _imagePicker.pickImage(source: imageSource);
  if(_file!=null){
    return _file.readAsBytes();
  }
  print("no image selected yet");

}