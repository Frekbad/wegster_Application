# Generated by Django 4.1.6 on 2023-03-11 07:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0058_rename_passenger_name_busbooking_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='busbooking',
            name='Busname',
            field=models.CharField(blank=True, max_length=255),
        ),
    ]
