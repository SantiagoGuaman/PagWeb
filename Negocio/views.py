from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from django.contrib.auth import login, logout, authenticate
from django.db import IntegrityError
from .forms import *
from .models import *
import json
from django.urls import reverse
from django.core.files.storage import FileSystemStorage
from django.core.mail import EmailMessage
from django.template.loader import render_to_string
from django.conf import settings
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from .validators import *


def Home(request):
    return render(request, 'paginas/Home.html')


def signin(request):
    form = RegisterForm(request.POST)
    if form.is_valid():
        print('if valid form')
        username = form.cleaned_data.get('username')
        email = form.cleaned_data.get('email')
        password = form.cleaned_data.get('password')
        if request.POST['password1'] == request.POST['password2']:
            try:
                user = User.objects.create_user(username=username, email=email, password=password)
                user.save()
                login(request, user)
                return redirect('home')
            except IntegrityError:
                return render(request, 'Login.html', context, {'Error': 'El usuario ya ha sido registrado'})
        
        return render(request, 'Login/sign.html', {
        'form': LoginForm(), "Error": 'Las contraseñas no coinciden'
        })
       
    form = RegisterForm()
    
    context = {
        'form': form
    }
    return render(request, 'Login/sign.html', context)


def loginst(request):
    form = LoginForm(request.POST)
    if request.method == 'POST':
        user = authenticate(username=request.POST['username'], password=request.POST['password'])
        if user is None:
            return render(request, 'Login/log.html', {
                'form': LoginForm(), 'error': 'Contraseña o nombre de usuario no válido'
            })
        else:
            login(request, user)
            return redirect('home')
    context = {'form': form}
    return render(request, 'Login/log.html', context)    
    
def create_product(request):
    
    form = ProductForm()
    context = {'form': form}

    if request.method == 'POST':
        form = ProductForm(request.POST)
        if form.is_valid():
            
            new_product = form.save()
            new_product.user = request.user

            return redirect('products')
    return render(request, 'Products/producto.html', context)


def update_product(request, pk):
    product = Producto.objects.get(id=pk)
    form = ProductForm(instance=product)
    context = {'form': form, 'product': product}
    if request.method == 'POST':
        print('HERE')
        print(request.POST)
        form = ProductForm(request.POST, instance=product)
        if form.is_valid():
            form.save()
            return redirect(request.META.get('HTTP_REFERER'))
    print('NO IF')
    return render(request, 'Products/product_form.html', context)

def delete_product(request, pk):
    product = Producto.objects.get(id=pk)
    context = {'product': product}

    if request.method == 'POST':
        product.delete()
        return redirect(request.META.get('HTTP_REFERER'))
    return render(request, 'Products/delete_product.html', context)



def panel(request):
    return render(request, 'control_panel/panel.html')




def cart(request):
    cart = None
    cartitems = []
    if request.user.is_authenticated:
       cart, created = Cart.objects.get_or_create(user_id=request.user.id, pago=False)
       cartitems = cart.cartitems.all()

    context = {'cart': cart, 'items': cartitems}

    return render(request, 'mycart/cart.html', context)


def add_to_cart(request):
    data = json.loads(request.body)
    product_id = data["id"]
    
    if request.user.is_authenticated:
        cart, created = Cart.objects.get_or_create(user_id=request.user.id, pago=False)
        product = Producto.objects.get(id=product_id)
        cartitem, created = Item_Cart.objects.get_or_create(cart=cart, producto=product)
        cartitem.cantidad_item += 1
        cartitem.save()

    return JsonResponse(safe=False)

@csrf_exempt
def remove_from_cart(request):
    data = json.loads(request.body)
    product_id = data["id"]

    if request.user.is_authenticated:
        cart_p = Cart.objects.filter(user_id=request.user.id).first()
        if not cart_p:
            return JsonResponse({'message': 'Producto eliminado del carrito.'})
        item = Item_Cart.objects.get(cart=cart_p.id, producto=product_id)
        if item.cantidad_item > 1:
            item.cantidad_item -= 1
            item.total_item = item.producto.precio * item.cantidad_item
            item.save()
        else:
            item.delete()
        data = {
            'success': True
        }
    return JsonResponse(data)


def signout(request):
    logout(request)
    return redirect('home')

def contactus(request):
    return render(request, 'paginas/contact.html')

def about(request):
    return render(request, 'paginas/about.html')

def products(request):
    obj=Producto.objects.all()
    return render(request, 'paginas/products.html',{'obj': obj})

def quotes(request):
    form = MyFilesForm()
    if request.method == 'POST' and request.FILES['myfile']:
        form = MyFilesForm(request.POST)
        mfile = MyFiles.objects.get_or_create(user_id=request.user.id, file=request.FILES['myfile'])
        myfile = request.FILES['myfile']
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        upload_file_url = fs.url(filename)
        print(upload_file_url)
        return render(request, 'paginas/quotes.html', {'upload_file_url': upload_file_url})
    return render(request, 'paginas/quotes.html') 

def list_files(request):
    files = MyFiles.objects.all()
    return render(request, 'MyProjects/my_projects_list.html', {'files' : files})

def delete_file(request, pk):
    archivo = MyFiles.objects.get(id=pk)
    context = {'archivo': archivo}

    if request.method == 'POST':
        archivo.delete()
        return redirect(request.META.get('HTTP_REFERER'))
    return render(request, 'MyProjects/delete_file.html', context)

def contact(request):

    if request.method == 'POST':
        nombre = request.POST['nombre']
        apellido = request.POST['apellido']
        correo = request.POST['mail']
        mensaje = request.POST['mensaje']
        
        template = render_to_string('paginas/email_template.html', {
            'nombre': nombre,
            'apellido':apellido,
            'mensaje':mensaje
        })

        email = EmailMessage(nombre, 
            template, 
            settings.EMAIL_HOST_USER,
            ['santiagogcan@gmail.com']
        )

        email.fail_silently = False
        email.send()
        messages.success(request, 'Correo envíado')
        return redirect(request.META.get('HTTP_REFERER'))
    return redirect(request.path)


def payment(request):

    if request.method == 'POST':
        nombre = request.POST['nombre']
        card = request.POST['card']
        month = request.POST['month']
        year = request.POST['year']
        cvv = request.POST['cvv']
        return render(request, 'paginas/payment.html', {'completed' : 'Pago exitoso'})

    return render(request, 'paginas/payment.html', {'error' : 'El pago no pudo ser realizado'})