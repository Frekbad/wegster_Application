# Generated by Django 4.1.6 on 2023-05-23 06:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0072_remove_busbooking_seat_id_busbooking_email'),
    ]

    operations = [
        migrations.AddField(
            model_name='bus',
            name='email',
            field=models.CharField(blank=True, max_length=50),
        ),
    ]