from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer
from rest_framework import serializers
from dj_rest_auth.serializers import UserDetailsSerializer
from django.contrib.auth import get_user_model
from .models import VendorRequest,EmailNotificationModel,HotelRoomType,HotelBooking, Bus,Seat,Busbooking,Review
# from django.contrib.auth.tokens import PasswordResetTokenGenerator
# from django.contrib.auth.models import User
# from django.utils.encoding import smart_str,force_str, smart_bytes, DjangoUnicodeDecodeError


UserModel = get_user_model()

class NewUserDetailsSerializer(UserDetailsSerializer):
    class Meta:
        model=UserModel
        fields=["pk","email","name","address","user_type",]

class VendorRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model =VendorRequest
        fields = '__all__'


class NewRegisterSerializer(RegisterSerializer):
    name=serializers.CharField()
    
    #phone=serializers.CharField()
    def custom_signup(self, request, user):
        user.user_type = 1
        user.name=request.data['name']
        
        #user.phone=request.data['phone']
        user.save()

class VendorRegisterSerializer(RegisterSerializer):
    name=serializers.CharField()
    address=serializers.CharField()
    #phone=serializers.CharField()
    def custom_signup(self, request, user):
        user.user_type = 2
        user.name=request.data['name']
        user.address=request.data['address']
        #user.phone=request.data['phone']
        user.save()

class AdminRegisterSerializer(RegisterSerializer):
    name=serializers.CharField()
    address=serializers.CharField()
    #phone=serializers.CharField()
    def custom_signup(self, request, user):
        user.user_type = 3
        user.name=request.data['name']
        user.address=request.data['address']
        #user.phone=request.data['phone']
        user.save()        

class EmailNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmailNotificationModel
        fields = '__all__'

class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotelRoomType
        fields = '__all__'

 


class BookingHotelSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotelBooking
        fields = '__all__'


class BusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bus
        fields = '__all__'

class SeatSerializer(serializers.ModelSerializer):
    class Meta:
        model = Seat
        fields = '__all__'        

class BookingBusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Busbooking
        fields = '__all__'

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'

class NewLoginSerializer(LoginSerializer):
    pass






