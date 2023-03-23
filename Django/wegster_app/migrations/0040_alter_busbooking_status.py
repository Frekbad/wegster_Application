# Generated by Django 4.1.6 on 2023-03-07 17:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0039_remove_bus_date_remove_bus_time_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='busbooking',
            name='status',
            field=models.CharField(choices=[('B', 'Booked'), ('C', 'Cancelled'), ('P', 'Pending')], default='B', max_length=2),
        ),
    ]