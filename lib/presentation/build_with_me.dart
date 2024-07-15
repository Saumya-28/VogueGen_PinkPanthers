import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../Service/api_client.dart';

class BuildWithMe extends StatefulWidget {
  const BuildWithMe({super.key});

  @override
  State<BuildWithMe> createState() => _BuildWithMeState();
}

class _BuildWithMeState extends State<BuildWithMe> {
  late Future<RecommendationResponse> futureRecommendations;

  @override
  void initState() {
    super.initState();
    futureRecommendations = fetchRecommendations();
  }

  Future<RecommendationResponse> fetchRecommendations() {
    return apiClient.getRecommendations(
      "Kids",
      "Dresses and Rompers",
      "Dresses",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: _showModel(),
        ),
      ),
    );
  }

  Widget _showModel() {
    double height = MediaQuery.of(context).size.height;
    double bottomNavHeight = height * 0.1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/model_.png'),
        const Text(
          "Pickup your genz way",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(Icons.checkroom, "Select Outfit"),
                _buildMenuItem(Icons.image, "Pose & Background"),
                _buildMenuItem(Icons.camera_alt, "Change Selfie"),
                _buildMenuItem(Icons.edit, "Edit Avatar"),
              ],
            ),
          ),
        ),
        SizedBox(height: bottomNavHeight),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Iconsax.arrow_right),
      onTap: () {
        if (title == "Select Outfit") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectOutfitScreen()),
          );
        }
        // Handle other menu item taps here
      },
    );
  }

  Widget recommendProduct() {
    return FutureBuilder<RecommendationResponse>(
      future: futureRecommendations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.recommendations.isEmpty) {
          return Text("No recommendations found");
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.recommendations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.recommendations[index]),
              );
            },
          );
        }
      },
    );
  }
}




class SelectOutfitScreen extends StatelessWidget {
  SelectOutfitScreen({super.key});

  List<String> shirtImages = [
    'assets/shirts/img.png',
    'assets/shirts/img_1.png',
    'assets/shirts/img_2.png',
    // Add more shirt images here if needed
  ];

  List<String> pantImages = [
    'assets/pants/img.png',
    'assets/pants/img_1.png',
    'assets/pants/img_2.png',
    // Add more pant images here if needed
  ];

  List<String> accessoryImages = [
    'assets/watch/img.png',
    'assets/watch/img_1.png',
    'assets/watch/img_2.png',
    // Add more accessory images here if needed
  ];

  List<String> footwearImages = [
    'assets/footwear/img.png',
    'assets/footwear/img_1.png',
    'assets/footwear/img_2.png',
    // Add more footwear images here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Outfit"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Select your shirt style", shirtImages),
            SizedBox(height: 16),
            _buildSection("Select your pant style", pantImages),
            SizedBox(height: 16),
            _buildSection("Select your accessory", accessoryImages),
            SizedBox(height: 16),
            _buildSection("Select your footwear", footwearImages),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String sectionTitle, List<String> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            sectionTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return _buildItem(images[index], "${sectionTitle.split(' ')[2]} ${index + 1}");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String imagePath, String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Container(
              width: 150,
              height: 150,
              color: Colors.transparent,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


