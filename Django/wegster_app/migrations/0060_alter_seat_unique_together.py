# Generated by Django 4.1.6 on 2023-03-11 15:57

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0059_busbooking_busname'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='seat',
            unique_together={('Bus_ID', 'Seat_number')},
        ),
    ]
