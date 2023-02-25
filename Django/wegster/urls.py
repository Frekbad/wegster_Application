
from django.contrib import admin
from django.urls import path,include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('user/', include('wegster_app.urls')),
    # path('auth/', include('dj_rest_auth.urls')),
    # path('registration/', include('dj_rest_auth.registration.urls'))
]
 