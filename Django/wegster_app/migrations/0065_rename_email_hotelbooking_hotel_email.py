# Generated by Django 4.1.6 on 2023-03-21 05:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0064_rename_hotel_email_hotelbooking_email'),
    ]

    operations = [
        migrations.RenameField(
            model_name='hotelbooking',
            old_name='email',
            new_name='Hotel_email',
        ),
    ]