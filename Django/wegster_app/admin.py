from django.contrib import admin
from . import models
# Register your models here.
admin.site.register(models.User)
admin.site.register(models.VendorRequest)
# admin.site.register(models.Booking)
admin.site.register(models.EmailNotificationModel)
admin.site.register(models.HotelRoomType)
admin.site.register(models.HotelBooking)
admin.site.register(models.Bus)
admin.site.register(models.Seat)
admin.site.register(models.Busbooking)
admin.site.register(models.Review)
