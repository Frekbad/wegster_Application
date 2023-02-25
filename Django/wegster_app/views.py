from django.shortcuts import render
from dj_rest_auth.views import UserDetailsView
from dj_rest_auth.registration.views import RegisterView
from .models import User, VendorRequest
from rest_framework import generics
from rest_framework import status
from rest_framework.response import Response
from django.contrib.auth import get_user_model
from rest_framework.permissions import IsAuthenticated 
from .serializers import NewRegisterSerializer, NewUserDetailsSerializer, VendorRegisterSerializer,VendorRequestSerializer,ChangePasswordSerializer

UserModel = get_user_model()

class userDetails(UserDetailsView):
    queryset = User.objects.all()
    serializer_class = NewUserDetailsSerializer

class VendorForm(generics.ListCreateAPIView):
    queryset = VendorRequest.objects.all()
    serializer_class = VendorRequestSerializer


class CustomerRegistrationView(RegisterView):
    serializer_class = NewRegisterSerializer

class VendorRegistrationView(RegisterView):
    serializer_class = VendorRegisterSerializer



class ChangePasswordRequest(generics.UpdateAPIView):
    
    serializer_class = ChangePasswordSerializer
    model = UserModel
    permission_classes = (IsAuthenticated,)

    def get_object(self, queryset=None):
        obj = self.request.user
        return obj

    def update(self, request, *args, **kwargs):
        self.object = self.get_object()
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            
            if not self.object.check_password(serializer.data.get("old_password")):
                return Response({"old_password": ["Wrong password."]}, status=status.HTTP_400_BAD_REQUEST)
            
            self.object.set_password(serializer.data.get("new_password"))
            self.object.save()
            response = {
                'status': 'success',
                'code': status.HTTP_200_OK,
                'message': 'Password updated successfully',
                'data': []
            }

            return Response(response)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



