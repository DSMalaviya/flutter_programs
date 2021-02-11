import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/article_model.dart';
import '../helper/data.dart';
import '../helper/news.dart';
import '../views/article_view.dart';
import '../views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _isloading = true;
  var appbar = AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Flutter"),
        Text(
          "News",
          style: TextStyle(color: Colors.blue),
        )
      ],
    ),
    elevation: 0.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: _isloading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  ///categories
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    height: 70,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Categorytile(
                          imageurl: categories[index].imageUrl,
                          categoryname: categories[index].categoryName,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                    ),
                  ),

                  //blogs
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 5, left: 6, right: 6),
                      height: MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          70 -
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
            ),
    );
  }
}

class Categorytile extends StatelessWidget {
  final String imageurl, categoryname;
  Categorytile({this.imageurl, this.categoryname});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Category_news(categoryname.toLowerCase());
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageurl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black26),
              child: Text(
                categoryname,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            )
          ],
        ),
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
