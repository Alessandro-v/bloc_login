import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageForm extends StatelessWidget {
  final String imagePath;
  final Function(String) onChanged;

  const AddImageForm({
    Key key,
    this.imagePath,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _placeholder = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50)
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () => _onAddImage(context),
            child: imagePath == null
                ? _placeholder
                : _ImageWidget(image: imagePath,)
        ),
        SizedBox(
          height: 5,
        ),
        Text('Add Profile Image'),
      ],
    );
  }

  _onAddImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: GestureDetector(
              onTap: () => _showCamera(context),
              child: Text('Add from Camera'),
            ),
          ),
          SizedBox(
            height: 40,
            child: GestureDetector(
              onTap: () => _showGallery(context),
              child: Text('Add from Library'),
            ),
          ),
        ],
      ),
    );
  }

  _showCamera(BuildContext context) {
    Navigator.of(context).pop();
    _showImagePicker(ImageSource.camera);
  }

  _showGallery(BuildContext context) {
    Navigator.of(context).pop();
    _showImagePicker(ImageSource.gallery);
  }

  _showImagePicker(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile image = await imagePicker.getImage(
        source: imageSource,
        imageQuality: 60
    );
    if (image != null) {
      onChanged(image.path);
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final String image;

  const _ImageWidget({
    Key key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _validURL = Uri.parse(image).isAbsolute;
    return Container(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: _validURL
            ? Image.network(
          image,
          fit: BoxFit.cover,
        )
            : Image.file(
          File(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}