from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=50)

    class Meta:
        db_table = 'categories'

class SubCategory(models.Model):
    name     = models.CharField(max_length=50)
    category = models.ForeignKey(Category, on_delete = models.CASCADE)

    class Meta:
        db_table = 'sub_categories'

class Product(models.Model):
    name               = models.CharField(max_length=50)
    name_en            = models.CharField(max_length=50)
    image_url          = models.URLField(max_length=2000, null = True)
    description        = models.TextField(null=True)
    default_price      = models.DecimalField(max_digits=10, decimal_places=2,null = True)
    toasted            = models.BooleanField(null=True)
    customization_true = models.BooleanField(null=True)
    nutrition          = models.OneToOneField('Nutrition', on_delete = models.SET_NULL, null=True)
    category           = models.ForeignKey(Category, on_delete = models.SET_NULL, null = True)
    subcategory        = models.ForeignKey(SubCategory, on_delete = models.SET_NULL, null = True)
    product_ingredient = models.ManyToManyField('Ingredient', through='ProductIngredient')

    class Meta:
        db_table = 'products'

    def __str__(self):
        return self.name

class Nutrition(models.Model):
    size_g          = models.IntegerField(null = True)
    calories_kcal   = models.IntegerField(null = True)
    sugar_g         = models.IntegerField(null = True)
    protein_g       = models.IntegerField(null = True)
    saturated_fat_g = models.IntegerField(null = True)
    sodium_g        = models.IntegerField(null = True)

    class Meta:
        db_table = 'nutritions'

class IngredientCategory(models.Model):
    name = models.CharField(max_length = 50)

    class Meta:
        db_table = 'ingredient_categories'

class Ingredient(models.Model):
    name                        = models.CharField(max_length=50)
    image_url                   = models.URLField(max_length=2000, null = True)
    price                       = models.DecimalField(max_digits=10, decimal_places=2,null = True)
    ingredient_category         = models.ForeignKey(IngredientCategory, on_delete = models.SET_NULL, null = True)
    ingredient_placeoforigin    = models.ManyToManyField('PlaceOfOrigin', through='IngredientPlaceOfOrigin')
    ingredient_allergen         = models.ManyToManyField('Allergen', through='IngredientAllergen')

    class Meta:
        db_table = 'ingredients'

    def __str__(self):
        return self.name


class ProductIngredient(models.Model):
    is_default    = models.BooleanField(null=True)
    product       = models.ForeignKey(Product, on_delete = models.CASCADE)
    ingredient    = models.ForeignKey(Ingredient, on_delete = models.CASCADE)   


class PlaceOfOrigin(models.Model):
    name = models.CharField(max_length=50)

    class Meta:
        db_table = 'place_of_origins'

class IngredientPlaceOfOrigin(models.Model):
    ingredient          = models.ForeignKey(Ingredient, on_delete = models.CASCADE)
    place_of_origin     = models.ForeignKey(PlaceOfOrigin,  on_delete = models.CASCADE)

    class Meta:
        db_table = 'ingredients_placeoforigins'


class Allergen(models.Model):
    name = models.CharField(max_length=50)

    class Meta:
        db_table = 'allergens'

class IngredientAllergen(models.Model):
    ingredient  = models.ForeignKey(Ingredient, on_delete = models.CASCADE)
    allergen    = models.ForeignKey(Allergen, on_delete = models.CASCADE)

    class Meta:
        db_table = 'ingredients_allergens'

