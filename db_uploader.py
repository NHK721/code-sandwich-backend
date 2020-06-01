import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import IngredientCategory, Ingredient, Product, SubCategory, Category, Nutrition, PlaceOfOrigin, Allergen, IngredientPlaceOfOrigin, IngredientAllergen

CSV_PATH_STORES = './allergens_ingredients.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            allergen_id = row[0]
            ingredient_id = row[1]
            ingredient = Ingredient.objects.get(id=ingredient_id)
            allergen = Allergen.objects.get(id=allergen_id)

            IngredientAllergen.objects.create(ingredient = ingredient, allergen = allergen)

insert_data()
