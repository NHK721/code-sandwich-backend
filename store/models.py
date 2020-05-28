from django.db import models

class Store(models.Model):
    address     = models.CharField(max_length=200)
    name        = models.CharField(max_length=100)
    phone       = models.PhoneNumberField(null=False, blank=False, unique=True)

