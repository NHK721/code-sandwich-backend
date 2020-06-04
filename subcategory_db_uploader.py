import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import IngredientCategory, Ingredient, Product, SubCategory, Category, Nutrition, PlaceOfOrigin, Allergen, IngredientPlaceOfOrigin, IngredientAllergen

CSV_PATH_STORES = './subcategories.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            name = row[0]
            category_id = row[2]

            category = Category.objects.get(id = category_id)
            SubCategory.objects.create(name = name, category = category)

insert_data()