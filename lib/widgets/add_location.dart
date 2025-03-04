import 'package:flutter/material.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController _locationController = TextEditingController();

  void _fetchLocation() {
    // Implement GPS fetching logic here
    setState(() {
      _locationController.text = "Fetched GPS Location";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _locationController,
          decoration: InputDecoration(labelText: "Enter your location"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _fetchLocation,
          child: Text("Enable GPS"),
        ),
      ],
    );
  }
}
