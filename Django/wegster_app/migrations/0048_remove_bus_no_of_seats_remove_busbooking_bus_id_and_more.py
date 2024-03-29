# Generated by Django 4.1.6 on 2023-03-07 19:37

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('wegster_app', '0047_alter_busbooking_status'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='bus',
            name='no_of_seats',
        ),
        migrations.RemoveField(
            model_name='busbooking',
            name='Bus_ID',
        ),
        migrations.RemoveField(
            model_name='busbooking',
            name='dest',
        ),
        migrations.RemoveField(
            model_name='busbooking',
            name='numberofseat',
        ),
        migrations.AlterField(
            model_name='busbooking',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name='busbooking',
            name='status',
            field=models.CharField(choices=[('P', 'Pending'), ('B', 'Booked'), ('C', 'Cancelled')], default='pending', max_length=2),
        ),
        migrations.CreateModel(
            name='Seat',
            fields=[
                ('Seat_ID', models.AutoField(default=1, primary_key=True, serialize=False)),
                ('number', models.CharField(max_length=10)),
                ('available', models.BooleanField(default=True)),
                ('Bus_ID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='wegster_app.bus')),
            ],
        ),
        migrations.AddField(
            model_name='busbooking',
            name='Seat_ID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='wegster_app.seat'),
        ),
    ]
