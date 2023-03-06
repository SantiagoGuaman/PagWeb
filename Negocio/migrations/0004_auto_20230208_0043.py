# Generated by Django 3.2.12 on 2023-02-08 00:43

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('Negocio', '0003_auto_20230208_0012'),
    ]

    operations = [
        migrations.CreateModel(
            name='Descuento',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre_des', models.CharField(max_length=100)),
                ('descripcion_des', models.TextField(blank=True)),
                ('porcentaje_des', models.DecimalField(decimal_places=2, max_digits=10)),
                ('fecha_creacion_des', models.DateTimeField(auto_now_add=True, null=True)),
                ('fecha_modificacion_des', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Item_Cart',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad_item', models.IntegerField(blank=True, null=True)),
                ('total_item', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('fecha_add_item', models.DateTimeField(auto_now_add=True, null=True)),
                ('fecha_modify_item', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Marca',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre_mar', models.CharField(max_length=100)),
                ('fecha_creacion_mar', models.DateTimeField(auto_now_add=True, null=True)),
                ('fecha_modificacion_mar', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Material',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre_mat', models.CharField(max_length=100)),
                ('descripcion_mat', models.TextField(blank=True)),
                ('fecha_creacion_mat', models.DateTimeField(auto_now_add=True, null=True)),
                ('fecha_modificacion_mat', models.DateTimeField(auto_now_add=True, null=True)),
                ('marca', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Negocio.marca')),
            ],
        ),
        migrations.AddField(
            model_name='producto',
            name='fecha_modificacion',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
        migrations.AlterField(
            model_name='producto',
            name='fecha_creacion',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
        migrations.DeleteModel(
            name='Cart',
        ),
        migrations.AddField(
            model_name='item_cart',
            name='producto',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Negocio.producto'),
        ),
        migrations.AddField(
            model_name='item_cart',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='producto',
            name='descuento',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='Negocio.descuento'),
        ),
        migrations.AddField(
            model_name='producto',
            name='material',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='Negocio.material'),
        ),
    ]