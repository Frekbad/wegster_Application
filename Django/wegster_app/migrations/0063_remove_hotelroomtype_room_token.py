# Generated by Django 4.1.6 on 2023-03-20 08:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0062_alter_hotelroomtype_room_id'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hotelroomtype',
            name='Room_Token',
        ),
    ]