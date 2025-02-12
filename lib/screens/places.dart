import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/screens/add_place.dart';
import 'package:flutter_application_1/widgets/places_details_frontpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<Places> createState() {
    return _PlacesState();
  }
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(UserPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final newPlaces = ref.watch(UserPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favourite Spots'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddPlacesScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _futurePlaces,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesDetails(places: newPlaces),
        ),
      ),
    );
  }
}
