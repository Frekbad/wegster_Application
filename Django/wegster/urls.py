
from django.contrib import admin
from django.urls import path,include
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('admin/', admin.site.urls),
    path('user/', include('wegster_app.urls')),
    
    # path('auth/', include('dj_rest_auth.urls')),
    # path('registration/', include('dj_rest_auth.registration.urls'))
]+ static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
 