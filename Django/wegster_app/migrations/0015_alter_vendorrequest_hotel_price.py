# Generated by Django 4.1.6 on 2023-02-28 05:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0014_alter_vendorrequest_hotel_price'),
    ]

    operations = [
        migrations.AlterField(
            model_name='vendorrequest',
            name='Hotel_Price',
            field=models.DecimalField(decimal_places=2, max_digits=8),
        ),
    ]