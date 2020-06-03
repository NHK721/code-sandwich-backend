from django.urls import path
from .views import CartView, OrderView

urlpatterns = [
    path('/modification', CartView.as_view()),
    path('/submission', OrderView.as_view()),
]