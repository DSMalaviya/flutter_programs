import 'package:flutter/material.dart';

class DrinkDetail extends StatelessWidget {
  final drink;
  DrinkDetail(@required this.drink);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.brown, Colors.orange]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(drink["strDrink"]),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: drink['idDrink'],
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(drink['strDrinkThumb']),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Id:${drink['idDrink']}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "${drink["strDrink"]}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
