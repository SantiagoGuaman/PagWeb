from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
import uuid
# Create your models here.


class Marca(models.Model):
    nombre_mar = models.CharField(max_length=100, unique=True)
    fecha_creacion_mar = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modificacion_mar = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.nombre_mar

class Descuento(models.Model):
    nombre_des = models.CharField(max_length=100, unique=True)
    descripcion_des = models.TextField(blank=True)
    porcentaje_des = models.DecimalField(max_digits=10, decimal_places=2)
    fecha_creacion_des = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modificacion_des = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.nombre_des

class Categoria(models.Model):
    nombre_cat = models.CharField(max_length=100, unique=True)
    descripcion_cat = models.TextField(blank=True)
    fecha_creacion_cat = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modificacion_cat = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.nombre_cat

class Material(models.Model):
    nombre_mat = models.CharField(max_length=100, unique=True)
    descripcion_mat = models.TextField(blank=True)
    fecha_creacion_mat = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modificacion_mat = models.DateTimeField(auto_now_add=True, null=True)
    marca = models.ForeignKey(Marca, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombre_mat

class Producto(models.Model):
    nombre = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField(blank=True)
    precio = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0), MaxValueValidator(10000)])
    existencias = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)])
    calificacion = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])
    fecha_creacion = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modificacion = models.DateTimeField(auto_now_add=True, null=True)
    foto = models.ImageField(upload_to="productos", null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    descuento = models.ForeignKey(Descuento, on_delete=models.CASCADE, null=True)
    material = models.ForeignKey(Material, on_delete=models.CASCADE, null=True)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.nombre


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    pago = models.BooleanField(default=False);

    def __str__(self):
        return str(self.id)
    
    @property
    def num_of_items(self):
        cartitems = self.cartitems.all()
        cantidad = sum([item.cantidad_item for item in cartitems])
        return cantidad
    @property
    def total_price(self):
        cartitems = self.cartitems.all()
        total = sum([item.price for item in cartitems])
        return total

class Item_Cart(models.Model):
    cantidad_item = models.IntegerField(default=0, null=True, blank=True);
    total_item = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    fecha_add_item = models.DateTimeField(auto_now_add=True, null=True)
    fecha_modify_item = models.DateTimeField(auto_now_add=True, null=True)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name='cartitems', null=True)
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, related_name='items')

    def __str__(self):
        return self.producto.nombre

    @property
    def price(self):
        nuevo_precio = self.producto.precio * self.cantidad_item
        return nuevo_precio

class MyFiles(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    file = models.FileField(null=True)
    
    def __str__(self):
        return str(self.file)

class Payment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=100)
    card = models.CharField(max_length=16)
    month = models.IntegerField()
    year = models.IntegerField()
    cvv = models.CharField(max_length=4)

