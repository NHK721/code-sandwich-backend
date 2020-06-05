from django.urls import path, include

urlpatterns = [
    path('', include('account.urls')),
    path('product', include('product.urls')),
    path('cart', include('order.urls')),
    path('store', include('store.urls')),
]
