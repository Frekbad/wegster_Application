from django.shortcuts import render,redirect
from dj_rest_auth.views import UserDetailsView
from dj_rest_auth.registration.views import RegisterView
from .models import User, VendorRequest,EmailNotificationModel,HotelRoomType,Bus, HotelBooking,Seat,Bus,Busbooking,Review
from rest_framework import generics
from rest_framework.response import Response
from django.contrib.auth import get_user_model
from django.core.mail import send_mail
from django.conf import settings
from rest_framework import status
from django.contrib.messages.views import SuccessMessageMixin
from django.utils.translation import gettext_lazy as _
import requests
# from .serializers import EditProfileSerializer
# from rest_framework.permissions import IsAuthenticated



#  from .serializers import EmailNotificationSerializer

from .serializers import NewRegisterSerializer, NewUserDetailsSerializer, VendorRegisterSerializer,VendorRequestSerializer,EmailNotificationSerializer,RoomSerializer,BusSerializer, BookingHotelSerializer,SeatSerializer,BookingBusSerializer,ReviewSerializer,AdminRegisterSerializer

UserModel = get_user_model()

class userDetails(UserDetailsView):
    queryset = User.objects.all()
    serializer_class = NewUserDetailsSerializer




class CustomerRegistrationView(RegisterView):
    serializer_class = NewRegisterSerializer

class VendorRegistrationView(RegisterView):
    serializer_class = VendorRegisterSerializer

class AdminRegistrationView(RegisterView):
    serializer_class = AdminRegisterSerializer

class TodoGetCreate(generics.ListCreateAPIView):
   queryset = VendorRequest.objects.all()
   serializer_class = VendorRequestSerializer  

class TodoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
   queryset = VendorRequest.objects.all()
   serializer_class = VendorRequestSerializer



class SendEmailNotification(generics.CreateAPIView):
    queryset =EmailNotificationModel.objects.all()
    serializer_class = EmailNotificationSerializer
    
    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        #from_email = request.data.get('from_email')
        # serializer = EmailNotificationSerializer(EmailNotificationModel)
        
        
        send_mail(
            'Notification from Wegster.',
            serializer.data['message'],
            settings.EMAIL_HOST_USER,
            [serializer.data['email']],
            fail_silently=False,
        )
        
        
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data,
                         status=status.HTTP_201_CREATED, headers=headers)



    
class RoomGetCreate(generics.ListCreateAPIView):
   queryset = HotelRoomType.objects.all()
   serializer_class = RoomSerializer

class RoomListByHotel(generics.ListCreateAPIView):
    serializer_class = RoomSerializer

    def get_queryset(self):
        vendor = self.kwargs['vendor']
        queryset = HotelRoomType.objects.filter( Hotel_ID=vendor)
        return queryset 

      

class BookingListByUser(generics.ListCreateAPIView):
    serializer_class = BookingHotelSerializer
    def get_queryset(self):
        user = self.kwargs['user']
        queryset = HotelBooking.objects.filter(user = user)
        return queryset
    
class BookingListByHotel(generics.ListCreateAPIView):
    serializer_class = BookingHotelSerializer

    def get_queryset(self):
        vendor = self.kwargs['vendor']
        queryset = HotelBooking.objects.filter( Hotel_ID = vendor)
        return queryset
    
class RoomBookUpdate(generics.RetrieveUpdateAPIView):
   queryset = HotelBooking.objects.all()
   serializer_class = BookingHotelSerializer

class RoomBook(generics.ListCreateAPIView):
   queryset = HotelBooking.objects.all()
   serializer_class = BookingHotelSerializer


class BusView(generics.ListCreateAPIView):
    queryset = Bus.objects.all()
    serializer_class = BusSerializer

class SpecificBusView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Bus.objects.all()
    serializer_class = BusSerializer

class SeatView(generics.ListCreateAPIView):
    queryset = Seat.objects.all()
    serializer_class = SeatSerializer

class SeatListByBus(generics.ListCreateAPIView):
    serializer_class = SeatSerializer

    def get_queryset(self):
        seat = self.kwargs['seat']
        queryset = Seat.objects.filter(Bus_ID= seat)
        return queryset

class BusBook(generics.ListCreateAPIView):
   queryset = Busbooking.objects.all()
   serializer_class = BookingBusSerializer    

class BusBookUpdate(generics.RetrieveUpdateAPIView):
   queryset = Busbooking.objects.all()
   serializer_class = BookingBusSerializer  

class BusBookingListByUser(generics.ListCreateAPIView):
    serializer_class = BookingBusSerializer
    def get_queryset(self):
        user = self.kwargs['user']
        queryset = Busbooking.objects.filter(user = user)
        return queryset 
      
class BookingListByBus(generics.ListCreateAPIView):
    serializer_class = BookingBusSerializer

    def get_queryset(self):
        bus = self.kwargs['bus']
        queryset = Busbooking.objects.filter( Bus_ID = bus)
        return queryset  
    
class BookingListBySeat(generics.ListCreateAPIView):
    serializer_class = BookingBusSerializer

    def get_queryset(self):
        seat = self.kwargs['seat']
        queryset = Busbooking.objects.filter( Seat_ID = seat)
        return queryset       

class ReviewListCreateAPIView(generics.ListCreateAPIView):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer