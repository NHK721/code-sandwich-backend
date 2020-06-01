import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import IngredientCategory, Ingredient, Product, SubCategory, Category, Nutrition, PlaceOfOrigin, Allergen, IngredientPlaceOfOrigin, IngredientAllergen

CSV_PATH_STORES = './ingredients.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            ingredient_category_id = row[0]
            name = row[1]
            price = row[2]
            image_url= row[3]

            ingredient_category = IngredientCategory.objects.get(id = ingredient_category_id)
            Nutrition.objects.create(ingredient_category = ingredient_category, name = name, price = price, image_url = image_url)

insert_data()