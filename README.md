# diseno-optimizacion-bbdd

Colección de proyectos de diseño, implementación y optimización de bases de datos relacionales (Oracle). Aquí encontrarás desde los diagramas conceptuales hasta scripts SQL complejos con lógica de negocio real.

---

## 1. Gestión de Liga de Fútbol
**Carpeta:** `01-liga-futbol-db`

Diseño completo de la base de datos para una liga profesional (La Liga). El reto principal fue mantener la integridad de la competición mediante restricciones automáticas.

### Lo más destacado:
* **El "Trigger Anti-Espejo":** Existe una restricción que impide físicamente que un equipo juegue contra sí mismo en la tabla de Partidos.
* **Limpieza en Cascada:** Si se elimina un estadio, un *Trigger* se encarga de buscar qué equipos jugaban allí y actualiza sus fichas automáticamente para que no queden datos "huérfanos".
* **Optimización:** Uso de vistas materializadas para agilizar las consultas de la clasificación general.

---

## 2. Operaciones de Aerolínea
**Carpeta:** `02-operaciones-aerolinea-db`

Sistema para el control de tráfico aéreo y asignación de tripulación. Este proyecto es mucho más estricto con las reglas temporales y de estados.

### Lo más destacado:
* **Detector de Conflictos de Horario:** El script incluye un *Trigger* complejo (`trg_BI_realiza_sin_conflictos`) que detecta si intentas asignar a una persona a dos vuelos que se solapan en el tiempo. Si detecta conflicto, bloquea la inserción.
* **Semáforo de Estados:** Restricciones lógicas (CHECKs) para asegurar que un vuelo no pueda estar marcado como "Cancelado" y "En Vuelo" a la vez.

---

## Herramientas y Tecnologías
* **Motor:** Oracle Database.
* **Diseño:** Draw.io.
* **Claves:** Triggers, Procedimientos almacenados, Normalización (3FN).
