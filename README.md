# 💊 Farma_rapid

Este proyecto corresponde a la **Actividad de la clase 3** de la materia de Bases de Datos.  
Se desarrolló la base de datos **Farma_rapid**, que representa la gestión de una farmacia, implementada tanto en **MySQL** como en **PostgreSQL** utilizando diferentes herramientas.

---

## 📌 Objetivos
- Crear la base de datos en distintos gestores (MySQL y PostgreSQL).
- Utilizar terminal, DBeaver, Workbench y pgAdmin para la construcción y pruebas.
- Implementar tablas independientes, dependientes y pivote.
- Usar **ENUMs** para definir estados y tipos en PostgreSQL.
- Realizar **backup y restore** de la base de datos con `pg_dump` y Docker.
- Documentar todo el proceso con capturas y respaldar los archivos en GitHub.

---

## 🏗️ Estructura de la base de datos

### 🔹 Tablas independientes
- `categories`
- `suppliers`
- `customers`
- `taxes`

### 🔹 Tablas dependientes
- `medicines` (depende de categories)
- `prescriptions` (depende de customers)
- `sales` (depende de customers)
- `batches` (depende de medicines y suppliers)

### 🔹 Tablas pivote
- `medicines_prescriptions`
- `medicines_sales`
- `medicines_sales_taxes`

### 🔹 Otras tablas
- `payments` (usa ENUM `payment_method` y depende de sales)

---

## 🗃️ ENUMs en PostgreSQL
- `payment_method`: `cash`, `card`, `transfer`
- `sale_status`: `pending`, `paid`, `canceled`
- `batch_status`: `available`, `expired`, `out_of_stock`
- `prescription_status`: `active`, `closed`

---

## 🔄 Backup y Restore
- Backup ejecutado con:
  ```bash
  pg_dump -U postgres -d farma_rapid > backup.sql
