import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/widgets/image_inputCamera.dart';
import 'package:flutter_application_1/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savedPlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return showAboutDialog(context: context);
    }

    ref.read(UserPlacesProvider.notifier).addPlace(enteredTitle, _selectedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Places"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(
              height: 12,
            ),
            //input camera
            InputCamera(onPickedImage: (image) {
              _selectedImage = image;
            },),
            SizedBox(
              height: 10,
            ),
            LocationInput(onSelectLocation: (location) {
              _selectedLocation = location;
            },),
             SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: _savedPlace,
              icon: Icon(Icons.add),
              label: Text('Save Place'),
            ),
          ],
        ),
      ),
    );
  }
}
