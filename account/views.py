import json
import bcrypt
import jwt


from codesandwich.settings  import SECRET_KEY
from django.views           import View
from django.http            import HttpResponse, JsonResponse
from django.core.validators import validate_email
from django.core.exceptions import ValidationError



from .models import Customer


class SignUpView(View):
    def post(self, request):
        data = json.loads(request.body)
        
        try:
            validate_email(data['email'])
            if len(data['password']) < 6:
                return JsonResponse({'message': '8자리 이상 입력하세요'}, status=400)
            if not Customer.objects.filter(email = data['email']).exists():
                hashed_password = bcrypt.hashpw(data['password'].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
                Customer.objects.create(
                        email = data['email'],
                        password = hashed_password,
                        username = data['username'],
                        phone = data['phone']
                )
                return JsonResponse({'message':'SUCCESS'}, status=200)
            else:
                return JsonResponse({'message':'ALREADY_EXIST'}, status=400)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEYS'}, status=400)
        except ValidationError:
            return JsonResponse({'message':'INVALID_EMAIL'}, status=400)


class SignInView(View):
    def post(self, request, *args, **kwargs):
        data = json.loads(request.body)
        try:
            if Customer.objects.filter(email = data['email']).exists():
                if bcrypt.checkpw(data['password'].encode('utf-8'), Customer.objects.get(email = data['email']).password.encode('utf-8')):
                    token = jwt.encode({ 'email' : data['email'] }, SECRET_KEY, algorithm='HS256').decode('utf-8')
                    return JsonResponse({'token':token},status=200)
                return JsonResponse({'message':'INVALID_USER'},status=401)
            return JsonResponse({'message':'INVALID_USER'},status=401)
        except KeyError:
            return JsonResponse({'message':'INVALID_KEYS'}, status=400)



