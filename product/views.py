import json
import ast

from django.views               import View
from django.http                import JsonResponse

from .models import (
    Product, 
    Category, 
    SubCategory, 
    Nutrition, 
    Ingredient, 
    ProductIngredient
)

class ProductView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        product_data = Product.objects.filter(id=product_id).values()[0]
        nutrition_data = Nutrition.objects.filter(id = product_id).values()[0]
        return JsonResponse({
            "product":product_data,
            "nutrition":nutrition_data,
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
            default_ingredients = ProductIngredient.objects.filter(is_default=True).filter(product_id = product_id)
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
        default_ingredients = ProductIngredient.objects.filter(is_default=True).filter(product_id = product_id)
        lst = []
        lst2 = []
        topping_lst = []
        for ingredient in default_ingredients.values():
            lst.append(ingredient['ingredient_id'])
        for ingredient_id in lst:
            lst2.append(Ingredient.objects.filter(id=ingredient_id).values()[0])
        for i in lst2:
            if i["ingredient_category_id"] != 1:
                topping_lst.append(i)
        return JsonResponse({'default_toppings': topping_lst})

class BreadView(View):
    def get(self, request):
        product_id = request.GET.get('product_id', None)
        default_ingredients = ProductIngredient.objects.filter(is_default=True).filter(product_id = product_id)
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