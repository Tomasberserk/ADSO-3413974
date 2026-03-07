# Manual Tecnico de Control de Versiones con Git

Este manual proporciona una guia detallada sobre el uso de Git mediante la interfaz de linea de comandos (CLI). El objetivo es establecer un flujo de trabajo estandarizado para la gestion de cambios en proyectos de desarrollo de software o en palabras mas claras, permitirnos darnos el lujo de guardar cambios y verlos todos sin importar cuantos guardados hagamos.



## 1. Ejecucion de Commits
Un commit es un registro permanente de los cambios en el repositorio local. Debe ser atomico y representar una unidad logica de trabajo.

### 1.1. Sintaxis Estandar
```bash
git commit -m "tipo: descripcion breve del cambio"
```

### 1.2. Modificacion del Ultimo Commit
Si se requiere corregir el mensaje del ultimo commit o incluir un archivo olvidado antes de realizar un push:
```bash
git commit --amend --no-edit
```

## 2.Comandos: Inspeccion y Diagnostico
Comandos esenciales para auditar el estado del proyecto y el historial de cambios.

| Comando | Descripcion |
| :--- | :--- |
| `git status` | Indica los archivos modificados, en stage o sin seguimiento. |
| `git log --oneline` | Despliega el historial de commits de forma resumida. |
| `git diff` | Muestra las diferencias de contenido antes de pasar a stage. |
| `git diff --staged` | Muestra las diferencias entre el area de preparacion y el ultimo commit. |
| `git show [hash]` | Detalla los cambios realizados en un commit especifico. |
