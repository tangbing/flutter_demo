
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe/recipe.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

 final Recipe recipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _slideerVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.label)),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(image: AssetImage(widget.recipe.imageUrl)),
            ),
            SizedBox(height: 4),

            Text(widget.recipe.label, style: TextStyle(fontSize: 18)),

            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: widget.recipe.ingredient.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ingredient = widget.recipe.ingredient[index];
                      print(ingredient);
                      return Text('${ingredient.quantity * _slideerVal} ${ingredient.measure} ${ingredient.name}');
                    }
                )
            ),
            Slider(
                min: 1,
                max: 10,
                divisions: 10,
                label: '${_slideerVal * widget.recipe.servings} servings',
                value: _slideerVal.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    _slideerVal = newValue.round();
                  });
                },
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

