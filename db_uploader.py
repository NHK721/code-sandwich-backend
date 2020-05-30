import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from product.models   import Category

CSV_PATH_STORES = './categories.csv'

def insert_stores():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            name = row[0]

            Category.objects.create(name = name)

insert_stores()
