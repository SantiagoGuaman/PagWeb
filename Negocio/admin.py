from django.contrib import admin
from .models import *
from django.contrib.auth.models import User, Group
# Register your models here.
admin.site.register(Marca)
admin.site.register(Descuento)
admin.site.register(Material)

admin.site.register(Producto)
admin.site.register(Categoria)

admin.site.register(Cart)
admin.site.register(Item_Cart)

admin.site.unregister(User)
admin.site.unregister(Group)