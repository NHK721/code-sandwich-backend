import json
import ast
import simplejson

from json                       import JSONEncoder
from django.views               import View
from django.http                import JsonResponse
from django.db.models           import Q
from django.forms.models        import model_to_dict
from django.core                import serializers
from django.shortcuts           import redirect, render

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
        product_id      = request.GET.get('product_id', None)
        product_info    = Product.objects.filter(id=product_id).values()[0]
        product         = Product.objects.get(id=product_id)
        nutrition       = product.nutrition
        nutrition       = model_to_dict(nutrition)
        product_group   = product.subcategory
        group_products  = list(Product.objects.filter(subcategory = product_group, category = 1).values())
        show_products   = []

        for sandwich in group_products:
            try:
                if sandwich == product_info:
                    show_products.append(group_products[group_products.index(sandwich) + 1])
                    show_products.append(group_products[group_products.index(sandwich) - 1])
                    show_products.reverse()
            except IndexError:
                show_products.append(group_products[group_products.index(sandwich) - 1])
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
        product_id      = request.GET.get('product_id', None)
        product_name    = Product.objects.filter(id=product_id).values()[0]['name']
        
        if Product.objects.filter(id=product_id).values()[0]['customization_true'] == True:
            default_ingredients         = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
            another_ingredients_list    = []
            all_bread                   = [bread for bread in Ingredient.objects.filter(ingredient_category_id=1).values()]
            ingredients                 = [ingredient['ingredient_id'] for ingredient in default_ingredients.values()]
            another_ingredients_list    = [Ingredient.objects.filter(id=ingredient_id).values()[0] for ingredient_id in ingredients]
            for bread in another_ingredients_list:
                if "bottom" in bread['name']:
                    another_ingredients_list.append(another_ingredients_list.pop(another_ingredients_list.index(bread)))
                    break
            return JsonResponse({'default_ingredients':another_ingredients_list, 'product_name':product_name, 'all_bread': all_bread})
        return JsonResponse({'message':"You can't customize this item"})

class ToppingView(View):
    def get(self, request):
        product_id          = request.GET.get('product_id', None)
        default_ingredients = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
        bar                 = [2,3,4]
        all_toppings        = []
        ingr2               = Ingredient.objects.filter(ingredient_category_id = 2).values()
        ingr2               = list(ingr2)
        ingr3               = Ingredient.objects.filter(ingredient_category_id = 3).values()
        ingr3               = list(ingr3)
        ingr4               = Ingredient.objects.filter(ingredient_category_id = 4).values()
        ingr4               = list(ingr4)
        ingr5               = Ingredient.objects.filter(ingredient_category_id = 5).values()
        ingr5               = list(ingr5)
        all_toppings        = ingr2 + ingr3 + ingr4 + ingr5
        chosen_topping      = []
        ingredient_ids      = [ingredient['ingredient_id'] for ingredient in default_ingredients.values()]
        ingredients         = [Ingredient.objects.filter(id=ingredient_id).values()[0] for ingredient_id in ingredient_ids]
        topping_lst         = [ingredient for ingredient in ingredients if ingredient["ingredient_category_id"] != 1]
        chosen_topping      += topping_lst
        return JsonResponse({'default_toppings': topping_lst, 'all_toppings': all_toppings})

class BreadView(View):
    def get(self, request):
        product_id          = request.GET.get('product_id', None)
        default_ingredients = ProductIngredient.objects.filter(is_default=True, product_id = product_id)
        all_bread           = list(Ingredient.objects.filter(ingredient_category_id = 1).values())
        ingredient_ids      = [ingredient['ingredient_id'] for ingredient in default_ingredients.values()]
        breads              = [Ingredient.objects.filter(id=ingredient_id).values()[0] for ingredient_id in ingredient_ids]
        bread_lst           = [bread for bread in breads if bread["ingredient_category_id"] == 1]
            
        return JsonResponse({'default_bread': bread_lst, 'all_bread': all_bread})
    
    def post(self, request):
        product_id  = request.GET.get('product_id', None)
        body        = ast.literal_eval(request.body.decode('utf-8'))
        breads      = [item['id'] for item in body]
        bread1      = breads[0]
        bread2      = breads[1]
        response    = redirect('/product/sandwich/customization/?product_id=' + product_id)
        response.set_cookie('chosen_bread1', bread1)
        response.set_cookie('chosen_bread2', bread2)
        return response

class WrapView(View):
    def get(self, request):
        wraps = Product.objects.filter(category_id=2).values()
        return JsonResponse({'wraps':list(wraps)}, status=200)

class WrapDetailView(View):
    def get(self, request):
        product_id      = request.GET.get('product_id', None)
        product_info    = Product.objects.filter(id=product_id).values()[0]
        product         = Product.objects.get(id=product_id)
        nutrition       = product.nutrition
        nutrition       = model_to_dict(nutrition)
        product_group   = product.subcategory
        group_products  = list(Product.objects.filter(subcategory = product_group, category = 2).values())
        show_products   = []

        for i in group_products:
            try:
                if i == product_info:
                    show_products.append(group_products[group_products.index(i) + 1])
            except IndexError:
                show_products.append(group_products[0])

        return JsonResponse({
            "product"                   : product_info,
            "nutrition"                 : nutrition,
            "all_subcategory_products"  : show_products,
        }, status=200)