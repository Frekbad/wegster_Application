
from dj_rest_auth.registration.views import VerifyEmailView
from django.contrib import admin
from django.urls import path,include
from wegster_app import views
from wegster_app.views import CustomerRegistrationView, VendorRegistrationView,SendEmailNotification,TodoGetCreate,TodoUpdateDelete,RoomGetCreate,RoomListByHotel, BookingListByUser, BookingListByHotel , RoomBookUpdate , RoomBook, BusView, SpecificBusView,SeatView,SeatListByBus,BusBook,BusBookUpdate,BusBookingListByUser,BookingListByBus,BookingListBySeat,AdminRegistrationView,ReviewsViews,ReviewListByHotel
from django_rest_passwordreset.views import reset_password_request_token, reset_password_confirm

urlpatterns=[
    path('auth/', include('dj_rest_auth.urls')),
    path('auth/registration/', include('dj_rest_auth.registration.urls')),
    path('auth/confirm-email/', VerifyEmailView.as_view(),name='account_email_verification_sent'),
    path('registration/customer/', CustomerRegistrationView.as_view(), name = 'Customer Register'),
    path('registration/vendor/', VendorRegistrationView.as_view(), name = 'Vendor Register'),
    path('registration/Admin/', AdminRegistrationView.as_view(), name = 'Admin Register'),
    path('auth/password-reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
    path('send-email-notification/',SendEmailNotification.as_view()),
    path('Hotel/', TodoGetCreate.as_view()),
    path('Hotel/<int:pk>/', TodoUpdateDelete.as_view()),
    path('Room/', RoomGetCreate.as_view()),
    path('Room/<str:vendor>/', RoomListByHotel.as_view(), name='product-list-by-hotel'),
    path('RoomBook/', RoomBook.as_view()),
    path('RoomBook/<int:pk>', RoomBookUpdate.as_view()),
    path('RoomBookUser/<str:user>', BookingListByUser.as_view()),
    path('RoomBookVendor/<str:vendor>', BookingListByHotel.as_view()),
    path('Bus/', BusView.as_view()),
    path('Bus/<int:pk>', SpecificBusView.as_view()),
    path('Seat/', SeatView.as_view()),
    path('Seat/<str:seat>', SeatListByBus.as_view()),
    path('BusBook/', BusBook.as_view()),
    path('BusBook/<int:pk>', BusBookUpdate.as_view()),
    path('BusBookUser/<str:user>', BusBookingListByUser.as_view()),
    path('BusBookBus/<str:bus>', BookingListByBus.as_view()),
    path('BusBookseat/<str:seat>', BookingListBySeat.as_view()),
    path('Review/', ReviewsViews.as_view()),
    path('Review/<str:vendor>', ReviewListByHotel.as_view()),
    # path('uploadimage/', imageupload),
]

    

    # path('Edit-profile/', UpdateProfileView.as_view(), name='update_profile'),
   
  
    #path('auth/password-reset/confirm', include('django_rest_passwordresetconfirm.urls', namespace='password_resetconfirm')),
    
