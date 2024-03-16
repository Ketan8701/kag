import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  void _fetchProfileData() async {
    try {
      var response = await http.get(Uri.parse('https://your-api-url/profile'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _profileImageUrl = data['profile_image_url'];
        });
      } else {
        print('Failed to fetch profile data');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Gallery Home'),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: CircleAvatar(
            backgroundImage: _profileImageUrl.isNotEmpty
                ? NetworkImage(_profileImageUrl)
                : null,
            child: _profileImageUrl.isEmpty
                ? Icon(Icons.account_circle, size: 40) // Use a circle person icon
                : null,
            radius: 40,
            backgroundColor: Colors.transparent, // Set a background color for the circle
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
              // Add more menu items here if needed
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: CarouselSlider(
                items: [
                  Image.network('https://source.unsplash.com/1520x550/?art,gallery', fit: BoxFit.cover),
                  Image.network('https://source.unsplash.com/1520x550/?paintings,gallery', fit: BoxFit.cover),
                  Image.network('https://source.unsplash.com/1520x550/?gallery,art', fit: BoxFit.cover),
                ],
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            SectionWidget(
              title: 'RECENT EXHIBITIONS',
              content: '',
              items: [
                ExhibitionCard(
                  image: 'asset/images/sixthdairy.jpg',
                  artist: 'Jasmine Nilani Joseph',
                  location: 'D-53 DEFENCE COLONY, NEW DELHI',
                  date: '20 APRIL - 18 MAY 2023',
                ),
                // Add more ExhibitionCard widgets as needed
              ],
            ),
            SectionWidget(
              title: 'IN THE NEWS',
              content: '',
              items: [
                NewsCard(
                  image: 'asset/images/group.jpg',
                  title: 'SHRIMANTI SAHA',
                  author: 'BY NIDHI VERMA | PLATFORM MAGAZINE',
                  date: '27 MARCH 2023',
                ),
                // Add more NewsCard widgets as needed
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF667eea),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

void _logout(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> items;

  SectionWidget({required this.title, required this.content, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(content),
          SizedBox(height: 20.0),
          Column(
            children: items,
          ),
        ],
      ),
    );
  }
}

class ExhibitionCard extends StatelessWidget {
  final String image;
  final String artist;
  final String location;
  final String date;

  ExhibitionCard({required this.image, required this.artist, required this.location, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(image, fit: BoxFit.contain),  // Use BoxFit.contain here
          ListTile(
            title: Text(artist),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location),
                Text(date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String date;

  NewsCard({required this.image, required this.title, required this.author, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(image, fit: BoxFit.contain),  // Use BoxFit.contain here
          ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author),
                Text(date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
