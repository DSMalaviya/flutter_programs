import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './drink_detail.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
  var res, drinks;

  fetchData() async {
    res = await http.get(url);
    drinks = jsonDecode(res.body)['drinks'];
    print(drinks.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.brown,
          Colors.orange,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("CocktailApp"),
        ),
        body: Center(
            child: res != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      var drink = drinks[index];
                      return ListTile(
                        leading: Hero(
                          tag: drink['idDrink'],
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(drink[
                                    "strDrinkThumb"] ??
                                "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg"),
                          ),
                        ),
                        title: Text(
                          "${drink['strDrink']}",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${drink["idDrink"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrinkDetail(drink),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: drinks.length,
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
      ),
    );
  }
}
