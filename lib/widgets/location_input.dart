import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  LocationInput(this.onSelectPosition);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;

    Future<void> _getCurrentUserLocation() async {
      final locData = await Location().getLocation();
      final staticMapImage = LocationUtil.genereteLocationPreviewImage(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );

      setState(() {
        _previewImageUrl = staticMapImage;
      });
      widget.onSelectPosition(GeoCoord(
        locData.latitude,
        locData.longitude,
      ));
    }

    Future<void> _selectOnMap() async {
      final GeoCoord selectLocation = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => MapsScreen(),
        ),
      );
      if (selectLocation == null) return;
      final staticMapImage = LocationUtil.genereteLocationPreviewImage(
        latitude: selectLocation.latitude,
        longitude: selectLocation.longitude,
      );

      setState(() {
        _previewImageUrl = staticMapImage;
      });
      widget.onSelectPosition(selectLocation);
    }

    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: largura,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.green,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Nenhuma Localização')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              label: Text('Localização Atual',
                  style: TextStyle(fontSize: (largura / 30)),
                  overflow: TextOverflow.ellipsis),
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              label: Text('Selecione no MAPA',
                  style: TextStyle(fontSize: (largura / 30)),
                  overflow: TextOverflow.ellipsis),
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
