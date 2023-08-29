

class Recipe {
  String label;
  String imageUrl;
  int servings;
  List<Ingredient> ingredient;

  Recipe(this.label, this.imageUrl, this.servings, this.ingredient);
  
  static List<Recipe> samples = [
    Recipe('Spaghetti and Meatballs', 'assets/1.jpg', 4,
        [
          Ingredient(1, 'box', 'Spaghetti'),
          Ingredient(4, '', 'Frozen Meatballs'),
          Ingredient(0.5, 'jar', 'sauce'),
        ]),

    Recipe('Tomato Soup', 'assets/2.jpg', 2,
      [
        Ingredient(1, 'can', 'Tomato Soup'),
      ]),

    Recipe('Chocolate Chip Cookies', 'assets/3.jpg',  1,
      [
        Ingredient(2, 'slices', 'Cheese'),
        Ingredient(2, 'slices', 'Bread'),
      ]),

    Recipe('Hawaiian Pizza', 'assets/4.jpg', 24,
        [
          Ingredient(4, 'cups', 'flour'),
          Ingredient(2, 'cups', 'sugar'),
          Ingredient(0.5, 'cups', 'chocolate chips'),
        ])
  ];
}


class Ingredient {
  double quantity;
  String measure;
  String name;
  Ingredient(this.quantity, this.measure, this.name);
}