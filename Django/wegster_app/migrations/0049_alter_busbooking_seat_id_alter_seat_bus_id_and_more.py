# Generated by Django 4.1.6 on 2023-03-07 19:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0048_remove_bus_no_of_seats_remove_busbooking_bus_id_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='busbooking',
            name='Seat_ID',
            field=models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='wegster_app.seat'),
        ),
        migrations.AlterField(
            model_name='seat',
            name='Bus_ID',
            field=models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='wegster_app.bus'),
        ),
        migrations.AlterField(
            model_name='seat',
            name='Seat_ID',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]
