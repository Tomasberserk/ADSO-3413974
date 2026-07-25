### C. Mecanismos de Contingencia Tecnológica
* **Fallo de Captura:** En caso de fallas físicas en la cámara del dispositivo móvil, el portal de estudiantes ofrece un formulario de ingreso manual alternativo donde se digita el código activo de 6 caracteres que el docente visualiza en el proyector.
* **Fallas de Conectividad:** Si el estudiante no dispone de un dispositivo compatible o de acceso a la red local, el docente cuenta con una funcionalidad de anulación manual de registro (**Override**) desde su panel de control para ingresar la asistencia y corregir el registro de horas del estudiante de forma directa en el servidor.
---
## 2. Metodología de Reconstrucción Conceptual (Design Thinking)
Si el sistema debiese ser rediseñado o reconstruido desde sus cimientos, el enfoque metodológico exige priorizar la experiencia de usuario y la calidad del servicio antes de proceder a la fase de desarrollo de código, estructurándose en las siguientes fases de Design Thinking sobre papel:
### Fase 1: Empatizar
* **Análisis de Usuarios en el Aula:** Es indispensable identificar las limitaciones reales de los usuarios. Los estudiantes a menudo se enfrentan a problemas de rendimiento de sus dispositivos, baterías agotadas o fallos de conexión. Los docentes requieren un sistema ágil que no reste tiempo a la explicación académica de la sesión de clase.
### Fase 2: Definir
* **Planteamiento de Retos:** Redactar preguntas de diseño clave para orientar el proceso:
  - ¿Cómo podemos diseñar un flujo de registro que no requiera más de un clic por parte del estudiante puntual?
  - ¿Cómo podemos garantizar la validez del registro de asistencia sin que las fallas temporales de la red de internet bloqueen a estudiantes honestos?
### Fase 3: Idear (Planificación en Papel)
1. **Mecanismo de Registro Local Sin Conexión (Offline Buffering):** Diseñar un flujo donde la aplicación capture el código QR cifrado y almacene localmente la marca de tiempo (timestamp) en el almacenamiento local del dispositivo. El registro se enviará en segundo plano al servidor tan pronto como el dispositivo detecte conectividad a internet.
2. **Navegación Persistente:** Diseñar un sistema que almacene las credenciales de identificación de forma segura en el navegador local, evitando que el alumno deba digitar su documento y contraseña en cada sesión de clase.
3. **Flujo de Modificación Rápida para el Docente:** Rediseñar la interfaz de la grilla del docente en el panel para permitir la marcación de asistencia de alumnos excluidos de forma táctil y directa (ej. deslizamiento lateral o swipe sobre la fila del estudiante), reduciendo el número de interacciones.
### Fase 4: Prototipar
* **Maquetación en Papel:** Diseñar y dibujar en papel los esquemas de flujo de pantallas e interacciones simplificadas para estudiantes y docentes. Probar estos prototipos de baja fidelidad con usuarios reales en el salón para validar la claridad del copy de los mensajes y la lógica del flujo antes de proceder a la codificación en el servidor.
