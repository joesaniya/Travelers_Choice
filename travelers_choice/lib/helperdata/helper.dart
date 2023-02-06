import 'package:hotel_travel/models/TopAttraction.dart';

class ActivityHelper {
  static List<TopAttraction> newlyTopAttraction = newlyTopAttractionRawData
      .map((data) => TopAttraction(
            image: data['image'],
            types: data['types'],
            rating: data['rating'],
            titlename: data['titlename'],
            location: data['location'],
            price: data['price'],
          ))
      .toList();
}

var newlyTopAttractionRawData = [
  {
    'image': 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'Ferrari World or Warner Bros',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/dubaiparks.jpg',
    'types': 'Attraction',
    'rating': '4.0',
    'titlename': 'Dubai Parks and Resorts',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/dubaiparks.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'Bollywood Theme Park with Meal + Motion Gate',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/img.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'IMG Worlds of Adventure Dubai',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/flyingcup.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'Flying Cup',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/ski_dubai.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'Ski Dubai',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  },
  {
    'image': 'assets/images/apps/shopping2/images/sky_view.jpg',
    'types': 'Theme Park',
    'rating': '4.0',
    'titlename': 'Sky View Observatory',
    'location': 'Abu Dhabi',
    'price': 'AED 205'
  }
];
