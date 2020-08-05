import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialPosition;

  final bool isReadonly;

  MapsScreen({
    this.initialPosition = const PlaceLocation(
      latitude: -22.9378916,
      longitude: 10.600000381469727,
    ),
    this.isReadonly = false,
  });

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GeoCoord _pickedPosition;
  void _selectPosition(GeoCoord position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione..'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialPosition: GeoCoord(
          widget.initialPosition.latitude,
          widget.initialPosition.longitude,
        ),
        //minZoom: 10.0,
        // initialZoom: 11.0,
        // maxZoom: 18.0,
        onTap: widget.isReadonly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadonly)
            ? null
            : {
                Marker(
                  _pickedPosition ?? widget.initialPosition.toGeoCoord(),
                ),
              },
      ),
    );
  }
}
