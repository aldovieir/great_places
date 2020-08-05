import 'dart:io';
import 'package:flutter_google_maps/flutter_google_maps.dart';

import '../widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:great_places/Providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  GeoCoord _pickedPositon;
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(GeoCoord pickdPositon) {
    setState(() {
      _pickedPositon = pickdPositon;
    });
  }

  bool isValid() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPositon != null;
  }

  void _submitForm() {
    if (!isValid()) return;

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedPositon);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                      ),
                    ),
                    SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(height: 10),
                    LocationInput(this._selectPosition),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            onPressed: isValid() ? _submitForm : null,
            icon: Icon(Icons.add),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text('Adiconar'),
          ),
        ],
      ),
    );
  }
}
