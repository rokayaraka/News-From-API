import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news_from_api/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('widget 1');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<News>? futureNews;
  Future<News> fetchNews() async {
    try {
      var url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=9b278581136748d8a8092157727ff7a5";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);
        final jsonBody = jsonDecode(response.body);
        return News.fromJson(jsonBody);
      }
      else{
        return News(status: "Not OK", totalResults: 0, listOfArticles: []);
      }
    } catch (e) {
      return News(status: "Not OK", totalResults: 0, listOfArticles: []);
    }
  }

  @override
  void initState() {
    print('fetch news 1');
    // TODO: implement initState
    futureNews = fetchNews();
    print('fetch news 2');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('widget');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "News Today",
            style: GoogleFonts.merriweather(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: FutureBuilder<News>(
              future: futureNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                final news = snapshot.data;
                if (news == null) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return ListView.builder(
                  itemCount: news.listOfArticles.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: ListTile(
                        title: Text(
                      news.listOfArticles[index].title,
                    ),
                    leading: Image.network(news.listOfArticles[index].urlToImage),
                    ),
                  ),
                );
              })),
    );
  }
}
