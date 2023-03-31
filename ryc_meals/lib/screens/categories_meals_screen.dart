import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ryc_meals/components/meal_item.dart';
import 'package:ryc_meals/models/category.dart';
import 'package:ryc_meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen(this.meals, {super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = meals.where((element) {
      return element.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(categoryMeals[index]);
        },
      ),
    );
  }
}
