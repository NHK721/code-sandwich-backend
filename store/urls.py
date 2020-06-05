from django.urls import path
from .views import StoreView, OpenView, DetailView, SearchView

urlpatterns = [
        path('/main', StoreView.as_view()),
        path('/open', OpenView.as_view()),
        path('/detail/<int:store_id>', DetailView.as_view()),
        path('/search',SearchView.as_view()),
    ]
