import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import './map_screen.dart';
class PlaceDetailScreen extends StatelessWidget {
  static const routeName = 'place-detail';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace = Provider.of<Places>(context,listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image,fit: BoxFit.cover,width: double.infinity,),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(selectedPlace.location!.address!,textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          ),
          const SizedBox(height: 10,),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MapScreen(
                initialLocation: selectedPlace.location!,
                isSelecting: false,
              ),
              fullscreenDialog: true,
              ));
            },
            child: const Text('View On Map'),
          )
        ],
      ),
    );
  }
}
