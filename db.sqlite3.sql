BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Negocio_cart" (
	"id"	integer NOT NULL,
	"pago"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Negocio_categoria" (
	"id"	integer NOT NULL,
	"descripcion_cat"	text NOT NULL,
	"fecha_creacion_cat"	datetime,
	"fecha_modificacion_cat"	datetime,
	"nombre_cat"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Negocio_descuento" (
	"id"	integer NOT NULL,
	"descripcion_des"	text NOT NULL,
	"porcentaje_des"	decimal NOT NULL,
	"fecha_creacion_des"	datetime,
	"fecha_modificacion_des"	datetime,
	"nombre_des"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Negocio_item_cart" (
	"id"	integer NOT NULL,
	"cantidad_item"	integer,
	"total_item"	decimal,
	"fecha_add_item"	datetime,
	"fecha_modify_item"	datetime,
	"cart_id"	bigint,
	"producto_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cart_id") REFERENCES "Negocio_cart"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("producto_id") REFERENCES "Negocio_producto"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Negocio_marca" (
	"id"	integer NOT NULL,
	"fecha_creacion_mar"	datetime,
	"fecha_modificacion_mar"	datetime,
	"nombre_mar"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Negocio_material" (
	"id"	integer NOT NULL,
	"descripcion_mat"	text NOT NULL,
	"fecha_creacion_mat"	datetime,
	"fecha_modificacion_mat"	datetime,
	"marca_id"	bigint NOT NULL,
	"nombre_mat"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("marca_id") REFERENCES "Negocio_marca"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Negocio_myfiles" (
	"id"	integer NOT NULL,
	"file"	varchar(100),
	"user_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Negocio_payment" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"card"	varchar(16) NOT NULL,
	"month"	integer NOT NULL,
	"year"	integer NOT NULL,
	"cvv"	varchar(4) NOT NULL,
	"user_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Negocio_producto" (
	"id"	integer NOT NULL,
	"descripcion"	text NOT NULL,
	"precio"	decimal NOT NULL,
	"existencias"	integer NOT NULL,
	"calificacion"	integer NOT NULL,
	"foto"	varchar(100),
	"fecha_creacion"	datetime,
	"user_id"	integer,
	"fecha_modificacion"	datetime,
	"descuento_id"	bigint,
	"material_id"	bigint,
	"categoria_id"	bigint,
	"nombre"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("descuento_id") REFERENCES "Negocio_descuento"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("material_id") REFERENCES "Negocio_material"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("categoria_id") REFERENCES "Negocio_categoria"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "admin_interface_theme" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL UNIQUE,
	"active"	bool NOT NULL,
	"title"	varchar(50) NOT NULL,
	"title_visible"	bool NOT NULL,
	"logo"	varchar(100) NOT NULL,
	"logo_visible"	bool NOT NULL,
	"css_header_background_color"	varchar(10) NOT NULL,
	"css_header_text_color"	varchar(10) NOT NULL,
	"css_header_link_color"	varchar(10) NOT NULL,
	"css_header_link_hover_color"	varchar(10) NOT NULL,
	"css_module_background_color"	varchar(10) NOT NULL,
	"css_module_text_color"	varchar(10) NOT NULL,
	"css_module_link_color"	varchar(10) NOT NULL,
	"css_module_link_hover_color"	varchar(10) NOT NULL,
	"css_module_rounded_corners"	bool NOT NULL,
	"css_generic_link_color"	varchar(10) NOT NULL,
	"css_generic_link_hover_color"	varchar(10) NOT NULL,
	"css_save_button_background_color"	varchar(10) NOT NULL,
	"css_save_button_background_hover_color"	varchar(10) NOT NULL,
	"css_save_button_text_color"	varchar(10) NOT NULL,
	"css_delete_button_background_color"	varchar(10) NOT NULL,
	"css_delete_button_background_hover_color"	varchar(10) NOT NULL,
	"css_delete_button_text_color"	varchar(10) NOT NULL,
	"list_filter_dropdown"	bool NOT NULL,
	"related_modal_active"	bool NOT NULL,
	"related_modal_background_color"	varchar(10) NOT NULL,
	"related_modal_rounded_corners"	bool NOT NULL,
	"logo_color"	varchar(10) NOT NULL,
	"title_color"	varchar(10) NOT NULL,
	"recent_actions_visible"	bool NOT NULL,
	"favicon"	varchar(100) NOT NULL,
	"related_modal_background_opacity"	varchar(5) NOT NULL,
	"env_name"	varchar(50) NOT NULL,
	"env_color"	varchar(10) NOT NULL,
	"env_visible_in_header"	bool NOT NULL,
	"env_visible_in_favicon"	bool NOT NULL,
	"related_modal_close_button_visible"	bool NOT NULL,
	"language_chooser_active"	bool NOT NULL,
	"language_chooser_display"	varchar(10) NOT NULL,
	"list_filter_sticky"	bool NOT NULL,
	"form_pagination_sticky"	bool NOT NULL,
	"form_submit_sticky"	bool NOT NULL,
	"css_module_background_selected_color"	varchar(10) NOT NULL,
	"css_module_link_selected_color"	varchar(10) NOT NULL,
	"logo_max_height"	smallint unsigned NOT NULL CHECK("logo_max_height" >= 0),
	"logo_max_width"	smallint unsigned NOT NULL CHECK("logo_max_width" >= 0),
	"foldable_apps"	bool NOT NULL,
	"language_chooser_control"	varchar(20) NOT NULL,
	"list_filter_highlight"	bool NOT NULL,
	"list_filter_removal_links"	bool NOT NULL,
	"show_fieldsets_as_tabs"	bool NOT NULL,
	"show_inlines_as_tabs"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "Negocio_cart" VALUES (1,0,14);
INSERT INTO "Negocio_cart" VALUES (2,0,13);
INSERT INTO "Negocio_cart" VALUES (3,0,18);
INSERT INTO "Negocio_cart" VALUES (4,0,17);
INSERT INTO "Negocio_categoria" VALUES (1,'Producto de grado experimental y funcional','2023-02-08 01:11:47.590502','2023-02-08 01:11:47.590562','Prototipo');
INSERT INTO "Negocio_categoria" VALUES (2,'Categoría enfocada a las herramientas','2023-03-05 00:10:46.554371','2023-03-05 00:10:46.554465','Tools');
INSERT INTO "Negocio_descuento" VALUES (1,'Nuevo descuento por apertura',0.1,'2023-02-08 00:52:48.733214','2023-02-08 00:52:48.733278','Black');
INSERT INTO "Negocio_item_cart" VALUES (33,2,NULL,'2023-02-28 04:22:03.083825','2023-02-28 04:22:03.083878',3,19);
INSERT INTO "Negocio_item_cart" VALUES (42,2,NULL,'2023-03-04 14:48:32.747060','2023-03-04 14:48:32.747175',1,7);
INSERT INTO "Negocio_item_cart" VALUES (43,1,10,'2023-03-04 14:48:36.106604','2023-03-04 14:48:36.106694',1,18);
INSERT INTO "Negocio_marca" VALUES (1,'2023-02-08 00:53:34.182371','2023-02-08 00:53:34.182438','Silycon MAX');
INSERT INTO "Negocio_marca" VALUES (2,'2023-03-05 00:11:24.152211','2023-03-05 00:11:24.152284','Acme');
INSERT INTO "Negocio_material" VALUES (1,'Material de alta densidad resistente al agua y a las altas temperaturas','2023-02-08 00:54:21.560460','2023-02-08 00:54:21.560526',1,'Nitrilito');
INSERT INTO "Negocio_material" VALUES (2,'Plástico de alta densidad','2023-03-05 00:11:54.144449','2023-03-05 00:11:54.144530',2,'Plástico A/B');
INSERT INTO "Negocio_myfiles" VALUES (12,'FavLOGO.png',14);
INSERT INTO "Negocio_myfiles" VALUES (13,'map.png',NULL);
INSERT INTO "Negocio_producto" VALUES (3,'New prototype of wheel in scale 1:64',0.1,100,0,'productos/product2.png','2023-02-08 00:57:45.276523',13,'2023-02-08 00:57:45.276582',1,1,1,'Proto-Wheels');
INSERT INTO "Negocio_producto" VALUES (7,'motor bike nitril 9-12',3,2,0,'productos/product2.png','2023-02-16 03:44:59.619273',13,'2023-02-16 03:44:59.619330',1,1,1,'Motorbike');
INSERT INTO "Negocio_producto" VALUES (14,'print',2,1,0,'','2023-02-21 04:06:48.223379',13,'2023-02-21 04:06:48.223474',1,1,1,'Shell');
INSERT INTO "Negocio_producto" VALUES (16,'Un lindo peluche',12,12,0,'','2023-02-23 05:51:52.042879',17,'2023-02-23 05:51:52.042956',1,1,1,'Stich');
INSERT INTO "Negocio_producto" VALUES (18,'New product test',10,4,0,'productos/product.png','2023-02-26 08:27:04.385473',14,'2023-02-26 08:27:04.385554',1,1,1,'Micro Jet');
INSERT INTO "Negocio_producto" VALUES (19,'Nuevo producto!',1000,2,0,'','2023-02-28 02:24:49.515293',13,'2023-02-28 02:24:49.515352',1,1,1,'NanoPrinter');
INSERT INTO "Negocio_producto" VALUES (20,'Pequeño',1,5,2,'','2023-02-28 02:34:24.986466',17,'2023-02-28 02:34:24.986602',1,1,1,'Peluche');
INSERT INTO "Negocio_producto" VALUES (21,'Nueva impresora',100,1,0,'','2023-03-05 16:06:24.304150',NULL,'2023-03-05 16:06:24.304298',1,2,2,'Printer');
INSERT INTO "admin_interface_theme" VALUES (1,'Django',1,'Administración de Django',0,'admin-interface/logo/logo.png',1,'#000000','#9D9D9D','#FFFFFF','#C9F0DD','#746F6F','#FFFFFF','#FFFFFF','#C9F0DD',1,'#0C3C26','#156641','#0C4B33','#0C3C26','#FFFFFF','#BA2121','#A41515','#FFFFFF',1,1,'#000000',1,'#FFFFFF','#F5DD5D',1,'admin-interface/favicon/FavLOGO.png','0.1','','#E74C3C',1,1,1,1,'code',1,0,1,'#FFFFCC','#FFFFFF',45,90,1,'default-select',1,0,0,0);
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_producto','Can add producto');
INSERT INTO "auth_permission" VALUES (26,7,'change_producto','Can change producto');
INSERT INTO "auth_permission" VALUES (27,7,'delete_producto','Can delete producto');
INSERT INTO "auth_permission" VALUES (28,7,'view_producto','Can view producto');
INSERT INTO "auth_permission" VALUES (29,8,'add_cart','Can add cart');
INSERT INTO "auth_permission" VALUES (30,8,'change_cart','Can change cart');
INSERT INTO "auth_permission" VALUES (31,8,'delete_cart','Can delete cart');
INSERT INTO "auth_permission" VALUES (32,8,'view_cart','Can view cart');
INSERT INTO "auth_permission" VALUES (33,9,'add_descuento','Can add descuento');
INSERT INTO "auth_permission" VALUES (34,9,'change_descuento','Can change descuento');
INSERT INTO "auth_permission" VALUES (35,9,'delete_descuento','Can delete descuento');
INSERT INTO "auth_permission" VALUES (36,9,'view_descuento','Can view descuento');
INSERT INTO "auth_permission" VALUES (37,10,'add_item_cart','Can add item_ cart');
INSERT INTO "auth_permission" VALUES (38,10,'change_item_cart','Can change item_ cart');
INSERT INTO "auth_permission" VALUES (39,10,'delete_item_cart','Can delete item_ cart');
INSERT INTO "auth_permission" VALUES (40,10,'view_item_cart','Can view item_ cart');
INSERT INTO "auth_permission" VALUES (41,11,'add_marca','Can add marca');
INSERT INTO "auth_permission" VALUES (42,11,'change_marca','Can change marca');
INSERT INTO "auth_permission" VALUES (43,11,'delete_marca','Can delete marca');
INSERT INTO "auth_permission" VALUES (44,11,'view_marca','Can view marca');
INSERT INTO "auth_permission" VALUES (45,12,'add_material','Can add material');
INSERT INTO "auth_permission" VALUES (46,12,'change_material','Can change material');
INSERT INTO "auth_permission" VALUES (47,12,'delete_material','Can delete material');
INSERT INTO "auth_permission" VALUES (48,12,'view_material','Can view material');
INSERT INTO "auth_permission" VALUES (49,13,'add_categoria','Can add categoria');
INSERT INTO "auth_permission" VALUES (50,13,'change_categoria','Can change categoria');
INSERT INTO "auth_permission" VALUES (51,13,'delete_categoria','Can delete categoria');
INSERT INTO "auth_permission" VALUES (52,13,'view_categoria','Can view categoria');
INSERT INTO "auth_permission" VALUES (53,14,'add_myfiles','Can add my files');
INSERT INTO "auth_permission" VALUES (54,14,'change_myfiles','Can change my files');
INSERT INTO "auth_permission" VALUES (55,14,'delete_myfiles','Can delete my files');
INSERT INTO "auth_permission" VALUES (56,14,'view_myfiles','Can view my files');
INSERT INTO "auth_permission" VALUES (57,15,'add_theme','Can add Theme');
INSERT INTO "auth_permission" VALUES (58,15,'change_theme','Can change Theme');
INSERT INTO "auth_permission" VALUES (59,15,'delete_theme','Can delete Theme');
INSERT INTO "auth_permission" VALUES (60,15,'view_theme','Can view Theme');
INSERT INTO "auth_permission" VALUES (61,16,'add_payment','Can add payment');
INSERT INTO "auth_permission" VALUES (62,16,'change_payment','Can change payment');
INSERT INTO "auth_permission" VALUES (63,16,'delete_payment','Can delete payment');
INSERT INTO "auth_permission" VALUES (64,16,'view_payment','Can view payment');
INSERT INTO "auth_user" VALUES (13,'pbkdf2_sha256$260000$td4xRXL1dIdIyO4Td7znj2$tElbB46l7Y1GYO2e3StNL2HbnZGXKKKS4FeXCUEu0lA=','2023-03-05 22:39:24.184199',1,'Sao','','santiagogcan@gmail.com',1,1,'2023-02-07 22:09:01.127146','');
INSERT INTO "auth_user" VALUES (14,'pbkdf2_sha256$260000$gmbzH2NGZhGXYQoKd1aAYj$juDVd74CKFPKzeYGsFWyP53XYsn1Rbfc8gUK4B0eZ7g=','2023-03-05 22:17:23.775249',0,'mario','','',0,1,'2023-02-09 21:26:50.342532','');
INSERT INTO "auth_user" VALUES (15,'pbkdf2_sha256$260000$cbkjCkcKkpYA2vNhmVjOph$zKtuRDZ+kHTonT/5KO2KIzwVlWNR625CmcFAdSrtzkQ=','2023-02-14 16:31:56.548264',1,'LarryS2','','',1,1,'2023-02-14 16:31:11','');
INSERT INTO "auth_user" VALUES (16,'pbkdf2_sha256$260000$8g7by9QveQUzONyVHqinE9$U+tTdyEkmqXGoigcDyRCOX82FFJZHbVXIMGeod/mhe4=','2023-02-23 05:39:48.289949',0,'PepeB','','',0,1,'2023-02-23 05:39:47.414725','');
INSERT INTO "auth_user" VALUES (17,'pbkdf2_sha256$260000$jjFUlXOn7e0XYKzSoxGpnE$4BitJij2Xd4nUfw2HZXYrSrZS/ecCO0z0Eg0MktEVDU=','2023-02-28 03:06:29.047058',1,'Larry_S2','','pepebotellas079@gmail.com',1,1,'2023-02-23 05:49:57.195910','');
INSERT INTO "auth_user" VALUES (18,'pbkdf2_sha256$260000$nye0Fcz6HgVKqkhL0t8vCM$ygAluI6rVWtuoFlzWHKo1uzHG8zveOTOR4bhQRPZcdU=','2023-02-28 03:07:18.937190',0,'Andres','','',0,1,'2023-02-27 22:17:53.168161','');
INSERT INTO "auth_user" VALUES (19,'pbkdf2_sha256$260000$t2nWq2ilTQrYFnA1U1ATcW$vmpxgMlr+jV9VTQ8z/kI6S71B141ng3eLxdbRaeP++k=',NULL,0,'Santiago','','ehosico@gmail.com',0,1,'2023-03-04 23:18:04.067168','');
INSERT INTO "auth_user" VALUES (20,'pbkdf2_sha256$260000$c2FP0a4eQmpPBOOWyazZue$v+0u+eLCSti6mt5QmBJTdWDRYvsXey58tfTE6/Zi/hk=',NULL,0,'Maria','','maria12@gmail.com',0,1,'2023-03-04 23:19:26.013609','');
INSERT INTO "auth_user" VALUES (21,'pbkdf2_sha256$260000$QBJ6kpWeZ1PHxOavqqoUf5$Yr1mcrH3ayqlJvLm3Cjh3vWuxf7DOS+2Jh/oJCu7j3U=',NULL,0,'John','','johnny@gmail.com',0,1,'2023-03-04 23:22:02.186651','');
INSERT INTO "auth_user" VALUES (22,'pbkdf2_sha256$260000$igMIhJAX1Vl5nwvKMpJayK$P8auOZwuygS6OPS3h1A+Nh6o+BU0wSz5ul8YwDPpM7s=',NULL,0,'Martina','','bensuper2012@gmail.com',0,1,'2023-03-04 23:24:41.923295','');
INSERT INTO "auth_user" VALUES (23,'pbkdf2_sha256$260000$YlCDGRMz7yFnffqHwQO7DV$MO2HMu5aOhYoQxbcOeMU4dPAKWuuoSzn4Mk5lrFBkR0=',NULL,0,'Santiago12','','johnny112@gmail.com',0,1,'2023-03-04 23:26:56.724060','');
INSERT INTO "auth_user" VALUES (24,'!1t88Ac3f8M9CN83lJ17Xeh7GNAjiFkMOibvD7Pzr','2023-03-05 00:22:32.247564',0,'Salomé','','salo45@gmail.com',0,1,'2023-03-05 00:22:32.119106','');
INSERT INTO "django_admin_log" VALUES (3,'18','Producto object (18)',3,'',7,13,'2023-02-07 22:10:15.318906');
INSERT INTO "django_admin_log" VALUES (4,'17','Producto object (17)',3,'',7,13,'2023-02-07 22:10:35.745073');
INSERT INTO "django_admin_log" VALUES (5,'16','Producto object (16)',3,'',7,13,'2023-02-07 22:10:40.124080');
INSERT INTO "django_admin_log" VALUES (6,'15','Producto object (15)',3,'',7,13,'2023-02-07 22:10:45.073556');
INSERT INTO "django_admin_log" VALUES (7,'14','Producto object (14)',3,'',7,13,'2023-02-07 22:10:49.320827');
INSERT INTO "django_admin_log" VALUES (8,'13','Producto object (13)',3,'',7,13,'2023-02-07 22:10:53.430028');
INSERT INTO "django_admin_log" VALUES (9,'12','Producto object (12)',3,'',7,13,'2023-02-07 22:10:58.197789');
INSERT INTO "django_admin_log" VALUES (10,'11','Producto object (11)',3,'',7,13,'2023-02-07 22:11:02.384869');
INSERT INTO "django_admin_log" VALUES (11,'10','Producto object (10)',3,'',7,13,'2023-02-07 22:11:06.843920');
INSERT INTO "django_admin_log" VALUES (12,'9','Producto object (9)',3,'',7,13,'2023-02-07 22:11:13.208168');
INSERT INTO "django_admin_log" VALUES (13,'1','Producto object (1)',2,'[]',7,13,'2023-02-07 22:11:27.664163');
INSERT INTO "django_admin_log" VALUES (14,'8','Producto object (8)',3,'',7,13,'2023-02-07 22:11:44.028352');
INSERT INTO "django_admin_log" VALUES (15,'7','Producto object (7)',3,'',7,13,'2023-02-07 22:11:48.512668');
INSERT INTO "django_admin_log" VALUES (16,'6','Producto object (6)',3,'',7,13,'2023-02-07 22:11:53.815799');
INSERT INTO "django_admin_log" VALUES (17,'5','Producto object (5)',3,'',7,13,'2023-02-07 22:11:58.655563');
INSERT INTO "django_admin_log" VALUES (18,'4','Producto object (4)',3,'',7,13,'2023-02-07 22:12:03.211990');
INSERT INTO "django_admin_log" VALUES (19,'3','Producto object (3)',3,'',7,13,'2023-02-07 22:12:08.101962');
INSERT INTO "django_admin_log" VALUES (20,'2','Producto object (2)',3,'',7,13,'2023-02-07 22:12:13.758191');
INSERT INTO "django_admin_log" VALUES (21,'2','ale',3,'',4,13,'2023-02-07 22:13:14.516804');
INSERT INTO "django_admin_log" VALUES (22,'4','alejandra',3,'',4,13,'2023-02-07 22:13:14.528062');
INSERT INTO "django_admin_log" VALUES (23,'12','beni',3,'',4,13,'2023-02-07 22:13:14.540026');
INSERT INTO "django_admin_log" VALUES (24,'5','camp',3,'',4,13,'2023-02-07 22:13:14.550920');
INSERT INTO "django_admin_log" VALUES (25,'3','maria',3,'',4,13,'2023-02-07 22:13:14.558218');
INSERT INTO "django_admin_log" VALUES (26,'7','mario',3,'',4,13,'2023-02-07 22:13:14.565547');
INSERT INTO "django_admin_log" VALUES (27,'11','mario1',3,'',4,13,'2023-02-07 22:13:14.572222');
INSERT INTO "django_admin_log" VALUES (28,'10','mario12',3,'',4,13,'2023-02-07 22:13:14.598013');
INSERT INTO "django_admin_log" VALUES (29,'6','mia',3,'',4,13,'2023-02-07 22:13:14.605812');
INSERT INTO "django_admin_log" VALUES (30,'1','ryan',3,'',4,13,'2023-02-07 22:13:14.614772');
INSERT INTO "django_admin_log" VALUES (31,'8','Santiago',3,'',4,13,'2023-02-07 22:13:40.003011');
INSERT INTO "django_admin_log" VALUES (32,'9','admin',3,'',4,13,'2023-02-07 22:13:40.014160');
INSERT INTO "django_admin_log" VALUES (33,'2','Producto object (2)',1,'[{"added": {}}]',7,13,'2023-02-07 23:05:05.500649');
INSERT INTO "django_admin_log" VALUES (34,'1','Descuento object (1)',1,'[{"added": {}}]',9,13,'2023-02-08 00:52:48.734913');
INSERT INTO "django_admin_log" VALUES (35,'1','Marca object (1)',1,'[{"added": {}}]',11,13,'2023-02-08 00:53:34.184329');
INSERT INTO "django_admin_log" VALUES (36,'1','Material object (1)',1,'[{"added": {}}]',12,13,'2023-02-08 00:54:21.562478');
INSERT INTO "django_admin_log" VALUES (37,'3','Producto object (3)',1,'[{"added": {}}]',7,13,'2023-02-08 00:57:45.321777');
INSERT INTO "django_admin_log" VALUES (38,'1','Categoria object (1)',1,'[{"added": {}}]',13,13,'2023-02-08 01:11:47.592363');
INSERT INTO "django_admin_log" VALUES (39,'3','Producto object (3)',2,'[{"changed": {"fields": ["Categoria"]}}]',7,13,'2023-02-08 01:13:18.145972');
INSERT INTO "django_admin_log" VALUES (40,'15','LarryS2',1,'[{"added": {}}]',4,13,'2023-02-14 16:31:12.191000');
INSERT INTO "django_admin_log" VALUES (41,'15','LarryS2',2,'[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,13,'2023-02-14 16:31:24.939327');
INSERT INTO "django_admin_log" VALUES (42,'6','Printer',1,'[{"added": {}}]',7,13,'2023-02-16 03:43:36.065713');
INSERT INTO "django_admin_log" VALUES (43,'7','Motorbike',1,'[{"added": {}}]',7,13,'2023-02-16 03:44:59.794216');
INSERT INTO "django_admin_log" VALUES (44,'d7a9a3d8-4312-4af1-9fb0-0a413255d4fa','d7a9a3d8-4312-4af1-9fb0-0a413255d4fa',1,'[{"added": {}}]',8,13,'2023-02-21 01:01:14.168746');
INSERT INTO "django_admin_log" VALUES (45,'1','Libros',1,'[{"added": {}}]',10,13,'2023-02-21 01:01:43.863865');
INSERT INTO "django_admin_log" VALUES (46,'2','Proto-Wheel',1,'[{"added": {}}]',10,13,'2023-02-21 01:02:45.342119');
INSERT INTO "django_admin_log" VALUES (47,'2','Libros',2,'[{"changed": {"fields": ["Foto"]}}]',7,13,'2023-02-21 04:06:07.000729');
INSERT INTO "django_admin_log" VALUES (48,'1','Django',2,'[{"changed": {"fields": ["Logo", "Visible", "Background color", "Background color"]}}]',15,13,'2023-02-21 18:35:19.053831');
INSERT INTO "django_admin_log" VALUES (49,'1','Django',2,'[{"changed": {"fields": ["Max width", "Max height"]}}]',15,13,'2023-02-21 18:38:19.644808');
INSERT INTO "django_admin_log" VALUES (50,'1','Django',2,'[{"changed": {"fields": ["Max height", "Text color", "Background opacity", "Sticky submit"]}}]',15,13,'2023-02-21 18:48:49.160222');
INSERT INTO "django_admin_log" VALUES (51,'1','Django',2,'[{"changed": {"fields": ["Max width"]}}]',15,13,'2023-02-21 18:52:42.138514');
INSERT INTO "django_admin_log" VALUES (52,'3','Motor',1,'[{"added": {}}]',10,13,'2023-02-26 13:06:42.350821');
INSERT INTO "django_admin_log" VALUES (53,'18','Micro Jet',2,'[{"changed": {"fields": ["Foto"]}}]',7,13,'2023-02-26 15:47:23.294914');
INSERT INTO "django_admin_log" VALUES (54,'3','Proto-Wheel',2,'[{"changed": {"fields": ["Foto"]}}]',7,13,'2023-02-26 15:48:25.543051');
INSERT INTO "django_admin_log" VALUES (55,'17','Peluche',3,'',10,17,'2023-02-28 03:06:59.102370');
INSERT INTO "django_admin_log" VALUES (56,'16','Printer',3,'',10,17,'2023-02-28 03:06:59.114079');
INSERT INTO "django_admin_log" VALUES (57,'15','prueba',3,'',10,17,'2023-02-28 03:06:59.121147');
INSERT INTO "django_admin_log" VALUES (58,'14','Stich',3,'',10,17,'2023-02-28 03:06:59.127187');
INSERT INTO "django_admin_log" VALUES (59,'13','Stich',3,'',10,17,'2023-02-28 03:06:59.133657');
INSERT INTO "django_admin_log" VALUES (60,'12','sad',3,'',10,17,'2023-02-28 03:06:59.140153');
INSERT INTO "django_admin_log" VALUES (61,'11','casa',3,'',10,17,'2023-02-28 03:06:59.205216');
INSERT INTO "django_admin_log" VALUES (62,'10','Motor',3,'',10,17,'2023-02-28 03:06:59.261841');
INSERT INTO "django_admin_log" VALUES (63,'9','asdas',3,'',10,17,'2023-02-28 03:06:59.309547');
INSERT INTO "django_admin_log" VALUES (64,'8','Micro Jet',3,'',10,17,'2023-02-28 03:06:59.351650');
INSERT INTO "django_admin_log" VALUES (65,'7','asdas',3,'',10,17,'2023-02-28 03:06:59.398487');
INSERT INTO "django_admin_log" VALUES (66,'6','Micro Jet',3,'',10,17,'2023-02-28 03:06:59.465249');
INSERT INTO "django_admin_log" VALUES (67,'5','sad',3,'',10,17,'2023-02-28 03:06:59.503773');
INSERT INTO "django_admin_log" VALUES (68,'4','Motorbike',3,'',10,17,'2023-02-28 03:06:59.553177');
INSERT INTO "django_admin_log" VALUES (69,'3','Printer',3,'',10,17,'2023-02-28 03:06:59.565090');
INSERT INTO "django_admin_log" VALUES (70,'2','Motor',3,'',10,17,'2023-02-28 03:06:59.576503');
INSERT INTO "django_admin_log" VALUES (71,'1','Proto-Wheel',3,'',10,17,'2023-02-28 03:06:59.589458');
INSERT INTO "django_admin_log" VALUES (72,'1','Django',2,'[{"changed": {"fields": ["Favicon"]}}]',15,13,'2023-03-05 00:09:32.107105');
INSERT INTO "django_admin_log" VALUES (73,'1','Django',2,'[]',15,13,'2023-03-05 00:10:06.659607');
INSERT INTO "django_admin_log" VALUES (74,'2','Tools',1,'[{"added": {}}]',13,13,'2023-03-05 00:10:46.556251');
INSERT INTO "django_admin_log" VALUES (75,'2','Acme',1,'[{"added": {}}]',11,13,'2023-03-05 00:11:24.154204');
INSERT INTO "django_admin_log" VALUES (76,'2','Plástico A/B',1,'[{"added": {}}]',12,13,'2023-03-05 00:11:54.146496');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'Negocio','producto');
INSERT INTO "django_content_type" VALUES (8,'Negocio','cart');
INSERT INTO "django_content_type" VALUES (9,'Negocio','descuento');
INSERT INTO "django_content_type" VALUES (10,'Negocio','item_cart');
INSERT INTO "django_content_type" VALUES (11,'Negocio','marca');
INSERT INTO "django_content_type" VALUES (12,'Negocio','material');
INSERT INTO "django_content_type" VALUES (13,'Negocio','categoria');
INSERT INTO "django_content_type" VALUES (14,'Negocio','myfiles');
INSERT INTO "django_content_type" VALUES (15,'admin_interface','theme');
INSERT INTO "django_content_type" VALUES (16,'Negocio','payment');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-12-29 04:24:22.594309');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2022-12-29 04:24:22.723134');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2022-12-29 04:24:22.769495');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2022-12-29 04:24:22.811205');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2022-12-29 04:24:22.866382');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2022-12-29 04:24:22.924830');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2022-12-29 04:24:22.982897');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2022-12-29 04:24:23.017017');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2022-12-29 04:24:23.047207');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2022-12-29 04:24:23.073589');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2022-12-29 04:24:23.113933');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2022-12-29 04:24:23.142443');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2022-12-29 04:24:23.189422');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2022-12-29 04:24:23.238328');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2022-12-29 04:24:23.291493');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2022-12-29 04:24:23.317745');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2022-12-29 04:24:23.382500');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2022-12-29 04:24:23.431663');
INSERT INTO "django_migrations" VALUES (19,'Negocio','0001_initial','2022-12-31 00:12:36.399258');
INSERT INTO "django_migrations" VALUES (20,'Negocio','0002_producto_foto','2023-02-07 23:03:43.426649');
INSERT INTO "django_migrations" VALUES (21,'Negocio','0003_auto_20230208_0012','2023-02-08 00:12:37.621981');
INSERT INTO "django_migrations" VALUES (22,'Negocio','0004_auto_20230208_0043','2023-02-08 00:43:40.628239');
INSERT INTO "django_migrations" VALUES (23,'Negocio','0005_categoria','2023-02-08 01:10:58.672509');
INSERT INTO "django_migrations" VALUES (24,'Negocio','0006_producto_categoria','2023-02-08 01:13:01.725613');
INSERT INTO "django_migrations" VALUES (25,'Negocio','0007_auto_20230211_0357','2023-02-11 03:58:26.577681');
INSERT INTO "django_migrations" VALUES (26,'Negocio','0008_auto_20230211_1122','2023-02-11 11:24:15.322066');
INSERT INTO "django_migrations" VALUES (27,'Negocio','0009_myfiles','2023-02-11 15:26:11.883928');
INSERT INTO "django_migrations" VALUES (28,'admin_interface','0001_initial','2023-02-21 18:32:26.504754');
INSERT INTO "django_migrations" VALUES (29,'admin_interface','0002_add_related_modal','2023-02-21 18:32:26.902174');
INSERT INTO "django_migrations" VALUES (30,'admin_interface','0003_add_logo_color','2023-02-21 18:32:27.017751');
INSERT INTO "django_migrations" VALUES (31,'admin_interface','0004_rename_title_color','2023-02-21 18:32:27.057024');
INSERT INTO "django_migrations" VALUES (32,'admin_interface','0005_add_recent_actions_visible','2023-02-21 18:32:27.100457');
INSERT INTO "django_migrations" VALUES (33,'admin_interface','0006_bytes_to_str','2023-02-21 18:32:27.759455');
INSERT INTO "django_migrations" VALUES (34,'admin_interface','0007_add_favicon','2023-02-21 18:32:27.850178');
INSERT INTO "django_migrations" VALUES (35,'admin_interface','0008_change_related_modal_background_opacity_type','2023-02-21 18:32:27.917201');
INSERT INTO "django_migrations" VALUES (36,'admin_interface','0009_add_enviroment','2023-02-21 18:32:28.016170');
INSERT INTO "django_migrations" VALUES (37,'admin_interface','0010_add_localization','2023-02-21 18:32:28.104216');
INSERT INTO "django_migrations" VALUES (38,'admin_interface','0011_add_environment_options','2023-02-21 18:32:28.300779');
INSERT INTO "django_migrations" VALUES (39,'admin_interface','0012_update_verbose_names','2023-02-21 18:32:28.340171');
INSERT INTO "django_migrations" VALUES (40,'admin_interface','0013_add_related_modal_close_button','2023-02-21 18:32:28.400307');
INSERT INTO "django_migrations" VALUES (41,'admin_interface','0014_name_unique','2023-02-21 18:32:28.448341');
INSERT INTO "django_migrations" VALUES (42,'admin_interface','0015_add_language_chooser_active','2023-02-21 18:32:28.540499');
INSERT INTO "django_migrations" VALUES (43,'admin_interface','0016_add_language_chooser_display','2023-02-21 18:32:28.594393');
INSERT INTO "django_migrations" VALUES (44,'admin_interface','0017_change_list_filter_dropdown','2023-02-21 18:32:28.633378');
INSERT INTO "django_migrations" VALUES (45,'admin_interface','0018_theme_list_filter_sticky','2023-02-21 18:32:28.675602');
INSERT INTO "django_migrations" VALUES (46,'admin_interface','0019_add_form_sticky','2023-02-21 18:32:28.784655');
INSERT INTO "django_migrations" VALUES (47,'admin_interface','0020_module_selected_colors','2023-02-21 18:32:28.948872');
INSERT INTO "django_migrations" VALUES (48,'admin_interface','0021_file_extension_validator','2023-02-21 18:32:28.994942');
INSERT INTO "django_migrations" VALUES (49,'admin_interface','0022_add_logo_max_width_and_height','2023-02-21 18:32:29.080767');
INSERT INTO "django_migrations" VALUES (50,'admin_interface','0023_theme_foldable_apps','2023-02-21 18:32:29.143957');
INSERT INTO "django_migrations" VALUES (51,'admin_interface','0024_remove_theme_css','2023-02-21 18:32:29.198770');
INSERT INTO "django_migrations" VALUES (52,'admin_interface','0025_theme_language_chooser_control','2023-02-21 18:32:29.246975');
INSERT INTO "django_migrations" VALUES (53,'admin_interface','0026_theme_list_filter_highlight','2023-02-21 18:32:29.311410');
INSERT INTO "django_migrations" VALUES (54,'admin_interface','0027_theme_list_filter_removal_links','2023-02-21 18:32:29.367057');
INSERT INTO "django_migrations" VALUES (55,'admin_interface','0028_theme_show_fieldsets_as_tabs_and_more','2023-02-21 18:32:29.458592');
INSERT INTO "django_migrations" VALUES (56,'Negocio','0010_auto_20230226_1442','2023-02-26 14:49:38.057485');
INSERT INTO "django_migrations" VALUES (57,'Negocio','0011_auto_20230226_1444','2023-02-26 14:49:38.178886');
INSERT INTO "django_migrations" VALUES (58,'Negocio','0012_cart_item_cart','2023-02-26 14:50:18.134565');
INSERT INTO "django_migrations" VALUES (59,'Negocio','0013_auto_20230226_1525','2023-02-26 15:25:51.815733');
INSERT INTO "django_migrations" VALUES (60,'Negocio','0014_auto_20230304_1955','2023-03-04 19:56:10.222302');
INSERT INTO "django_session" VALUES ('kadv35bgzcnmn320ipai6liajiqu0mb0','.eJxVjDsOwjAQBe_iGln-xZtQ0ucM0a53gwPIlvKpEHcnkVJA-2bmvdWA25qHbZF5mFhdVaMuvxtheko5AD-w3KtOtazzRPpQ9EkX3VeW1-10_w4yLnmvyckYaITWeZuiQ8Y2kOXI0SUCCGC6mNg6BNl556AJ1nsAI62QMaP6fAHtAzef:1pAktN:hbL2oQj8hr-56ymef4XeXuyiwaA1cMf5CintBNF7ilo','2023-01-12 04:51:45.243468');
INSERT INTO "django_session" VALUES ('f3yuztpowkqn7h6k9mbp95gfbsjwiuq2','.eJxVjEEOwiAQRe_C2pChQJlx6d4zEGAGWzVtUtqV8e7apAvd_vfef6mYtnWIW5MljqzOqlen3y2n8pBpB3xP023WZZ7WZcx6V_RBm77OLM_L4f4dDKkN3xo67oAM5x7YG0JEKdl6ttQ7kC4VMhisCSFUFELxDLU6dFAseahevT_EVzcB:1pAkui:RPFwx3vl_Oj_e4pd5Gr9k28hgh1kxs1GdnBOL7jjSzk','2023-01-12 04:53:08.844258');
INSERT INTO "django_session" VALUES ('igxx1plltagrewc5idjnkk0yb9c5y9o5','.eJxVjDsOwjAQBe_iGln-xg4lfc5g7XoXHEC2FCcV4u4QKQW0b2beSyTY1pK2zkuaSZxFFKffDSE_uO6A7lBvTeZW12VGuSvyoF1Ojfh5Ody_gwK9fGsDqICdc5aV8Y5iIICsdSBvgwX0XrO2IeLg_ajCAApVHLMxGK1iuIr3B9c8N1s:1pBPSy:O7n2mpsoGzU50vUTgrZdEzTYpsl0P6QqlvvS2e91Cd8','2023-01-14 00:11:12.262303');
INSERT INTO "django_session" VALUES ('ggv80qi80rbwrdp3fbbpnhm4obqldu8v','.eJxVjMsOwiAQRf-FtSE8hlJcuvcbCMwwUjU0Ke3K-O_apAvd3nPOfYmYtrXGrZclTiTOQitx-h1zwkdpO6F7ardZ4tzWZcpyV-RBu7zOVJ6Xw_07qKnXb22GjAP6EAiBE2jDDkZgq8Anzs4ppRlK0B4skR_ZkzXOmqIwsDUcxPsD_qk3sQ:1pIftf:qZ5rJq3yAhymKxxL1fO6cMnPrCrHDt8q9kO7Hp2TsVs','2023-02-03 01:08:47.014085');
INSERT INTO "django_session" VALUES ('e0nssrn83j5l8wqumo2get1ekqwnn7y4','.eJxVjMsOwiAQRf-FtSG8KS7d-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MykYaffMUF-UNsJ3qHdOs-9rcuc-K7wgw5-7UjPy-H-HVQY9VtbGUQBk0UgAMwIAn026I1UxiftrTWCEk6BtNNIxUGZXEC0RUqVkmLvDyCpOMA:1pQq8A:uNV6MvSRdt_bm9hEoO_H1OzH5PRGYfUPSRzMSXFBAeU','2023-02-25 13:41:30.080370');
INSERT INTO "django_session" VALUES ('myz0c133zbgjhq33hohq3xims2bmfpso','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pRbN1:xCZuc771IcEh6V6udqGbvYsjOIu5hl9U3VkTRSeH-4s','2023-02-27 16:07:59.391241');
INSERT INTO "django_session" VALUES ('24xck3m8q8i0g928mmecqmv48hesv83e','.eJxVjMsOwiAQRf-FtSG8KS7d-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MykYaffMUF-UNsJ3qHdOs-9rcuc-K7wgw5-7UjPy-H-HVQY9VtbGUQBk0UgAMwIAn026I1UxiftrTWCEk6BtNNIxUGZXEC0RUqVkmLvDyCpOMA:1pRxsQ:fHZz3s0gz_nabH7r68_5IGg-kzigLdnwXwU9bAjdEJE','2023-02-28 16:09:54.135416');
INSERT INTO "django_session" VALUES ('7q2wpxzy5b4tt83wxgkux6jf54ep4jtc','.eJxVjEEOwiAQRe_C2pCZAVrq0r1nIAOMUjU0Ke3KeHfbpAvdvvf-f6vA61LC2mQOY1ZnhU6dfmHk9JS6m_zgep90muoyj1HviT5s09cpy-tytH8HhVvZ1h7JIgAlQJuNJDcktr4DIha5GSAR6g07hhQdoufBbLiPhB2TQFafL-iHN6M:1pRyDk:3uKsCtMC1kZIHifp_2ZzGLAapV81rZO4DLUgUboJpgo','2023-02-28 16:31:56.558227');
INSERT INTO "django_session" VALUES ('67pt0yzbkc71267w6vu10yu7nzmungcw','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pRynH:jJIOTVKhzJqkCm09mR5zDUR2DWXSzrZTSwcLESrksDM','2023-02-28 17:08:39.931304');
INSERT INTO "django_session" VALUES ('joz0sfj5i5zy8qzq8cqmwvh3q119ohmv','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pRzCY:ybgAUtC5lI5FcyyvBsxC0hLipJt_v4wdynohX2VnF68','2023-02-28 17:34:46.299763');
INSERT INTO "django_session" VALUES ('14k6wqxsc3nt8rrw8xj25pvbea9f3vgf','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pSBcE:x1fnL5IuuFB-lq0LDAhrF6GhZmvIIA2ptrEQn7fO8BQ','2023-03-01 06:50:06.475201');
INSERT INTO "django_session" VALUES ('5eq8paew0asm30fnyr9lc9416vl8gfpa','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pSUXv:YtIzoFRkRTWLzMaQbDxfedTzMuHhXTghBQRsL3ZH0e4','2023-03-02 03:02:55.649058');
INSERT INTO "django_session" VALUES ('tukbxfo06pegkviulle5u0zagxdtblfw','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pSruY:7v9uCsuSFH4_LMz3xrco4HvjVZc_oO_DVxz1ZbcKe6Y','2023-03-03 03:59:50.225488');
INSERT INTO "django_session" VALUES ('bbo0bkpkb2v2obtn9hy2bbn13trm4jkf','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pTn6T:7eLSA2FezYh3ysbrqLU4JY8ZfQGtJP0YPjWuOXceIVc','2023-03-05 17:03:57.188293');
INSERT INTO "django_session" VALUES ('bnm97q9uw8pizlqd9lp8ye296l9mdpj8','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pV4F2:c6Nej2BFJrOt4TC0g9d2IC5syLGZQM1mY4pf_D5Lfoc','2023-03-09 05:34:04.967834');
INSERT INTO "django_session" VALUES ('x1p2vvgne9osr9lb5lbm8cvh6w8rwxc2','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pW9hk:vE8r8UUJM42HNWpa1mxmqkJyNZi0WOc241rhSAOGFok','2023-03-12 05:36:12.999587');
INSERT INTO "django_session" VALUES ('ewlf60ho0g913uy0gdydbtbf2vn9f4k6','.eJxVjMsOwiAQRf-FtSG8KS7d-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MykYaffMUF-UNsJ3qHdOs-9rcuc-K7wgw5-7UjPy-H-HVQY9VtbGUQBk0UgAMwIAn026I1UxiftrTWCEk6BtNNIxUGZXEC0RUqVkmLvDyCpOMA:1pWfNK:yWVJnn42C5GG3ncnHutTYrvistffOOWBad7mIP8S8pg','2023-03-13 15:25:14.524228');
INSERT INTO "django_session" VALUES ('ri4t3795qziussrdt5qatn120xe8d9ds','.eJxVjDsOwjAQBe_iGln-rH-U9JzBWttrHECOFCcV4u4QKQW0b2bei0Xc1ha3QUucCjsz6dnpd0yYH9R3Uu7YbzPPc1-XKfFd4Qcd_DoXel4O9--g4WjfGtCAIJeddspaUFRTQC21Ut5bI0FDsQJsdinVQEYZJ52lFGTGSoIMe38A3VI3UQ:1pWqKk:k0Ic_agOTwusuZIa-ajNGjSwKboQN5FTqsnGrSvVQp8','2023-03-14 03:07:18.943776');
INSERT INTO "django_session" VALUES ('lw8tjjjmtkxp25b8puplgcb99sba8zkf','e30:1pYbCV:rDy1YC_4U6RK2OGWAkuSCvYCJdgIsW9xeXsH66do5rQ','2023-03-18 23:22:03.156461');
INSERT INTO "django_session" VALUES ('sbv3yhc8wqnbwvhko5gy286clbasfneq','e30:1pYbF4:G1X5EI1m6Il8NisZtY6URJf0xVzyhDeo_ZDDO9gGkxs','2023-03-18 23:24:42.892970');
INSERT INTO "django_session" VALUES ('spt1abuws4tzezl9kl13iq641ol54hnq','e30:1pYbHF:NoynOCj9ITwY4FU4q9MzlJ7UJEaQJHBxsd_wsYFpkTM','2023-03-18 23:26:57.670715');
INSERT INTO "django_session" VALUES ('qlntj4xjf9p5cws6y8yhe4vh3b9xgjys','.eJxVjMsOwiAURP-FtSGAPIpL934DuXC5UjWQlHZl_Hdp0oXOcs6ZebMA21rC1vMSZmQXJs_s9FtGSM9cd4IPqPfGU6vrMke-K_ygnd8a5tf1cP8OCvQy1hZISxNJi0mSApMEoVKgnRPaKW8NkfE0MmXnBVohNJJBq4ySOHT2-QIE4DgM:1pYx0m:_h6XAMwSOdlOXyCWDHwPE8SjerZZKiXm0RK8ITBOMZY','2023-03-19 22:39:24.192483');
CREATE INDEX IF NOT EXISTS "Negocio_cart_user_id_64aa6ca8" ON "Negocio_cart" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_item_cart_cart_id_a2a2ec8b" ON "Negocio_item_cart" (
	"cart_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_item_cart_producto_id_1a908325" ON "Negocio_item_cart" (
	"producto_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_material_marca_id_5f38829f" ON "Negocio_material" (
	"marca_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_myfiles_user_id_6b221a48" ON "Negocio_myfiles" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_payment_user_id_e044b67b" ON "Negocio_payment" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_producto_categoria_id_890524f3" ON "Negocio_producto" (
	"categoria_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_producto_descuento_id_e9ea106f" ON "Negocio_producto" (
	"descuento_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_producto_material_id_629d289a" ON "Negocio_producto" (
	"material_id"
);
CREATE INDEX IF NOT EXISTS "Negocio_producto_user_id_8978d112" ON "Negocio_producto" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
