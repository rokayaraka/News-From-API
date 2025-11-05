class News {
  final String status;
  final int totalResults;
  final List<Articles> listOfArticles;
  News({
    required this.status,
    required this.totalResults,
    required this.listOfArticles,
  });

  static News fromJson(Map<String, dynamic> json) {

    List<Articles>jsonArticles=[];
    for(var i in (json['articles'] as List))
    {
      if(i is Map<String,dynamic>){
        jsonArticles.add(Articles.fromJson(i));
      }
    }
    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      listOfArticles: jsonArticles,
    );
  }
}

class Articles {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Articles({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  static Articles fromJson(Map<String, dynamic> json) {
    return Articles(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class Source {
  final String id;
  final String name;
  Source({required this.id, required this.name});

  static Source fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
