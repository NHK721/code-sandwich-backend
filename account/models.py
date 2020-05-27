from django.db import models

class Account(models.Model):
    email    = models.EmailField(max_length = 50, unique = True)
    phone    = models.CharField(max_length = 50)
    name     = models.CharField(max_length = 50)
    password = models.CharField(max_length = 50)
    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)
    
    class Meta:
        db_table = 'accounts'    
