import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import '../helper/news.dart';
import '../views/article_view.dart';

class Category_news extends StatefulWidget {
  final String category;
  Category_news(this.category);
  @override
  _Category_newsState createState() => _Category_newsState();
}

class _Category_newsState extends State<Category_news> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _isloading = true;

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.category.toUpperCase()} ",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "NEWS",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          )
        ],
      ),
      actions: [
        Opacity(
          opacity: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.ac_unit_outlined),
          ),
        )
      ],
      elevation: 0.0,
    );
    return Scaffold(
      appBar: appbar,
      body: _isloading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 6, right: 6),
                    height: MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        24,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Blogtile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      },
                      itemCount: articles.length,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class Blogtile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  Blogtile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Article_view(url),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl)),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
