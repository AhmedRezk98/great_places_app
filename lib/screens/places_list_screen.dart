import 'package:flutter/material.dart';
import './add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import './place_detail_screen.dart';
class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context,listen: false).fetchAndSetPlaces(),
        builder: (ctx,snapShot)=>snapShot.connectionState == ConnectionState.waiting?
            const Center(
              child: CircularProgressIndicator(),
            ):Consumer<Places>(
            child: const Text('No Places Added Yet start adding some'),
            builder: (ctx,placesData,ch)=> placesData.items.isEmpty ? ch!
                : ListView.builder(
              itemCount: placesData.items.length,
              itemBuilder: (ctx,i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(placesData.items[i].image),
                ),
                title: Text(placesData.items[i].title),
                subtitle: Text(placesData.items[i].location!.address!),
                onTap: (){
                  Navigator.of(context).pushNamed(PlaceDetailScreen.routeName,arguments: placesData.items[i].id);
                },
              ),
            )
        ),
      )
    );
  }
}
