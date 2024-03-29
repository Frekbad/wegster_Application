# Generated by Django 4.1.6 on 2023-03-10 16:31

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0056_remove_seat_passenger_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='Busbooking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Passenger_Name', models.CharField(blank=True, max_length=50)),
                ('address', models.CharField(blank=True, max_length=50)),
                ('source', models.CharField(default=True, max_length=30)),
                ('dest', models.CharField(default=True, max_length=30, null=True)),
                ('price', models.DecimalField(decimal_places=2, default=0, max_digits=6, null=True)),
                ('Payment', models.CharField(choices=[('khalti', 'KHALTI'), ('cash_Indoor', 'CASH_INDOOR')], default='cash_Indoor', max_length=20)),
                ('Order_Status', models.CharField(choices=[('Pending', 'PENDING'), ('Booking_completed', 'BOOKING_COMPLETED'), ('Booking_Canceled', 'BOOKING_CANCELED')], default='Pending', max_length=20)),
                ('Payment_Completed', models.BooleanField(default=False)),
                ('Bus_ID', models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='wegster_app.bus')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
