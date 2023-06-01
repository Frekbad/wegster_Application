from django.contrib.auth.models import  AbstractUser
from django.db import models
from django.dispatch import receiver
from django.urls import reverse
from django_rest_passwordreset.signals import reset_password_token_created
from django.core.mail import send_mail  


class User(AbstractUser):
    type =((1,'Customer'),
    (2,'vendor'),
    (3,'admin')
    )
    user_type = models.IntegerField(choices=type,default=1)
    username = models.CharField(max_length=50,
    unique=False)
    name = models.CharField(max_length=50,blank=True)
    address = models.CharField(max_length=200,blank=True)

    def __str__(self):
        return self.name
    
def upload_to(inst , filename):
    return

class VendorRequest(models.Model):
    Hotel_ID = models.IntegerField(primary_key=True,default=1)
    Hotel_Image = models.ImageField(null=True,blank=True)
    Hotel_email = models.CharField(max_length=50,blank=True)
    HotelName = models.CharField(max_length=50,blank=True)
    Hotel_Location = models.CharField(max_length=50,blank=True)
    Hotel_Token =models.CharField(max_length=200,blank=True)
    # Hotel_Price = models.IntegerField(default=0)
    Hotel_Description = models.CharField(max_length=1000,blank=True)


    def __str__(self):
        return self.HotelName

class EmailNotificationModel(models.Model):
    email = models.CharField(max_length=50,blank=True)
    message = models.CharField(max_length=255,blank=True)

class HotelRoomType(models.Model):
    Room_ID = models.AutoField(primary_key=True)
    price_per_night = models.DecimalField(max_digits=10,decimal_places=2,blank=True,null=True)
    Room_Type=models.CharField(max_length=50,default=True)
    Hotel_ID = models.ForeignKey(VendorRequest, on_delete= models.CASCADE)
    Bed_Type = models.CharField(max_length=50,default=True)
    Refundable_Option = models.CharField(max_length=50,default=True)


    def __str__(self):
        return self.Room_Type

 

class Bus(models.Model):
    Bus_ID = models.AutoField(primary_key=True)
    Busname = models.CharField(max_length= 255)
    source = models.CharField(max_length=30,default=True)
    dest = models.CharField(max_length=30,null=True,default=True)
    price = models.DecimalField(decimal_places=2, max_digits=6,null=True,default=0)
    totalSeats = models.IntegerField(default=0)
    email = models.CharField(max_length=50,blank=True)
   

    def __str__(self):
        return self.Busname

class Seat(models.Model):
    Seat_ID =models.AutoField(primary_key=True)
    Bus_ID = models.ForeignKey(Bus, on_delete=models.CASCADE,null=True, default=None)
    Seat_number = models.CharField(max_length=10)
    available = models.BooleanField(default=True)

    class Meta:
        unique_together = ('Bus_ID', 'Seat_number')
   

    def __str__(self):
        return self.Seat_number
     

class Busbooking(models.Model):
    Bus_ID = models.ForeignKey(Bus, on_delete=models.CASCADE,null=True, default=None)
    name = models.CharField(max_length=50,blank=True)
    address = models.CharField(max_length=50,blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    source = models.CharField(max_length=30,default=True)
    dest = models.CharField(max_length=30,null=True,default=True)
    price = models.DecimalField(decimal_places=2, max_digits=6,null=True,default=0)
    Busname = models.CharField(max_length= 255,blank=True)
    Seat_ID = models.ForeignKey(Seat, on_delete=models.CASCADE,null=True, default=None),
    email = models.CharField(max_length=50,blank=True)
    
    Payment_Type = (
        ('khalti', 'KHALTI'),
        ('cash_on_Arrival', 'CASH_ON_ARRIVAL'),
    )
    Payment = models.CharField(max_length = 20, choices= Payment_Type, default='cash_on_Arrival')
    Status = (
        ('Pending', 'PENDING'),
        ('Booking_completed', 'BOOKING_COMPLETED'),
        ('Booking_Canceled', 'BOOKING_CANCELED')
    )
    Order_Status = models.CharField(max_length = 20, choices= Status, default= 'Pending')
    Payment_Completed = models.BooleanField(default=False)

    def __str__(self):
        return self.name
    
      
        

class HotelBooking(models.Model):
    Room_Type = models.CharField(max_length=100,blank=True)
    Bed_Type = models.CharField(max_length=50,default=True)
    price_per_night = models.DecimalField(max_digits=10,decimal_places=2,blank=True,null=True)
    Refundable_Option = models.CharField(max_length=50,default=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50,blank=True)
    address = models.CharField(max_length=50,blank=True)
    Hotel_email = models.CharField(max_length=50,blank=True)
    HotelName = models.CharField(max_length=50,blank=True)
    Hotel_Location = models.CharField(max_length=50,blank=True)
    Hotel_ID = models.ForeignKey(VendorRequest,on_delete=models.CASCADE)
    

    Payment_Type = (
        ('khalti', 'KHALTI'),
        ('cash_on_door', 'CASH_ON_DOOR'),
    )
    Payment = models.CharField(max_length = 20, choices= Payment_Type, default='cash_on_door')
    Status = (
        ('Pending', 'PENDING'),
        ('Booking_completed', 'BOOKING_COMPLETED'),
        ('Booking_Canceled', 'BOOKING_CANCELED')
    )
    Order_Status = models.CharField(max_length = 20, choices= Status, default= 'Pending')
    Payment_Completed = models.BooleanField(default=False)

    def __str__(self):
        return self.name 
    
    

class Review(models.Model):
    Rating = models.FloatField(blank=True, default=0)
    Review = models.CharField(max_length=500, blank= True)
    Hotelname = models.CharField(max_length = 50, blank=True)
    Hotel_ID = models.ForeignKey(VendorRequest, on_delete=models.CASCADE,null=True)
    Customer_Name = models.CharField(max_length = 50, blank=True)

    def __str__(self):
        return self.Hotelname



 
    



@receiver(reset_password_token_created)
def password_reset_token_created(sender, instance, reset_password_token, *args, **kwargs):

    

    email_plaintext_message = "{}token={}".format(reverse('password_reset:reset-password-request'), reset_password_token.key)

    send_mail(
        # title:
        "Password Reset for {title}".format(title="Wegster"),
        # message:
        email_plaintext_message,
        # from:
        "noreply@somehost.local",
        # to:
        [reset_password_token.user.email]
    )
# Create your models here. 
