from django.forms import *
from django import forms
from .models import *
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User


class LoginForm(AuthenticationForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({
        'class':"form-control mt-2",
        'required':'',
        'name': 'username',
        'id': 'username',
        'type': 'text',
        'maxlength': '16',
        'placeholder': 'John Smith',
        'minlength': '3' 
        }) 
        self.fields['password'].widget.attrs.update({
            'class':'form-control',
            'required': '',
            'name': 'password',
            'id': 'password',
            'type': 'password',
            'placeholder': '●●●●●●●●●●●●●●●●',
            'minlength': '2',
            'maxlength': '16'
        })

    class Meta:
        model = User

class RegisterForm(UserCreationForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({
        'class':"form-control mt-2",
        'required':'',
        'name': 'username',
        'id': 'username',
        'type': 'text',
        'maxlength': '16',
        'placeholder': 'John Smith',
        'minlength': '4'
            })
        self.fields['email'].widget.attrs.update({
            'class':'form-control',
            'required': '',
            'name': 'email',
            'id': 'email',
            'type': 'email',
            'placeholder': 'example@gmail.com'
            })
        self.fields['password1'].widget.attrs.update({
            'class':'form-control',
            'required': '',
            'name': 'password1',
            'id': 'password1',
            'type': 'password',
            'placeholder': '●●●●●●●●●●●●●●●●',
            'minlength': '8',
            'maxlength': '16'
            })
        self.fields['password2'].widget.attrs.update({
            'class':'form-control',
            'required': '',
            'name': 'password2',
            'id': 'password2',
            'type': 'password',
            'placeholder': '●●●●●●●●●●●●●●●●',
            'minlength': '8',
            'maxlength': '16'
            })
        
    username = forms.CharField(max_length='20', label=False)
    email = forms.EmailField(max_length='100')

    class Meta:
        model = User
        fields = ['username', 'email','password1', 'password2']


class ProductForm(ModelForm):
    class Meta:
        model = Producto
        fields = ['nombre', 'descripcion', 'precio', 'existencias', 
                  'calificacion', 'foto', 'descuento', 'material', 'categoria']
        labels = {
            'nombre': 'Nombre',
            'descripcion': 'Descripción',
            'precio': 'Precio',
            'existencias': 'Existencias',
            'calificacion' : 'Calificación',
            'foto' : 'Foto',
            'descuento' : 'Descuento',
            'material' : 'Material',
            'categoria' : 'Categoría'
        }
        widgets = {
            'nombre': TextInput(attrs={'class': 'form-control', 'placeholder': 'Rueda 1:64', 'minlength': '2','maxlength': '50'}),
            'descripcion': Textarea(attrs={'class': 'form-control', 'placeholder': 'Nuevo producto!', 'minlength': '0','maxlength': '200'}),
            'precio': NumberInput(attrs={'class': 'form-control','min': '0','max': '1000'}),
            'existencias': NumberInput(attrs={'class': 'form-control','min': '0','max': '100'}),
            'calificacion': NumberInput(attrs={'class': 'form-control','min': '0','max': '5'}),
            'foto' : FileInput(attrs={'class': 'form-control'}),
            'descuento': Select(attrs={'class' : 'form-control'}),
            'material': Select(attrs={'class' : 'form-control'}),
            'categoria': Select(attrs={'class' : 'form-control'})
            }
        def validate(self):
            if self.precio == 50:
                self._errors['precio'] = self.error_class(['El precio no es válido'])
            return self._errors

class MarcaForm(ModelForm):
    class Meta:
        model = Marca
        fields = '__all__'

class DescuentoForm(ModelForm):
    class Meta:
        model = Descuento
        fields = '__all__'

class CategoriaForm(ModelForm):
    class Meta:
        model = Categoria
        fields = '__all__'

class MaterialForm(ModelForm):
    class Meta:
        model = Material
        fields = '__all__'

class ContactForm(forms.Form):
    nombre = forms.CharField(required=True, max_length=50)
    apellido = forms.CharField(required=True, max_length=50)
    correo = forms.EmailField()
    mensaje = forms.Textarea()

class PaymentForm(forms.Form):
    nombre = forms.CharField(required=True)
    card = forms.CharField(required=True)
    month = forms.IntegerField(required=True)
    year = forms.IntegerField(required=True)
    cvv = forms.CharField(required=True)


class MyFilesForm(ModelForm):
    class Meta:
        model = MyFiles
        fields = '__all__'

    