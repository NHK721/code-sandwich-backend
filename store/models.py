from django.db import models

class Store(models.Model):
    address     = models.CharField(max_length=200)
    name        = models.CharField(max_length=100)
    phone       = models.CharField(max_length=20, null=False, blank=False, unique=True)

    class Meta:
        db_table = 'stores'

    def __str__(self):
        return "store address: " + address + "store phone number: " + phone
