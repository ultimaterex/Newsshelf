abstract class Api {
  static const String base = "https://gnews.io/api/v4";

  static const String search = "/search";

  static const String topHeadlines = "/top-headlines";
}

class GNewsApi implements Api {
  static const String base = "https://gnews.io/api/v4";

  static const String search = "/search";

  static const String topHeadlines = "/top-headlines";
}

class NewsApi implements Api {
  static const String base = "";

  static const String search = "";

  static const String topHeadlines = "";
}