# Generated by Django 4.1.6 on 2023-03-04 16:11

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0023_hotelroomtype'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hotelroomtype',
            name='Room_Price',
        ),
        migrations.AddField(
            model_name='hotelroomtype',
            name='price_per_night',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True),
        ),
        migrations.CreateModel(
            name='Booking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('check_in_date', models.DateField()),
                ('check_out_date', models.DateField()),
                ('Hotel_ID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='wegster_app.vendorrequest')),
                ('Room_ID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='wegster_app.hotelroomtype')),
                ('user_name', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
