# Manual Tecnico de Control de Versiones con Git

Este documento proporciona una guia detallada sobre el uso de Git mediante la interfaz de linea de comandos (CLI). El objetivo es establecer un flujo de trabajo estandarizado para la gestion de cambios en proyectos de desarrollo de software.

## 1. Configuracion de Identidad
Antes de realizar cualquier operacion en el repositorio, es mandatorio configurar las variables de entorno de usuario. Estas se vinculan a cada commit realizado.

```bash
# Definir nombre del autor
git config --global user.name "Nombre Apellido"

# Definir correo electronico del autor
git config --global user.email "correo@ejemplo.com"

# Verificar la persistencia de la configuracion
git config --list
```

## 2. El Ciclo de Vida de los Archivos en Git
Para realizar commits efectivos, el desarrollador debe comprender los tres estados fundamentales por los que atraviesa un archivo:

1.  **Working Directory:** Archivos en el sistema de archivos local que han sido modificados pero no marcados para seguimiento.
2.  **Staging Area (Index):** Espacio donde se preparan los cambios que seran incluidos en la proxima captura de estado.
3.  **Local Repository:** Base de datos donde se almacenan permanentemente los snapshots de los cambios confirmados.

## 3. Gestion de Archivos en el Staging Area
El comando `git add` es el encargado de mover los cambios del directorio de trabajo al area de preparacion.

* **Preparar un archivo especifico:**
    `git add ruta/al/archivo.ext`
* **Preparar todos los cambios (archivos nuevos, modificados y eliminados):**
    `git add .`
* **Preparacion interactiva por fragmentos (hunks):**
    `git add -p`

## 4. Ejecucion de Commits
Un commit es un registro permanente de los cambios en el repositorio local. Debe ser atomico y representar una unidad logica de trabajo.

### 4.1. Sintaxis Estandar
```bash
git commit -m "tipo: descripcion breve del cambio"
```

### 4.2. Modificacion del Ultimo Commit
Si se requiere corregir el mensaje del ultimo commit o incluir un archivo olvidado antes de realizar un push:
```bash
git commit --amend --no-edit
```

## 5. Sincronizacion con Repositorios Remotos
La colaboracion requiere la transferencia de objetos de Git entre el repositorio local y un servidor (ej. GitHub).

* **Vincular un repositorio remoto:**
    `git remote add origin https://github.com/usuario/repositorio.git`
* **Enviar cambios al servidor:**
    `git push origin nombre_de_la_rama`
* **Recuperar e integrar cambios remotos:**
    `git pull origin nombre_de_la_rama`

## 6. Inspeccion y Diagnostico
Comandos esenciales para auditar el estado del proyecto y el historial de cambios.

| Comando | Descripcion |
| :--- | :--- |
| `git status` | Indica los archivos modificados, en stage o sin seguimiento. |
| `git log --oneline` | Despliega el historial de commits de forma resumida. |
| `git diff` | Muestra las diferencias de contenido antes de pasar a stage. |
| `git diff --staged` | Muestra las diferencias entre el area de preparacion y el ultimo commit. |
| `git show [hash]` | Detalla los cambios realizados en un commit especifico. |

## 7. Buenas Practicas de Ingenieria
1.  **Commits Atomicos:** Cada commit debe resolver un solo problema o implementar una sola funcionalidad.
2.  **Uso de Conventional Commits:** Se recomienda el uso de prefijos para facilitar la lectura del log (fix: para errores, feat: para funciones, docs: para documentacion).
3.  **Verificacion de Estado:** Ejecutar `git status` sistematicamente antes y despues de cada comando que altere el indice o el repositorio.
4.  **Exclusion de Archivos:** Configurar un archivo `.gitignore` para omitir dependencias, variables de entorno y archivos generados por el compilador.
