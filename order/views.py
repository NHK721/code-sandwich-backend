import json
import ast
import jwt, bcrypt

from django.views               import View
from django.http                import JsonResponse

from .models        import (
    Order, 
    Cart, 
    CartIngredient, 
    DestinationLocation, 
    OrderStatus
) 
from product.models import (
    Product, 
    Category, 
    SubCategory, 
    Nutrition, 
    Ingredient, 
    ProductIngredient
)
from store.models   import Store
from account.models import Customer

class CartView(View):
    def post(self, request, *args, **kwargs):
        body_unicode = request.body.decode('utf-8')
        body = ast.literal_eval(body_unicode)
        ## must receive user info
        ## decoded_token -> email -> filter(email=email) -> retrieve id
        header_token    = request.META.get('HTTP_AUTHORIZATION', '')
        decoded_token   = jwt.decode(header_token,SECRET_KEY, algorithm='HS256')['email']
        customer_id = Customer.objects.filter(email=decoded_token).values()[0]['id']
        customer = Customer.objects.get(id=customer_id)

        ## make sure you do not make another order for the same customer when the last order is still not submitted
        if Order.objects.filter(customer = customer).all().last().order_status != 'not_submitted':
            ## create new order if the customer's one is non-active or non-existent
            Order.objects.create(order_status_id=2, total_price = price, customer=customer)
            order_id = Order.objects.filter(customer = customer).all().last().id
            order = Order.objects.filter(id = order_id)
            if body['product']:
                product_name = body['product']['name']
                product = Product.objects.get(name = product_name)
                price = body['product']['price']
                ## make a new cart for default_item
                Cart.objects.create(order = order, price = price, amount = 1, product = product)
                ## send the cart item(first one) info to frontend
                return JsonResponse({'cart_items': Cart.objects.filter(order = order).values()[0]})
            elif body['default_ingredients']:
                product_name = body['product_name']
                ingredients = body['default_ingredients']
                ## create a new cart for cusomized item
                Cart.objects.create(order = order)
                ## send the cart item info(first one) to frontend
                return JsonResponse({'cart_items': Cart.objects.filter(order = order).values()[0]})
            order = Order.objects.get(customer_id = customer_id).last()
        ## below is when the customer's order is still active 
        elif Order.objects.filter(customer_id = customer_id).all().last().order_status == 'not_submitted':
            ## update the order by just adding carts
            order_id = Order.objects.filter(customer_id = customer_id).all().last().id
            order = Order.objects.filter(id = order_id)
            if body['product']:
                product_name = body['product']['name']
                product = Product.objects.get(name = product_name)
                price = body['product']['price']
                ## make a new cart for default_item
                Cart.objects.create(order = order, price = price, amount = 1, product = product)
                ## send the cart items(all of them) info to frontend
                return JsonResponse({'cart_items': Cart.objects.filter(order = order).values()})
            elif body['default_ingredients']:
                product_name = body['product_name']
                ingredients = body['default_ingredients']
                ## create a new cart for cusomized item
                Cart.objects.create(order = order)
                ## send the cart items(all of them) info to frontend
                return JsonResponse({'cart_items': Cart.objects.filter(order = order).values()})
        
        
        customized_ingredients = body['customized_ingredients']
        ## create cart with sandwich info plus total price below
        ## each 'add to bag' POST request makes the cart and the order
        ## this requires login and store info

        bread_id_lst = bread_id.split(',')
        for i in bread_id_lst:
            bread_lst.append(Ingredient.objects.filter(id=i).values()[0])

        return JsonResponse({'changed_bread': bread_lst})

class OrderView(View):
    def post(self, request, *args, **kwargs):
        body_unicode = request.body.decode('utf-8')
        body = ast.literal_eval(body_unicode)
        ## changes the order status into 'submitted'