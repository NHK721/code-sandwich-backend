from django.db          import models
from store.models       import Store
from account.models     import Customer
from product.models     import Product, Ingredient

class Order(models.Model):
    customer                    = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    destination_location        = models.ForeignKey('DestinationLocation', on_delete=models.SET_NULL, blank=True, null=True)
    store                       = models.ForeignKey(Store, on_delete=models.SET_NULL, blank=True, null=True)
    creditcard_number           = models.CharField(max_length=16, null=True)
    creditcard_cvc              = models.CharField(max_length=3, null=True)
    creditcard_expiraion_date   = models.CharField(max_length=4, null=True)
    creditcard_fullname         = models.CharField(max_length=100, null=True)
    order_date                  = models.DateTimeField(auto_now_add=True, null=True)
    order_status                = models.ForeignKey('OrderStatus', on_delete=models.SET_NULL, blank=True, null=True)
    total_price                 = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'orders'

    def __str__(self):
        return "order_date: " + order_date + ", total_price: " + total_price

class Cart(models.Model):
    order       = models.ForeignKey('Order', on_delete=models.SET_NULL, blank=True, null=True)
    price       = models.IntegerField(blank=True, null=True)
    amount      = models.IntegerField(blank=True, null=True)
    product     = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True)

    class Meta:
        db_table = 'carts'

    def __str__(self):
        return "product: " + product + ", amount: " + amount

class OrderStatus(models.Model):
    name    = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        db_table = 'order_status'

class CartIngredient(models.Model):
    cart        = models.ForeignKey('Cart', on_delete=models.SET_NULL, blank=True, null=True)
    ingredient  = models.ForeignKey(Ingredient, on_delete=models.SET_NULL, blank=True, null=True)

    class Meta:
        db_table = 'cart_ingredients'

class DestinationLocation(models.Model):
    address = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        db_table = 'destination_locations'
