import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import IngredientCategory, Ingredient, Product, SubCategory, Category, Nutrition, PlaceOfOrigin, Allergen, IngredientPlaceOfOrigin, IngredientAllergen

CSV_PATH_STORES = './nutritions.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            product_id = row[0]
            size_g = row[1]
            calories_kcal = row[2]
            sugar_g = row[3]
            protein_g = row[4]
            saturated_fat_g = row[5]
            sodium_g = row[6]

            product = Product.objects.get(id = product_id)
            Nutrition.objects.create(product = product, calories_kcal = calories_kcal, sugar_g = sugar_g, protein_g = protein_g, saturated_fat_g = saturated_fat_g, sodium_g = sodium_g)

insert_data()