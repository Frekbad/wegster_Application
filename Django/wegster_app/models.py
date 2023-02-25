from django.contrib.auth.models import  AbstractUser
from django.db import models
from django.dispatch import receiver
from django.urls import reverse
from django_rest_passwordreset.signals import reset_password_token_created
from django.core.mail import send_mail  

class User(AbstractUser):
    type =((1,'Customer'),
    (2,'vendor'))
    user_type = models.IntegerField(choices=type,default=1)
    username = models.CharField(max_length=50,
    unique=False)
    name = models.CharField(max_length=50,blank=True)
    address = models.CharField(max_length=50,blank=True)

    #phone = models.CharField(max_length=50)
    def __str__(self):
        return self.name

class VendorRequest(models.Model):
    email = models.CharField(max_length=50,blank=True)
    HotelName = models.CharField(max_length=50,blank=True)
    Address = models.CharField(max_length=50,blank=True)
    # HotelName = models.CharField(max_length=50,blank=True) 

    def __str__(self):
        return self.HotelName
    



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
