# 🏗️ Guía Rápida de Git y Terminal

Esta guía contiene los comandos esenciales para gestionar versiones de código desde la terminal, optimizada para un flujo de trabajo ágil.

---

## 🛠️ 1. Configuración Inicial
Antes de empezar, asegúrate de que Git sepa quién eres. Esto solo se hace una vez por computadora.

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

## 🚀 2. Flujo de Trabajo para Commits
El "Commit" es la unidad básica de cambio en Git. Sigue estos pasos para guardar tus avances:

### Paso 1: Ver el estado actual
Antes de hacer nada, revisa qué archivos han cambiado.
```bash
git status
```

### Paso 2: Preparar archivos (Stage)
Añade los archivos que quieres incluir en tu "punto de control".
* **Para un archivo:** `git add nombre_del_archivo.ext`
* **Para todo:** `git add .`

### Paso 3: Confirmar cambios (Commit)
Guarda los cambios con un mensaje que explique **qué** hiciste.
```bash
git commit -m "feat: agrega validación de formularios"
```

### Paso 4: Subir a GitHub (Push)
Envía tus commits locales al repositorio remoto.
```bash
git push origin main
```

---

## 📋 3. Comandos de Supervivencia

| Comando | Acción |
| :--- | :--- |
| `git init` | Crea un nuevo repositorio local. |
| `git log --oneline` | Muestra el historial de commits resumido. |
| `git pull` | Descarga y fusiona los cambios de la nube a tu PC. |
| `git branch` | Lista todas las ramas disponibles. |
| `git checkout -b nombre-rama` | Crea una rama nueva y se cambia a ella. |
| `git diff` | Muestra los cambios exactos línea por línea. |

---

## 💡 Consejos Pro
* **Commits Pequeños:** No esperes a terminar todo el proyecto para hacer un commit. Haz uno por cada pequeña funcionalidad terminada.
* **Mensajes Claros:** Usa verbos en presente (Agrega, Corrige, Elimina) para que el historial sea fácil de leer.
* **Usa .gitignore:** Crea un archivo llamado `.gitignore` para listar los archivos o carpetas que **no** quieres subir a GitHub (como contraseñas o carpetas de dependencias pesadas).
