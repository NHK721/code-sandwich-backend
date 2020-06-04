import json
import ast
import jwt
import bcrypt

from django.views               import View
from django.http                import JsonResponse
from django.forms.models        import model_to_dict
from django.core.exceptions     import ObjectDoesNotExist

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
from store.models           import Store
from account.models         import Customer
from codesandwich.settings  import SECRET_KEY

global order

def login_required(func):
        def wrapper(self, request, *args, **kwargs):
            
            header_token            = request.META.get('HTTP_AUTHORIZATION')
            decoded_token           = jwt.decode(header_token, SECRET_KEY, algorithm='HS256')['email']
            user                    = Customer.objects.get(email=decoded_token)
            customer_id             = user.id
            kwargs['user']          = user
            kwargs['customer_id']   = customer_id
            
            try:
                if Customer.objects.filter(email=decoded_token).exists():
                    return func(self, request, *args, **kwargs)
                else:
                    return JsonResponse({"message": "THE CUSTOMER DOES NOT EXIST"})
            except jwt.DecodeError:
                return JsonResponse({"message": "WRONG_TOKEN!"}, status=403)
            except KeyError:
                return JsonResponse({"message": "KEY ERROR"}, status=405)
            except Customer.objects.filter(email=decoded_token).DoesNotExist:
                return JsonResponse({"message": "USER NOT FOUND"}, status=406)
        return wrapper

class CartView(View):

    @login_required
    def post(self, request, **kwargs):
        user        = kwargs['user']
        customer_id = kwargs['customer_id']
        
        try:
            body = json.loads(request.body)
            if Order.objects.get(customer = user, order_status_id = 2):
                # below is when the customer's order is still active 
                order       = Order.objects.get(customer = user, order_status_id = 2)
                # update the order by just adding carts
                product_id  = body['product']['id']
                product     = Product.objects.get(id = product_id)
                # this extracts the price
                price       = body['product']['default_price']
                price       = float(price)
                # this decides whether the same cart exists or not
                for cart in order.cart_set.values():
                    if cart['product_id'] == body['product']['id']:
                        a = Cart.objects.get(order = order, product_id = cart['product_id'])
                        a.amount += 1
                        a.save()
                        return JsonResponse({'message': 'ITEM AMOUNT INCREASED'})
                        break
                    else:
                        continue
                ## make a new cart for default_item
                Cart.objects.create(order = order, price = price, amount = 1, product = product)
                order.total_price   += price
                order.save()
                total_price         = order.total_price
                return JsonResponse({"message": "ORIGINAL SANDWICH CART ADD SUCCESSFUL", "total_price": total_price, "cart": list(Cart.objects.filter(order = order).values())})
            
            # this is when there is no active order
            elif not Order.objects.get(customer = user, order_status_id = 2).exists():
            #except Order.DoesNotExist:        
                # this creates a new order if the customer's one is non-active or non-existent
                order = Order.objects.create(order_status_id=2, total_price = 0, customer=user)
                # update the order by just adding carts
                product_id  = body['product']['id']
                product     = Product.objects.get(id = product_id)
                #this extracts the price
                price       = body['product']['default_price']
                price       = float(price)
                ## make a new cart for default_item
                Cart.objects.create(order = order, price = price, amount = 1, product = product)
                order.total_price += price
                order.save()
                total_price = order.total_price
                return JsonResponse({"message": "MADE A NEW ORDER AND ORIGINAL SANDWICH CART ADD SUCCESSFUL", "total_price": total_price, "cart": list(Cart.objects.filter(order = order).values())})

        except ValueError:
            body = ast.literal_eval(request.body.decode('utf-8'))
            if Order.objects.get(customer = user, order_status_id = 2):
                # this is when there is an active order
                order               = Order.objects.get(customer = user, order_status_id = 2)
                # this extracts the original product name
                product_name        = body['product_name']
                # this extracts the price of the default product and the product itself
                product             = Product.objects.get(name = product_name)
                price               = product.default_price
                price               = float(price)
                # this extracts the default and the added ingredients
                default_ingredients = body['default_ingredients']
                added_ingredients   = body['added_ingredients']
                # this combines all the ingredients and saves in a variable
                all_ingredients     = default_ingredients + added_ingredients
                # this creates a new cart for the cusomized cart
                cart = Cart.objects.create(order = order, price = price, amount = 1, product = product)
                # this creates CartIngredient relationships
                for ingredient in all_ingredients:
                    CartIngredient.objects.create(cart = cart, ingredient_id = ingredient['id'])
                for ingredient in added_ingredients:
                    if float(ingredient['price']) != 0:
                        price += float(ingredient['price'])
                #this adds the price onto the order
                cart.price          += price
                order.total_price   += price
                order.save()
                total_price         = order.total_price
                return JsonResponse({"message": "CUSTOMIZED SANDWICH CART ADD SUCCESSFUL", "total_price": total_price, "cart": list(Cart.objects.filter(order = order).values())})

            # this is when there is no active order
            elif not Order.objects.get(customer = user, order_status_id = 2).exists():
                # this creates a new order if the customer's one is non-active or non-existent
                order           = Order.objects.create(order_status_id=2, total_price = 0, customer=user)
                # this extracts the original product name
                product_name    = body['product_name']
                # this extracts the price of the default product and the product itself
                product         = Product.objects.get(name = product_name)
                price           = product.default_price
                price           = float(price)
                # this extracts the default and the added ingredients
                default_ingredients = body['default_ingredients']
                added_ingredients   = body['added_ingredients']
                # this combines all the ingredients and saves in a variable
                all_ingredients     = default_ingredients + added_ingredients
                # this creates a new cart for the cusomized cart
                Cart.objects.create(order = order, price = price, amount = 1, product = product)
                # this extracts the cart that was just created
                cart = Cart.objects.filter(order = order).all().last()
                # this creates CartIngredient relationships
                for ingredient in all_ingredients:
                    CartIngredient.objects.create(cart = cart, ingredient_id = ingredient['id'])
                for ingredient in added_ingredients:
                    if float(ingredient['price']) != 0:
                        price += float(ingredient['price'])
                #this adds the price onto the order
                cart.price += price
                order.total_price += price
                order.save()
                total_price = order.total_price
                return JsonResponse({"message": "MADE A NEW ORDER AND CUSTOMIZED SANDWICH CART ADD SUCCESSFUL", "total_price": total_price, "cart": list(Cart.objects.filter(order = order).values())})
    
    @login_required
    def get(self, request, *args, **kwargs):
        user = kwargs['user']
        customer_id = kwargs['customer_id']
        try:
            # this calls the last order of the user
            order       = Order.objects.get(customer = user, order_status_id = 2)
            order_dict  = model_to_dict(order)
            carts       = order.cart_set.all()
            cart_dicts  = [ model_to_dict(i) for i in carts ]
            # this sends the JSON response to the frontend
            return JsonResponse({'order': order_dict, 'carts': cart_dicts})
        except Order.DoesNotExist:
            return JsonResponse({'message': 'THERE IS NO ACTIVE ORDER'})

    @login_required
    def delete(self, request, *args, **kwargs):
        body = ast.literal_eval(request.body.decode('utf-8'))
        user = kwargs['user']
        customer_id = kwargs['customer_id']
        try:
            # this calls the last order of the user
            order       = Order.objects.get(customer = user, order_status_id = 2)
            cart_number = body['cart_number']
            Cart.objects.get(id=cart_number).delete()
            return JsonResponse({'message': 'ITEM DELETED'})
        except Order.DoesNotExist:
            return JsonResponse({'message': 'THERE IS NO ACTIVE ORDER'})

class OrderView(View):
    
    @login_required
    def post(self, request, *args, **kwargs):
        body        = ast.literal_eval(request.body.decode('utf-8'))
        user        = kwargs['user']
        customer_id = kwargs['customer_id']
        try:
            # calls the order in question
            order = Order.objects.get(customer = user, order_status_id = 2)
            # this checks whether to submit the order or not by reading the JSON body
            if body['message'] == 'submit':
            # changes the order status into 'submitted'
                order.order_status_id = 1
                order.save()
                return JsonResponse({'message': 'ORDER SUBMITION SUCCESSFUL!'})
            else:
                return JsonResponse({'message': 'ORDER SUBMITION FAILED'})
        except Order.DoesNotExist:
            return JsonResponse({'message': 'THERE IS NO ACTIVE ORDER'})

    def get(self, request):
        pass