from django.urls import path, include

urlpatterns = [
    path('store', include('store.urls')),
    path('account/', include('account.urls')),
    path('product/', include('product.urls')),
]
