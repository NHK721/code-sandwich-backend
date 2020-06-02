import json
import ast
import simplejson

from json                       import JSONEncoder
from django.views               import View
from django.http                import JsonResponse
from django.db.models           import Q
from django.forms.models        import model_to_dict
from django.core                import serializers

from .models import (
    Product, 
    Category, 
    SubCategory, 
    Nutrition, 
    Ingredient, 
    ProductIngredient
)

class MyEncoder(JSONEncoder):
    def default(self, o):
        return o.__dict__

class ProductView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        product_info = Product.objects.filter(id=product_id).values()[0]
        product = Product.objects.get(id=product_id)
        nutrition = product.nutrition
        nutrition = model_to_dict(nutrition)
        product_group = product.subcategory
        group_products = list(Product.objects.filter(subcategory = product_group, category = 1).values())
        show_products = []

        for i in group_products:
            try:
                if i == product_info:
                    show_products.append(group_products[group_products.index(i) + 1])
                    show_products.append(group_products[group_products.index(i) - 1])
                    show_products.reverse()
            except IndexError:
                show_products.append(group_products[group_products.index(i) - 1])
                show_products.append(group_products[0])
        show_products = list(show_products)

        return JsonResponse({
            "product"                   : product_info,
            "nutrition"                 : nutrition,
            "all_subcategory_products"  : show_products,
        }, status=200)

class SandwichView(View):
    def get(self, request):
        sandwiches = Product.objects.filter(category_id=1).values()
        return JsonResponse({'sandwiches':list(sandwiches)}, status=200)

class CustomizationView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        product_name = Product.objects.filter(id=product_id).values()[0]['name']
        if Product.objects.filter(id=product_id).values()[0]['customization_true'] == True:
            default_ingredients = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
            lst = []
            lst2 = []
            for ingredient in default_ingredients.values():
                lst.append(ingredient['ingredient_id'])
            for ingredient_id in lst:
                lst2.append(Ingredient.objects.filter(id=ingredient_id).values()[0])
            for bread in lst2:
                if "bottom" in bread['name']:
                    lst2.append(lst2.pop(lst2.index(bread)))
                    break
            return JsonResponse({'default_ingredients':lst2, 'product_name':product_name})
        return JsonResponse({'message':"You can't customize this item"})

class ToppingView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        default_ingredients = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
        bar = [2,3,4]
        all_toppings = []
        ingr2 = Ingredient.objects.filter(ingredient_category_id = 2).values()
        ingr2 = list(ingr2)
        ingr3 = Ingredient.objects.filter(ingredient_category_id = 3).values()
        ingr3 = list(ingr3)
        ingr4 = Ingredient.objects.filter(ingredient_category_id = 4).values()
        ingr4 = list(ingr4)
        ingr5 = Ingredient.objects.filter(ingredient_category_id = 5).values()
        ingr5 = list(ingr5)
        all_toppings = ingr2 + ingr3 + ingr4 + ingr5
        lst = []
        lst2 = []
        topping_lst = []
        chosen_topping = []
        for ingredient in default_ingredients.values():
            lst.append(ingredient['ingredient_id'])
        for ingredient_id in lst:
            lst2.append(Ingredient.objects.filter(id=ingredient_id).values()[0])
        for i in lst2:
            if i["ingredient_category_id"] != 1:
                topping_lst.append(i)
        chosen_topping += topping_lst
        return JsonResponse({'default_toppings': topping_lst, 'all_toppings': all_toppings})

class BreadView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        default_ingredients = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
        lst = []
        lst2 = []
        bread_lst = []
        for ingredient in default_ingredients.values():
            lst.append(ingredient['ingredient_id'])
        for ingredient_id in lst:
            lst2.append(Ingredient.objects.filter(id=ingredient_id).values()[0])
        for i in lst2:
            if i["ingredient_category_id"] == 1:
                bread_lst.append(i)
        return JsonResponse({'default_bread': bread_lst})

    def post(self, request, *args, **kwargs):
        body_unicode = request.body.decode('utf-8')
        body = ast.literal_eval(body_unicode)
        bread_id = body['bread']
        bread_lst = []
        bread_id_lst = bread_id.split(',')
        for i in bread_id_lst:
            bread_lst.append(Ingredient.objects.filter(id=i).values()[0])

        return JsonResponse({'changed_bread': bread_lst})