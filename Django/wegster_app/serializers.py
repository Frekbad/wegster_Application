from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer
from rest_framework import serializers
from dj_rest_auth.serializers import UserDetailsSerializer
from django.contrib.auth import get_user_model
from .models import VendorRequest
# from django.contrib.auth.tokens import PasswordResetTokenGenerator
# from django.contrib.auth.models import User
# from django.utils.encoding import smart_str,force_str, smart_bytes, DjangoUnicodeDecodeError


UserModel = get_user_model()

class NewUserDetailsSerializer(UserDetailsSerializer):
    class Meta:
        model=UserModel
        fields=["pk","email","name","address","user_type"]

class VendorRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model =VendorRequest
        fields = '__all__'


class NewRegisterSerializer(RegisterSerializer):
    name=serializers.CharField()
    address=serializers.CharField()
    #phone=serializers.CharField()
    def custom_signup(self, request, user):
        user.user_type = 1
        user.name=request.data['name']
        user.address=request.data['address']
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
        
class NewLoginSerializer(LoginSerializer):
    pass





class ChangePasswordSerializer(serializers.Serializer):
    model = UserModel

    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

# class ResetPasswordEmailRequeestSerializer(serializers.Serializer):
#     email=serializers.EmailField(min_length =2)

#     class Meta:
#         fields =['email']

#     def validate(self, attrs):
#         try:
#             email=attrs.get('email', '')
#             if UserModel.objects.filter(email=email).exists():
#                 return attrs
               
#         except
#         return super().validate(attrs)