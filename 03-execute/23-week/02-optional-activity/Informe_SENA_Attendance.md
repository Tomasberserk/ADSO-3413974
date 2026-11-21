# Informe Técnico — Estrategias de Ingeniería, Gestión del Conocimiento y Plan de Contingencia en SENA Attendance

**Proyecto evaluado:** Sistema de Control de Asistencia SENA (`SENA Attendance`)  
**Aprendiz:** Tomás Barrera Ortiz  
**Programa / Ficha:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Semana:** Semana 23  
**Despliegue de referencia:** https://ejemplo-sigma.vercel.app/  

---

## 1. Descripción General del Sistema (`SENA Attendance`)

**SENA Attendance** es una aplicación web institucional diseñada para registrar, validar y auditar la asistencia presencial de aprendices en ambientes de formación del SENA. Sustituye el llamado a lista manual y lento mediante códigos QR dinámicos rotativos, reglas automatizadas de puntualidad, gestión de excusas con ventana hábil y control de acceso basado en roles (**Aprendiz**, **Instructor** y **Coordinador Académico**).

El sistema se construye bajo una **arquitectura de 7 capas (`N = 7`)**:
1. **Experiencia (Frontend SPA):** Interfaz unificada SENA (`frontend/index.html`, `app.js`, `offline-queue.js`) con accesibilidad y cola *offline* idempotente.
2. **Presentación HTTP:** Rutas Express y controladores delgados con validación de contratos.
3. **Aplicación:** Casos de uso, políticas RBAC por recurso y registro de auditoría inmutable.
4. **Dominio Puro:** Reglas de negocio (`BR-01` a `BR-12`) sin dependencias externas (puntualidad, QR HMAC cada 15 s, días hábiles colombianos, regla de 4 ojos).
5. **Puertos:** Contratos desacoplados para repositorios y notificaciones.
6. **Persistencia:** Adaptador SQL portable (SQLite local / PostgreSQL 16 en producción).
7. **Infraestructura y Composición:** Seguridad JWT, cabeceras HTTP, *rate limiting* y ensamblaje (`bootstrap`).

---

## 2. Aplicación de las 5 Metodologías de la Semana 23

### 2.1 Design Thinking (Pensamiento de Diseño)
Se aplicó para replantear el proceso de asistencia desde la realidad del ambiente de formación:
- **Empatizar:** Entrevistas a instructores y aprendices evidenciaron pérdidas de 15–20 minutos por clase, caídas de internet en aulas y poca transparencia sobre las inasistencias registradas.
- **Definir:** ¿Cómo registrar la asistencia de toda una ficha en menos de 2 minutos sin fraudes remotos y sin bloquear la clase cuando falla la red o una cámara?
- **Idear:** Se propuso el escaneo de QR dinámico con respaldo de código corto de 6 caracteres, cálculo automático de bloques de retardo y cola *offline* en el navegador.
- **Prototipar:** Mockups navegables y MVP web desplegado en Vercel.
- **Evaluar:** Pruebas en aula real con escenarios de contingencia (celular sin batería, sin cámara, sin datos móviles, aprendiz nuevo).

### 2.2 Estrategia de Gestión del Conocimiento
El conocimiento técnico y funcional del proyecto no queda disperso en chats o en la memoria de un solo integrante; se formaliza mediante **SDD (*Specification-Driven Development*)**:
- **Captura:** Reglas de negocio, decisiones arquitectónicas (`ADR-001` a `ADR-003`), entrevistas y hallazgos de auditoría registrados en Markdown versionado en Git.
- **Organización:** Carpeta normativa `docs/` estructurada por dominio (`architecture/`, `api/`, `security/`, `operations/`, `validation/`, `ui-ux/`).
- **Transferencia y continuidad:** Cualquier aprendiz o instructor nuevo puede comprender el sistema, levantar el entorno y ejecutar la suite de pruebas (`npm test`) en minutos gracias a los documentos y pruebas automatizadas que actúan como especificación viva.

### 2.3 Ingeniería Inversa
A partir del prototipo inicial (`app-attendance`) y de los flujos institucionales de gestión de horarios/asistencia, se realizó un análisis de ingeniería inversa para descubrir reglas ocultas, brechas de seguridad y oportunidades de mejora:
- **Hallazgos funcionales identificados:** El QR rotaba originalmente cada 60 s con 10 ventanas previas (permitía compartir fotos por WhatsApp); faltaba validación estricta del modo de validación (`BR-05`) y control de excusas duplicadas (`BR-04`/`BR-07`).
- **Hallazgos de seguridad corregidos (15 hallazgos cerrados/mitigados):**
  - Endurecimiento de RBAC en todas las rutas críticas (un aprendiz ya no puede abrir/cerrar salas ni aprobar excusas: `403 Forbidden`).
  - Eliminación del retorno de `resetToken` por HTTP en recuperación de clave.
  - Validación de *magic bytes* en evidencias adjuntas y protección contra XSS almacenado.
  - Aplicación de la **Regla de 4 Ojos (`BR-08`)** para baja de fichas académicas y cumplimiento de **Habeas Data (Ley 1581 / `BR-11`)** mediante anonimización determinista.

### 2.4 Priorización MoSCoW
La matriz MoSCoW permitió enfocar el desarrollo del MVP y las iteraciones de endurecimiento sin dispersar esfuerzo:

| Categoría | Funcionalidades en `SENA Attendance` |
| :--- | :--- |
| **Must Have** *(Obligatorio)* | Login unificado JWT/RBAC, apertura de sala con QR rotativo de 15 s (`HMAC`), código manual de 6 caracteres, regla de puntualidad (`BR-02`), prevención de doble registro (`BR-04`) y auditoría inmutable. |
| **Should Have** *(Importante)* | Cola *offline* deduplicada (`offline-queue.js`), radicación y aprobación de excusas dentro de 3 días hábiles colombianos (`BR-07`), *override* manual docente y reportes exportables (Excel/PDF). |
| **Could Have** *(Deseable)* | Notificaciones automáticas por correo institucional, métricas avanzadas de deserción por ficha y panel de analítica histórica. |
| **Won't Have** *(Fuera de esta fase)* | Reconocimiento facial/biométrico (descartado por `ADR-003` y privacidad), app nativa en tiendas móviles e integración directa con SOFIA Plus sin API oficial. |

### 2.5 Plan de Contingencia Operativa y Técnica
Para garantizar que el llamado a lista **nunca se detenga** en el ambiente de formación, el sistema contempla escenarios de fallo concretos con respuesta definida:

| Riesgo / Falla en Aula | Nivel | Mecanismo de Detección | Acción de Contingencia (Plan B) | Recuperación |
| :--- | :---: | :--- | :--- | :--- |
| **Caída de internet o señal débil en el ambiente** | Alto | Fallo de red en `fetch` / indicador de estado API | `offline-queue.js` almacena el check-in localmente con clave de idempotencia sin duplicar | Sincronización automática al recuperar conexión (`409` idempotente y resolución visible de conflictos) |
| **Cámara dañada o celular sin lector QR** | Medio | El aprendiz no logra enfocar el QR proyectado | Uso del **código manual de 6 caracteres** (`manualSixCode`) visible junto al QR | Validación directa vía `POST /public/attendance/:code/register` sin re-login |
| **Aprendiz sin celular o batería agotada** | Medio | Reporte presencial al instructor en clase | **Override manual docente** autenticado (`INSTRUCTOR`) desde el tablero de sesión | Registro con trazabilidad de autoría en auditoría inmutable |
| **Intento de fraude remoto (compartir foto QR)** | Alto | Validación criptográfica HMAC + subred IP | Rotación automática del QR cada **15 segundos** (`QR_WINDOW_MS = 15000`, `leeway = 1`) | Rechazo inmediato de tokens expirados o fuera de ventana |
| **Falla de base de datos o migración** | Alto | Fallo en `/ready` o pruebas de portabilidad | Doble soporte SQLite (local/contingencia) y PostgreSQL 16 con transacciones atómicas (`withTransaction`) | Restauración desde esquema versionado (`database/schema.sql`) y verificación con suite QA (`npm test`) |

---

## 3. Conclusión

La integración de **Design Thinking**, **Gestión del Conocimiento (SDD)**, **Ingeniería Inversa**, **MoSCoW** y un **Plan de Contingencia real** permitió transformar un prototipo básico de asistencia en un sistema robusto, auditado (19/19 controles de seguridad en verde) y resiliente frente a las condiciones reales de los ambientes de formación SENA.
