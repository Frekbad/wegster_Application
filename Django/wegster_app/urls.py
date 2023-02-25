from dj_rest_auth.registration.views import VerifyEmailView
from django.contrib import admin
from django.urls import path,include
from wegster_app.views import CustomerRegistrationView, VendorRegistrationView,VendorForm,ChangePasswordRequest

urlpatterns=[
     path('auth/', include('dj_rest_auth.urls')),
    path('auth/registration/', include('dj_rest_auth.registration.urls')),
    path('auth/confirm-email/', VerifyEmailView.as_view(),name='account_email_verification_sent'),
    path('registration/customer/', CustomerRegistrationView.as_view(), name = 'Customer Register'),
    path('registration/vendor/', VendorRegistrationView.as_view(), name = 'Vendor Register'),
    path('unverifiedvendor/',VendorForm.as_view(), name = 'Unverified Vendors'),
    path('auth/change-password/', ChangePasswordRequest.as_view(), name='change-password'),
    path('auth/password-reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
    # path('auth/password-reset/confirm', include('django_rest_passwordresetconfirm.urls', namespace='password_resetconfirm')),
    
]