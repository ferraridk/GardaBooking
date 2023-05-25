import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../home/home_screen.dart'; // Add this import statement

class CitiesScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CitiesScreen(),
    );
  }

  final List<String> cities = [
    'Riva del garda',
    'Torbole',
    'Limone',
    'Malcesine',
    'Brenzone',
    'Gargnano',
    'Toscolano Maderno',
    'Gardone',
    'Salo',
    'Manerba',
    'Torri del benaco',
    'Garda',
    'Bardolino',
    'Moniga',
    'Padenghe',
    'Desenzano',
    'Sirmione',
    'Peschiera',
    'Lazise',
  ];

  @override
  Widget build(BuildContext context) {
    String? selectedCity; // Add this line to define the selectedCity variable

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/background_image.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Dropdown List
          Positioned(
            top: 100,
            left: 16,
            child: Container(
              color: Colors.white.withOpacity(0.8), // Set the background color and opacity
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value: selectedCity, // Add the selected city value here
                hint: Text('Vælg by', style: Theme.of(context).textTheme.displayMedium), // Add the default hint text
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(
                      city,
                      style: TextStyle(color: Colors.black), // Set the text color to black
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedCity = newValue; // Assign the selected city value
                  Navigator.pushReplacement(
                    context,
                    HomeScreen.route(selectedCity: selectedCity), // Pass selectedCity value to HomeScreen
                  );
                },
                icon: Icon(Icons.arrow_drop_down, color: Colors.black), // Set the dropdown icon color to black
                underline: Container(), // Remove the default underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}
