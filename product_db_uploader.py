import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import IngredientCategory, Ingredient, Product, SubCategory, Category, Nutrition, PlaceOfOrigin, Allergen, IngredientPlaceOfOrigin, IngredientAllergen

CSV_PATH_STORES = './products.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            category_id = row[0]
            subcategory_id = row[1]
            name = row[2]
            name_en = row[3]
            description = row[4]
            image_url = row[5]
            default_price = row[6]

            category = Category.objects.get(id = category_id)
            subcategory = SubCategory.objects.get(id = subcategory_id)

            Product.objects.create(category = category, subcategory = subcategory, name = name, name_en = name_en, description = description, image_url = image_url, default_price = default_price)

insert_data()
