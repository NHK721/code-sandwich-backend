import json

from django.views     import View
from django.http      import HttpResponse, JsonResponse
from django.db.models import Q

from .models          import Store

class StoreView(View):
    def get(self, request):
        offset = int(request.GET.get('offset',0))
        limit  = int(request.GET.get('limit',10))
        try:
            stores     = Store.objects.all()
            main_store = [{
                'id'      : store.id,
                'no'      : store.no,
                'name'    : store.name,
                'address' : store.address,
                'phone'   : store.phone
            } for store in stores[offset * limit : (offset+1) * limit]]
            total = stores.count()
            return JsonResponse({'stores' : main_store, 'total' : total}, status = 200)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEY'}, status = 400)

class OpenView(View):
    def get(self, request):
        try:
            stores     = Store.objects.filter(phone="Coming Soon")
            open_store = [{
                'id'       : store.id,
                'province' : store.province.name,
                'name'     : store.name,
                'phone'    : store.phone
            } for store in stores]
            return JsonResponse({'stores' : open_store}, status = 200)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEY'}, status = 400)

class DetailView(View):
    def get(self, request, store_id):
        store      = Store.objects.get(id = store_id)
        store_data = [{
            'id'        : store.id,
            'name'      : store.name,
            'address'   : store.address,
            'phone'     : store.phone,
            'time'      : store.time,
            'longitude' : store.longitude,
            'latitude'  : store.latitude
        }]
        return JsonResponse({'store' : store_data}, status = 200)

class SearchView(View):
    def get(self, request):
        search      = request.GET.get('search', '')
        stores      = Store.objects.filter(Q(name__contains=search)|Q(address__contains=search)).all()
        search_data = [{
            'id'      : store.id,
            'name'    : store.name,
            'address' : store.address,
            'phone'   : store.phone,
            'time'    : store.time
        }for store in stores]
        
        return JsonResponse({'stores' : search_data}, status = 200)