# Generated by Django 4.1.6 on 2023-03-23 12:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0068_alter_review_rating'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='user_type',
            field=models.IntegerField(choices=[(1, 'Customer'), (2, 'vendor'), (3, 'admin')], default=1),
        ),
    ]
