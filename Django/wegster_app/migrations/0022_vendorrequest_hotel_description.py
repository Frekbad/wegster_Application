# Generated by Django 4.1.6 on 2023-03-04 03:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0021_delete_profileeditmodel'),
    ]

    operations = [
        migrations.AddField(
            model_name='vendorrequest',
            name='Hotel_Description',
            field=models.CharField(blank=True, max_length=1000),
        ),
    ]
