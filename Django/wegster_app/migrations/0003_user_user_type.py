# Generated by Django 4.1.6 on 2023-02-23 08:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0002_alter_user_address_alter_user_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='user_type',
            field=models.IntegerField(choices=[(1, 'Customer'), (2, 'vendor')], default=1),
        ),
    ]
