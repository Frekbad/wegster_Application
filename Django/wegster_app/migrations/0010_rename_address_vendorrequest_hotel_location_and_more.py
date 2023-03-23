# Generated by Django 4.1.6 on 2023-02-27 10:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0009_rename_message_emailnotificationmodel_email_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='vendorrequest',
            old_name='Address',
            new_name='Hotel_Location',
        ),
        migrations.RenameField(
            model_name='vendorrequest',
            old_name='email',
            new_name='Hotel_email',
        ),
        migrations.RemoveField(
            model_name='vendorrequest',
            name='id',
        ),
        migrations.AddField(
            model_name='vendorrequest',
            name='Hotel_ID',
            field=models.IntegerField(default=1, primary_key=True, serialize=False),
        ),
        migrations.AddField(
            model_name='vendorrequest',
            name='Hotel_Image',
            field=models.ImageField(blank=True, null=True, upload_to=''),
        ),
        migrations.AddField(
            model_name='vendorrequest',
            name='Hotel_Token',
            field=models.CharField(blank=True, max_length=200),
        ),
    ]