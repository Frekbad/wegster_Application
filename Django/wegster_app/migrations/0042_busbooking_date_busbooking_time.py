# Generated by Django 4.1.6 on 2023-03-07 17:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0041_alter_hotelbooking_payment'),
    ]

    operations = [
        migrations.AddField(
            model_name='busbooking',
            name='date',
            field=models.DateField(null=True),
        ),
        migrations.AddField(
            model_name='busbooking',
            name='time',
            field=models.TimeField(null=True),
        ),
    ]