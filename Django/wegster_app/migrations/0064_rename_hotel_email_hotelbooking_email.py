# Generated by Django 4.1.6 on 2023-03-21 05:17

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0063_remove_hotelroomtype_room_token'),
    ]

    operations = [
        migrations.RenameField(
            model_name='hotelbooking',
            old_name='Hotel_email',
            new_name='email',
        ),
    ]
