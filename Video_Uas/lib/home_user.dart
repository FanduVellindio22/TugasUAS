import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_uas/main.dart';
import 'dart:convert';
import 'login.dart'; // Pastikan ini sudah ada dan valid

// Model untuk menyimpan data film
class Film {
  final String id;
  final String nama;
  final String deskripsi;

  Film({required this.id, required this.nama, required this.deskripsi});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
    );
  }
}

class HomeUserScreen extends StatefulWidget {
  @override
  _HomeUserScreenState createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  List<Film> films = [];
  List<Film> horrorFilms = [];
  List<Film> comedyFilms = [];
  List<Film> romanceFilms = [];
  List<Film> thrillerFilms = [];
  List<Film> musicFilms = [];
  List<Film> favoriteFilms = [];

  @override
  void initState() {
    super.initState();
    _fetchFilms();
    _fetchHorrorFilms();
    _fetchComedyFilms();
    _fetchRomanceFilms();
    _fetchThrillerFilms();
    _fetchMusicFilms();
  }

  Future<void> _fetchFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_action.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> filmsData = responseJson['data'];

      setState(() {
        films = filmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load films');
    }
  }

  Future<void> _fetchHorrorFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_horror.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> horrorFilmsData = responseJson['data'];

      setState(() {
        horrorFilms = horrorFilmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load horror films');
    }
  }

  Future<void> _fetchComedyFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_comedy.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> comedyFilmsData = responseJson['data'];

      setState(() {
        comedyFilms = comedyFilmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load comedy films');
    }
  }

  Future<void> _fetchRomanceFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_romance.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> romanceFilmsData = responseJson['data'];

      setState(() {
        romanceFilms = romanceFilmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load romance films');
    }
  }

  Future<void> _fetchThrillerFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_thriller.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> thrillerFilmsData = responseJson['data'];

      setState(() {
        thrillerFilms = thrillerFilmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load thriller films');
    }
  }

  Future<void> _fetchMusicFilms() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_music.php?action=get'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> musicFilmsData = responseJson['data'];

      setState(() {
        musicFilms = musicFilmsData.map((filmJson) => Film.fromJson(filmJson)).toList();
      });
    } else {
      throw Exception('Failed to load music films');
    }
  }

  void _toggleFavorite(Film film) {
    setState(() {
      if (favoriteFilms.contains(film)) {
        favoriteFilms.remove(film);
      } else {
        favoriteFilms.add(film);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mencegah kembali ke halaman sebelumnya
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Home - Streaming Video', style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false, // Menghilangkan ikon back
          actions: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(favoriteFilms: favoriteFilms),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                      (route) => false, // Menghapus semua rute sebelumnya
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildCategorySection('Film Action', films),
              _buildCategorySection('Film Horror', horrorFilms),
              _buildCategorySection('Film Comedy', comedyFilms),
              _buildCategorySection('Film Romance', romanceFilms),
              _buildCategorySection('Film Thriller', thrillerFilms),
              _buildCategorySection('Film Music', musicFilms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<Film> films) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 250,
            child: PageView.builder(
              itemCount: films.length,
              controller: PageController(viewportFraction: 0.8),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            films[index].nama,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            films[index].deskripsi,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            favoriteFilms.contains(films[index])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteFilms.contains(films[index])
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(films[index]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Film> favoriteFilms;

  FavoriteScreen({required this.favoriteFilms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // AppBar dengan warna biru muda
        title: Text('Favorite Films', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: favoriteFilms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteFilms[index].nama),
            subtitle: Text(favoriteFilms[index].deskripsi),
          );
        },
      ),
    );
  }
}
