# Generated by Django 3.0.6 on 2020-06-01 04:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='store',
            name='latitude',
            field=models.DecimalField(decimal_places=7, max_digits=50, null=True),
        ),
        migrations.AddField(
            model_name='store',
            name='longitude',
            field=models.DecimalField(decimal_places=7, max_digits=50, null=True),
        ),
        migrations.AddField(
            model_name='store',
            name='time',
            field=models.CharField(max_length=50, null=True),
        ),
    ]
