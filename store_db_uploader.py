import os
import django
import csv
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "codesandwich.settings")
django.setup()

from store.models   import Store

CSV_PATH_STORES = './stores.csv'

def insert_data():
    with open(CSV_PATH_STORES) as in_file:
        data_reader = csv.reader(in_file)
        next(data_reader, None)
        for row in data_reader:
            address = row[0]
            name = row[1]
            phone = row[2]

            Store.objects.create(address = address, name = name, phone = phone)

insert_data()