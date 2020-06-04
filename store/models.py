from django.db import models

class Store(models.Model):
    no          = models.IntegerField(null=True)
    address     = models.CharField(max_length=200, null = True)
    name        = models.CharField(max_length=100, null = True)
    phone       = models.CharField(max_length=20, null = True)
    time        = models.CharField(max_length = 50, null = True)
    longitude   = models.DecimalField(max_digits = 50, decimal_places = 7, null = True)
    latitude    = models.DecimalField(max_digits = 50, decimal_places = 7, null = True)
    province    = models.ForeignKey('Province', on_delete = models.CASCADE, null=True)
    class Meta:
        db_table = 'stores'

    def __str__(self):
        return self.name

class Province(models.Model):
    name    = models.CharField(max_length = 50)

    class Meta:
        db_table = 'provinces'

    def __str__(self):
        return self.name
                
