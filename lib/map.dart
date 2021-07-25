import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:test_map/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_map/dialog.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  String nameUser;
  double lat, lng;


  @override
  void initState() {
    super.initState();
    findUser();
    checkPremission();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  Future<Null> findLatLng() async {
    print('findLatLng ==> work');
    Position position = await findPosition();
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<Position> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  /*Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat, Lng = $lng'),
        ),
      ].toSet();*/

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('RBRU Building'),
        position: LatLng(12.662405095621322, 102.10349526958919),
        infoWindow: InfoWindow(title: 'ตึก1'),
      ),
      Marker(
        markerId: MarkerId('RBRU Building'),
        position: LatLng(12.66214601506887, 102.10439917401717),
        infoWindow: InfoWindow(title: 'ตึก2'),
      ),
      Marker(
        markerId: MarkerId('RBRU Building'),
        position: LatLng(12.662748544018665, 102.10425528358563),
        infoWindow: InfoWindow(title: 'ตึก4'),
      ),
    ].toSet();
  }

  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: 350,
        padding: EdgeInsets.only(
            top: 50.0,
          ),
        child: lat == null
            ? MyStyle().showProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 15,
                ),
                onMapCreated: (context) {},
                myLocationEnabled: true,
                markers: myMarker(),
              ),
      );

  Future<Null> checkPremission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
            context,
            'ไม่ได้เปิด GPS',
            'กรุณาเปิด GPS เพื่อเข้าใช้งาน',
          );
        } else {
          // Find LatLng
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
            context,
            'ไม่ได้เปิด GPS',
            'กรุณาเปิด GPS เพื่อเข้าใช้งาน',
          );
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(
        context,
        'กรุณาเปิด GPS ค่ะ',
        'GPS ปิดอยู่ กรุณาเปิด เพื่อเข้าใช้งาน',
      );
    }
  }

  

}
