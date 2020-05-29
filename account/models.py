from django.db import models

class Customer(models.Model):
    email       = models.EmailField(max_length = 100, unique = True)
    phone       = models.CharField(max_length = 45)
    username    = models.CharField(max_length = 50)
    password    = models.CharField(max_length = 200)
    created_at  = models.DateTimeField(auto_now_add = True)
    updated_at  = models.DateTimeField(auto_now = True)

    class Meta:
        db_table = 'customers'

    def __str__(self):
        return "username: " + username + ", phone: " + phone
