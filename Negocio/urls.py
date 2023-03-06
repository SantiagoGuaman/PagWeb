from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.Home, name='inicio'),
    path('home/', views.Home, name='home'),
    path('signin/', views.signin, name='signin'),
    path('login/', views.loginst, name='login'),
    path('logout/', views.signout, name='logout'),
    path('create_product/', views.create_product, name='create_product'),
    path('update_product/<str:pk>/', views.update_product, name='update_product'),
    path('delete_product/<str:pk>/', views.delete_product, name='delete_product'),
    path('contactus/', views.contactus, name='contactus'),
    path('quotes/', views.quotes, name='quotes'),
    path('my_projects/', views.list_files, name='my_projects'),
    path('delete_file/<str:pk>/', views.delete_file, name='delete_file'),
    path('about/', views.about, name='about'),
    path('products/', views.products, name='products'),
    path('cart/', views.cart, name='cart'),
    path('add_to_cart/', views.add_to_cart, name='add'),
    path('payment/', views.payment, name='payment'),
    path('send/', views.contact, name='send'),
    path('signin/send/', views.signin, name='signinsend'),
    path('login/send/', views.loginst, name='loginsend'),
    path('products/send/', views.contact, name='listsend'),
    path('home/send/', views.contact, name='homesend'),
    path('quotes/send/', views.contact, name='quotessend'),
    path('cart/send/', views.contact, name='cartsend'),
    path('about/send/', views.contact, name='aboutsend'),
    path('contactus/send/', views.contact, name='contactussend'),
    path('payment/send/', views.payment, name='payment'),
    path('remove_from_cart/', views.remove_from_cart, name='remove'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)