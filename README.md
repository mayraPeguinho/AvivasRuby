# Proyecto de Gestión de Inventario de Indumentaria

Este proyecto contiene el desarrollo de una aplicación de gestión de inventario de indumentaria. Esta aplicación permite al personal administrar el stock de productos, realizar ventas y tener una página pública que permita a los potenciales clientes ver los productos que la tienda tiene en stock.

## Decisiones de diseño

- Se utilizó **Tailwind CSS** como framework de diseño para agilizar el desarrollo del frontend y mantener un estilo visual coherente.
- Se optó por diseñar el front en inglés para una mayor facilidad de adaptación en relación al framework Rails y sus gemas.

### Diseño de base datos

- Entidad product: representa a los productos de la aplicación
  - Entidad color: representa el color de un product. Se optó representar los colores de esta manera para mayor comodidad del usuario al cargar un product. Puede evaluarse en futuras versiones, agregar un filtrado por color.
  - Entidad size: representa el talle de un product.  Idem que color.
  - Entidad category: representa la categoría a la que pertenece un product. Idem que color, además se implementa un buscador en home, para el cliente potencial buscar por categorías ya establecidas mejora la experiencia.
- Entidad sale: representa a las ventas de la aplicación.
  - Entidad product_sold: representa a los productos vendidos, con sus cantidades y precio. Estos estarán asociados a una venta. 
- Entidad user: representa a los usuarios del sistema que pueden acceder a la sección de administración.

## Requisitos técnicos

- Ruby on Rails >= 8.0.0
- Ruby >= 3.2.0
- SQLite
- Tailwind CSS >= 3.0

 #### Gemas utilizadas

 - CanCan para autorización del sistema
 - Devise para gestión de usuarios
 - Active Storage para manejo de imágenes
 - Ransack para operaciones de búsqueda de productos
 - Active Storage Validations para la validación de imágenes
 - Kaminari para el paginado de las diferentes listas

## Usuarios de login de prueba

- Usuario administrador
  - email: admin1@example.com
  - password: adminRol1

- Usuario gerente
  - email: manager1@example.com
  - password: manager1

- Usuario empleado
  - email: employee1@example.com
  - password: employee1

## Instrucciones de instalación y como levantar el proyecto 

1. Clonar Proyecto
```
git clone https://github.com/mayraPeguinho/AvivasRuby.git
cd AvivasRuby
```
2. Instalar Dependencias
```
bundle install
```
3. Construir base de datos y generar datos de prueba
``` 
rails db:reset
```
4. Levantar el Proyecto
``` 
bin/dev
```

