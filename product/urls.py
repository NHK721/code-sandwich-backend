from django.urls        import path, re_path
from .views             import (
    ProductView, 
    SandwichView, 
    CustomizationView, 
    ToppingView, 
    BreadView, 
    WrapView,
    WrapDetailView
)

urlpatterns = [
    re_path(r'^/sandwich/(?:\?product_id=(?P<product_id>\d+)/)?$', ProductView.as_view()),
    re_path(r'^/wrap/(?:\?product_id=(?P<product_id>\d+)/)?$', WrapDetailView.as_view()),
    path('/sandwich', SandwichView.as_view()),
    path('/wrap', WrapView.as_view()),
    re_path(r'^/sandwich/customization/(?:\?product_id=(?P<product_id>\d+)/)?$', CustomizationView.as_view()),
    re_path(r'^/sandwich/customization/topping/(?:\?product_id=(?P<product_id>\d+)/)?$', ToppingView.as_view()),
    re_path(r'^/sandwich/customization/bread/(?:\?product_id=(?P<product_id>\d+)/)?$', BreadView.as_view()),
]
