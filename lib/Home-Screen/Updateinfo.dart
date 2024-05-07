// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  final Function(Customer) onSaveAddress;

  const AddAddressScreen({required this.onSaveAddress});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController _addressController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late GoogleMapController _mapController;
  late LatLng _mapLocation;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: '828 Sư Vạn Hạnh quận 10');
    _nameController = TextEditingController(text: 'Tú');
    _phoneController = TextEditingController(text: '0948099800');
    _mapLocation = const LatLng(10.7721, 106.6924);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _updateMapLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          _mapLocation = LatLng(locations.first.latitude, locations.first.longitude);
          _mapController.animateCamera(CameraUpdate.newLatLng(_mapLocation));
        });
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cập nhật thông tin',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: FontStyles.primaryColor,
        elevation: 0, // Remove appbar shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _mapLocation,
                      zoom: 15,
                    ),
                    markers: Set.from([
                      Marker(
                        markerId: MarkerId('location'),
                        position: _mapLocation,
                      ),
                    ]),
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Địa Chỉ Nhận',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: FontStyles.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Nhập địa chỉ nhận',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (address) {
                  _updateMapLocation(address);
                },
              ),
              SizedBox(height: 16),
              Text(
                'Họ tên',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: FontStyles.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nhập họ và tên',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Số điện thoại',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: FontStyles.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Nhập số điện thoại',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Customer customer = Customer(
                      name: _nameController.text,
                      address: _addressController.text,
                      phone: _phoneController.text,
                    );
                    widget.onSaveAddress(customer);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FontStyles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                    child: Text(
                      'Lưu thông tin',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Customer {
  final String name;
  final String address;
  final String phone;

  Customer({required this.name, required this.address, required this.phone});
}
