# Auditoría UX/UI, Análisis de Brechas y Evaluación del Mockup "Gestión de Horarios SENA"

> **Rol de análisis:** Aprendiz SENA  
> **Fuente de la Verdad:** Manual del Sistema Integrado de Gestión y Autocontrol (SIGA - Articulación MIPG DO-M-001) y Proceso de Gestión de Formación Profesional Integral (GFPI) del SENA.  
> **Objeto de evaluación:** Mockup navegable del Sistema de Horarios SENA ([code-sena.github.io/design-software-mockup](https://code-sena.github.io/design-software-mockup/)) compuesto por 53 pantallas y modales en 8 módulos funcionales.

---

## 1. Resumen Ejecutivo y Contexto de la Evaluación

El prototipo analizado busca digitalizar y optimizar la planeación, publicación y seguimiento de horarios en los Centros de Formación Profesional del SENA. Si bien el mockup presenta una interfaz visual moderna (basada en un *Design System* consistente con tokens de diseño, tablas interactivas y modales responsivos), desde la **visión del Aprendiz SENA** y bajo el contraste riguroso del **Manual SIGA / MIPG (DO-M-001)**, se evidencian inconsistencias operativas, desconexión de flujos de trabajo críticos e insuficiencias en la representación de la realidad académica del SENA.

Este documento consolida una crítica constructiva y técnica de **todas las 53 pantallas del prototipo**, destacando las fallas de experiencia de usuario (UX), los vacíos de lógica de negocio (Gaps) y proponiendo soluciones integrales alineadas a la normatividad institucional.

---

## 2. Marco Normativo y Fuente de la Verdad: SIGA - MIPG (DO-M-001) y GFPI

Para fundamentar las sugerencias y críticas, se toma como referencia el **Sistema Integrado de Gestión y Autocontrol (SIGA)** articulado con el **Modelo Integrado de Planeación y Gestión (MIPG)**:

1. **Dimensión de Gestión con Valores para el Resultado (MIPG):** Exige la optimización de los trámites y la transparencia hacia el ciudadano/aprendiz. Un sistema de horarios no solo coordina espacios físicamente, sino que garantiza el derecho del aprendiz a la formación profesional trazable.
2. **Proceso de Gestión de Formación Profesional Integral (GFPI):**
   - **Diseño Curricular:** Cadena jerárquica estricta: *Línea Tecnológica → Red Tecnológica → Red de Conocimiento → Programa de Formación → Competencia → Resultado de Aprendizaje (RAP)*.
   - **Ejecución de la Formación:** Basada en la *Planeación Pedagógica*, las *Guías de Aprendizaje* y las *Actividades del Proyecto Formativo*.
   - **Juicios de Evaluación:** Registro del logro de RAPs (*Aprobado / No Aprobado*) en la plataforma oficial (SofiaPlus / ZAJUNA).
   - **Continuidad del Servicio e Incapacidades/Excusas:** Procedimiento SIGA para la gestión del talento humano docente. La inasistencia o indisponibilidad de un instructor exige notificación inmediata a la Coordinación Académica para activar plan de contingencia (remplazo o reprogramación oficial).

---

## 3. Análisis Profundo de Sugerencias Clave del Aprendiz

### 3.1. Avance Curricular Transparente y Basado en Sesiones/RAPs (Instructor y Aprendiz)

> [!IMPORTANT]
> **Deficiencia actual en el Mockup:**  
> En el módulo de *Seguimiento de Ficha* (Pantallas 23 y 24), el campo `Avance Curricular (%)` es un simple **campo de texto/número manual** en el que el instructor escribe libremente un porcentaje (ej. `65%`). En las pantallas del Aprendiz (Pantallas 25 y 27), el aprendiz **no tiene ninguna visibilidad** de su progreso en el programa de formación.

#### Propuesta de Solución desde la Optica del Aprendiz:
* **En el Panel del Instructor (`/instructor/seguimiento`):** El avance curricular **NO debe ser digitado manualmente**. Debe ser un indicador **calculado automáticamente** por el sistema en función de:
  1. **Horas Ejecutadas vs. Horas Totales:** Sesiones de clase impartidas y validadas por asistencia.
  2. **Resultados de Aprendizaje (RAPs) Evaluados:** Número de RAPs asociados a las actividades desarrolladas en la ficha que ya cuentan con juicio evaluativo emitido.
  3. **Visualización por Ficha:** Desglose del avance por fases del proyecto (*Análisis, Diseño, Desarrollo, Evaluación*).
* **En el Panel del Aprendiz (`/mi-horario` y `/mi-avance`):** Se debe crear un módulo de **"Mi Avance Curricular"** donde el aprendiz pueda visualizar:
  - Porcentaje global de cumplimiento del programa (Lógica: RAPs aprobados / RAPs totales del programa).
  - Estado detallado por **Competencias y RAPs**: RAPs aprobados, RAPs en ejecución (según horario vigente) y RAPs pendientes.
  - Trazabilidad de sesiones asistidas frente a la intensidad horaria exigida por la reglamentación SENA (cumplimiento del 80%+ de asistencia requerida para no incurrir en deserción por inasistencia).

---

### 3.2. Flujo Completo e Integrado para Excepciones/Excusas del Instructor

> [!WARNING]
> **Deficiencia actual en el Mockup:**  
> En la pantalla *Mi Disponibilidad del Instructor* (Pantallas 21 y 22), el instructor registra bloqueos puntualizados (incapacidad médica, capacitación, comisión). Sin embargo, **el sistema guarda este registro de manera aislada**. No genera ninguna solicitud, aviso ni notificación para la Coordinación Académica. Tampoco actualiza el motor de horarios ni refleja en el dashboard del coordinador que esa ficha se quedará sin instructor en esas fechas.

#### Propuesta de Solución e Integración en SIGA:
* **Circuito de Aprobación y Contingencia:**
  1. **Registro:** El instructor radica la excusa/excepción adjuntando soporte (soporte médico EPS, memorando de comisión, etc.).
  2. **Notificación Automática a Coordinación:** La novedad ingresa de forma inmediata a una **Bandeja de Novedades de Instructores** en el Dashboard del Coordinador Académico (`#/`).
  3. **Evaluación e Impacto en Horarios:** El sistema le indica automáticamente al coordinador qué fichas y sesiones resultan afectadas por la inasistencia.
  4. **Plan de Contingencia (Asignación de Sustituto o Reprogramación):** El coordinador puede:
     - Asignar un *Instructor de Remplazo* disponible.
     - Reprogramar las horas de la sesión a una fecha posterior.
     - Aprobar trabajo independiente / guía de aprendizaje asincrónica.
  5. **Notificación al Aprendiz:** Una vez aprobada la novedad por Coordinación, el sistema envía una **Alerta/Notificación al Aprendiz** informando la cancelación, cambio de ambiente o asignación del instructor sustituto para la clase.

---

## 4. Revisión Exhaustiva por Módulos de las 53 Pantallas del Mockup

A continuación se presenta la auditoría pormenorizada de cada pantalla del prototipo navegable, organizada en 7 módulos funcionales.

---

### Módulo 1: Auth, App Shell y Estados del Sistema (Pantallas 01 – 06)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **01** | Login | `#/login` | Interfaz limpia con selección implícita de rol por correo. | Falta autenticación multifactor (MFA) requerida por políticas de seguridad de la información SIGA (ISO 27001). | Permitir inicio de sesión único (SSO) con MiSena / SoySena / Microsoft 365 institucional. |
| **02** | Recuperar contraseña | `#/forgot-password` | Formulario básico de solicitud de correo. | No indica canales de mesa de ayuda del centro ni tiempo de vigencia del enlace. | Añadir verificación por token SMS/Correo y enlace directo al soporte del centro de formación. |
| **03** | Nueva contraseña | `#/reset-password` | Formulario de cambio de clave. | Falta indicador visual de complejidad de contraseña (política SIGA). | Incluir validación en tiempo real de políticas de seguridad de clave (mínimo 8 caracteres, mayúsculas, símbolos). |
| **04** | App Shell por rol | `#/review/app-shell` | Estructura responsiva con barra lateral y menú superior. | No visualiza el Centro de Formación ni la Sede en la barra de estado superior. | Mostrar nombre del Centro de Formación, Sede y Ficha activa (para aprendices). |
| **05** | Panel de Notificaciones | `?overlay=notifications` | Desplegable lateral de alertas. | Notificaciones estáticas sin acciones directas (*deep links*) para resolver la alerta. | Permitir filtrar por tipo: *Académica, Horarios, Bienestar, Administrativa* y responder o marcar como leída. |
| **06** | Estados Globales | `#/system-states` | Vistas de error 403, 404, 500 y sesión expirada. | Buen diseño defensivo, pero los mensajes son genéricos para el usuario final. | Personalizar errores con enlaces directos para solicitar ayuda al Administrador de Soporte del Centro. |

---

### Módulo 2: Coordinación Académica — Horarios y Conflictos (Pantallas 07 – 14)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **07** | Dashboard / Inicio Coordinador | `#/?as=coordinator` | Muestra conflictos pendientes y fichas activas. | No muestra las novedades de instructores (excusas/incapacidades) ni alertas de inasistencia acumulada. | Integrar la *Bandeja de Novedades de Instructores* y métricas de fichas con riesgo de incumplimiento de horas. |
| **08** | Horarios — Lista | `#/horarios` | Tabla completa con filtros por instructor, ambiente y estado. | Falta filtro por Jornada (Diurna, Nocturna, 24/7) y por Fase del Proyecto Formativo. | Incluir filtros avanzados por programa de formación y versión de diseño curricular. |
| **09** | Detalle de Horario | `#/horarios/sch-03` | Vista de solo lectura de horario publicado. | No permite exportar el horario en formatos estándar institucionales (PDF firmado o iCal/Google Calendar). | Añadir botón de exportación masiva y sincronización automática con calendarios de aprendices e instructores. |
| **10** | Crear / Editar Horario | `#/horarios/nuevo` | Editor con formulario de datos generales y tabla de sesiones. | No valida el cupo del ambiente asignado vs. la cantidad de aprendices matriculados en la ficha. | Incorporar alerta automática cuando el cupo del ambiente sea menor que el número de aprendices de la ficha. |
| **11** | Modal Agregar / Editar Sesión | `?modal=session` | Asigna competencia, instructor, ambiente y franja. | **Grave:** No permite asociar la sesión a un *Resultado de Aprendizaje (RAP)* específico ni a una *Actividad de Aprendizaje*. | Obligar la selección del RAP que se ejecutará en la sesión para garantizar la trazabilidad pedagógica GFPI. |
| **12** | Modal Confirmar Publicación | `?modal=publish` | Resumen previo a la publicación definitiva. | No genera constancia digital ni notifica automáticamente a los aprendices afectados. | Al publicar, disparar notificación push y correo a todos los aprendices inscritos en la ficha. |
| **13** | Panel de Conflictos | `#/horarios/sch-02/conflictos` | Agrupa conflictos por solapamiento de ambiente e instructor. | No detecta cruces de transporte para instructores que viajan entre sedes distantes en franjas consecutivas. | Incluir regla de validación geográfica: tiempo mínimo de traslado entre sedes para un mismo instructor. |
| **14** | Modal Resolver Conflicto | `?modal=resolve` | Muestra detalle del cruce e instruye solución. | La resolución es manual sin sugerencias automatizadas del sistema (*Smart Assistant*). | Proponer alternativas automáticas de instructores o ambientes libres en esa misma franja horaria. |

---

### Módulo 3: Ambientes y Disponibilidad del Instructor (Pantallas 15, 16, 21, 22)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI and Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **15** | Disponibilidad (Coordinador) | `#/disponibilidad` | Vista de ocupación de ambientes y recursos. | Muestra disponibilidad de ambientes pero no el listado consolidado de disponibilidad horaria de instructores (`TODO GAP G2`). | Consolidar la malla de disponibilidad de instructores según sus horas contratadas (planta / contratistas). |
| **16** | Detalle de Ambiente | `#/disponibilidad/ambientes/env-01` | Muestra ficha técnica del aula o laboratorio. | No registra el estado de mantenimiento ni el inventario de equipos tecnológicos (PC, videobeam, software instalado). | Vincular con el inventario SIGA del ambiente para saber si el laboratorio cuenta con las herramientas necesarias para la clase. |
| **21** | Mi Disponibilidad (Instructor) | `#/instructor/mi-disponibilidad` | Lista excepciones vigentes (incapacidades, comisiones). | **Desconectado:** El registro no fluye hacia Coordinación Académica ni modifica la programación. | Convertir el registro en una *Solicitud de Novedad Docente* con estado (`Pendiente`, `Aprobada`, `Rechazada`). |
| **22** | Modal Crear Excepción | `?modal=exception` | Captura tipo, fecha inicio/fin y descripción. | No solicita el cargue obligatorio de soportes en PDF (incapacidad EPS o citación). | Exigir adjuntar el archivo de soporte (PDF/JPG) cumpliendo con la gestión documental SIGA. |

---

### Módulo 4: Fichas y Seguimiento de la Formación (Pantallas 17, 18, 23, 24)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **17** | Fichas — Lista | `#/fichas` | Listado general de fichas del centro. | No diferencia entre Etapa Lectiva y Etapa Productiva en la vista primaria. | Agregar columna y filtro por Etapa de Formación (*Inducción, Lectiva, Productiva, Graduada*). |
| **18** | Detalle de Ficha | `#/fichas/fic-01` | Presenta programa, código, nivel y horarios relacionados. | No muestra el listado de aprendices matriculados ni el vocero de ficha designado. | Incluir pestaña "Aprendices" con estado de matrícula y datos de contacto del Vocero de Ficha y Líder de Bienestar. |
| **23** | Seguimiento de Ficha (Instructor) | `#/instructor/seguimiento` | Registra mediciones periódicas de asistencia y avance. | `TODO GAP B3`: El permiso requiere elevación. Muestra el porcentaje de avance como un valor plano estático. | Reemplazar el valor plano por un tablero interactivo de indicadores automáticos de asistencia y RAPs evaluados. |
| **24** | Modal Registrar Seguimiento | `?modal=tracking` | Formulario para ingresar asistentes y % de avance. | Permite escribir un porcentaje de avance curricular arbitrario (ej. `65%`). | Calcular el avance automáticamente a partir de las sesiones realizadas y el registro de asistencia en sistema. |

---

### Módulo 5: Panel del Aprendiz — Mi Horario y Notificaciones (Pantallas 25 – 28)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **25** | Mi Horario — Aprendiz | `#/mi-horario` | Muestra lista cronológica de clases de la semana. | `TODO GAP B2`: Vista acotada. No ofrece vista en formato de Calendario Semanal (*Grid*) como la del instructor. | Proveer alternancia entre vista Lista y vista Calendario Semanal. Agregar botón para sincronizar con Google Calendar / Outlook. |
| **26** | Notificaciones — Aprendiz | `#/notificaciones` | Lista avisos recibidos por el usuario. | No diferencia notificaciones de cambios urgentes de horario vs. anuncios generales. | Clasificar con códigos de color de urgencia (ej. *Rojo: Clase cancelada o cambio de ambiente urgente*). |
| **27** | Detalle de Clase — Aprendiz | `#/mi-horario/sesiones/ses-01` | Muestra competencia, instructor, ambiente y notas. | No muestra los materiales de formación, enlace al aula virtual (ZAJUNA/Teams) ni la Guía de Aprendizaje. | Incluir enlace al Aula Virtual ZAJUNA, enlace a la sesión remota (si es virtual) y enlace a la Guía de Aprendizaje. |
| **28** | Detalle de Notificación | `#/notificaciones/not-01` | Vista de lectura completa de la notificación. | No permite interactuar (ej. "Confirmar lectura" o "Ver horario modificado"). | Agregar botón de acción directa (*"Ver cambio en Mi Horario"* o *"Solicitar justificación de inasistencia"*). |

---

### Módulo 6: Dirección, Indicadores KPI y Usuarios IAM (Pantallas 29 – 36)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **29** | Panel de Indicadores (Director) | `#/admin/indicadores` | Gráficos de nivel de riesgo y distribución por fichas. | Mide asistencia y avance sin correlacionar con índices de deserción reales ni metas del Plan de Acción SIGA. | Integrar tablero de control de deserción temprana con alertas para el equipo de Bienestar al Aprendiz. |
| **30** | Drill-Down de KPI | `#/admin/indicadores/track-01/attendance` | Evolución histórica temporal de la asistencia. | Los umbrales son fijos y no toman en cuenta la modalidad de la ficha (Presencial vs. Virtual). | Ajustar umbrales normativos según la modalidad (ej. mayor tolerancia en encuentros síncronos virtuales). |
| **31** | Usuarios — Lista | `#/admin/usuarios` | Gestión de usuarios del sistema. | No permite filtrar por ficha asociada en el caso de los aprendices. | Añadir filtros por Tipo de Documento, Ficha de Formación y Estado de Matrícuia. |
| **32** | Crear / Editar Usuario | `?modal=user` | Captura datos personales y rol del sistema. | No valida el correo institucional `@soy.sena.edu.co` o `@sena.edu.co`. | Forzar la sintaxis de correo institucional según el dominio correspondiente al rol. |
| **33** | Detalle de Usuario | `#/admin/usuarios/usr-02` | Muestra roles y permisos asignados. | No muestra el historial de accesos ni las fichas en las que el usuario está inscrito o imparte formación. | Incluir pestaña con el historial académico/laboral del usuario dentro de la plataforma. |
| **34** | Modal Asignar / Revocar Rol | `?modal=role` | Permite asignar roles en el sistema. | Permite asignar roles sin exigir la justificación o número de acto administrativo (resolución). | Exigir número de resolución o memorando de asignación para roles administrativos (cumplimiento auditoría SIGA). |
| **35** | Datos de Referencia | `#/admin/datos-referencia` | Tablas de catálogos y parámetros del sistema. | Interfaz técnica poco amigable para usuarios no administradores. | Agrupar los catálogos por dominios funcionales claros (*Académico, Infraestructura, Usuarios*). |
| **36** | Editar Catálogo / Parámetro | `?modal=reference` | Edición de valores de parámetro. | No mantiene historial de cambios de versión del parámetro. | Registrar auditoría de quién modificó el parámetro y la fecha/hora exacta del cambio. |

---

### Módulo 7: Back-Office, Auditoría, Documentos y Parametrización (Pantallas 37 – 53)

| # | Pantalla / Modal | Ruta Mockup | Evaluación UX/UI y Funcional | Brecha vs. SIGA / Normativa SENA | Sugerencias del Aprendiz |
|---|---|---|---|---|---|
| **37** | Documentos — Lista | `#/backoffice/documentos` | Gestión de archivos y reportes generados. | No implementa firma digital ni tabla de retención documental (TRD) según SIGA. | Integrar metadatos de TRD e integración con el sistema de gestión documental institucional. |
| **38** | Plantillas de Documento | `#/backoffice/documentos/plantillas` | Diseñador de plantillas de certificados y reportes. | No garantiza los formatos oficiales institucionales aprobados por la Oficina de Comunicaciones del SENA. | Cargar plantillas oficiales estandarizadas en el Manual de Imagen Corporativa SENA. |
| **39** | Auditoría | `#/backoffice/auditoria` | `TODO GAP B1`: Sin API REST expuesta. Muestra logs estáticos. | No permite filtrar por dirección IP, usuario ni entidad afectada. | Implementar visor de logs estándar con búsqueda por rango de tiempo y nivel de severidad (*INFO, WARN, ERROR*). |
| **40** | Parametrización / Catálogos | `#/backoffice/parametrizacion` | Hub de gestión de parámetros del sistema. | Estructura repetida con la pantalla 35. | Unificar el hub de parametrización en una sola ruta de administración general para evitar duplicidad UX. |
| **41** | Detalle de Documento + Versiones | `#/backoffice/documentos/doc-01` | Muestra historial de versiones del documento. | No diferencia borradores de documentos oficiales publicados. | Incorporar marcas de agua (*Borrador, Oficial, Anulado*) en la vista previa del documento. |
| **42** | Modal Generar Documento | `?modal=generate` | Formulario para solicitar reporte o certificación. | No indica el tiempo estimado de generación ni la cola de procesamiento. | Mostrar barra de progreso en tiempo real durante la generación de reportes masivos. |
| **43** | Editor / Preview de Plantilla | `#/backoffice/documentos/plantillas/tpl-01/editar` | Editor HTML/Markdown de plantillas. | Riesgo de seguridad por inyección de código sin sanetización. | Usar un editor WYSIWYG restringido a componentes visuales institucionales previamente aprobados. |
| **44** | Modal Detalle de Auditoría | `?modal=audit` | Muestra el JSON de la traza de auditoría. | Presentación cruda del JSON poco legible para auditores SIGA. | Formatear el JSON en un visor estructurado de objetos con resaltado de cambios (*Diff viewer*). |
| **45** | CRUD Catálogo / Parámetro | `?modal=crud` | Formulario genérico para crear/editar catálogos. | No valida dependencias (ej. eliminar un catálogo en uso por otras tablas). | Incluir validación de integridad referencial antes de permitir la desactivación o eliminación de un catálogo. |
| **46** | Hub de Parametrización | `#/admin/parametrizacion` | Panel principal de control de parámetros del sistema. | Buena organización por tarjetas, pero carece de un buscador global de parámetros. | Agregar barra de búsqueda rápida global para localizar parámetros por nombre o código. |
| **47** | Currículo Académico | `#/admin/parametrizacion/curriculo` | Jerarquía: Línea → Red Tecnológica → Red Conocimiento → Programa → Competencia → RAP. | **Excelente alineación taxonómica.** Falta gestionar la versión del programa de formación. | Permitir clonar programas de formación para crear nuevas versiones del diseño curricular (*Versionamiento GFPI*). |
| **48** | Jornadas / Franjas Horarias | `#/admin/parametrizacion/jornadas` | Configura horas de inicio, fin y jornada. | No contempla la franja trasnochadora (jornada 24 horas o madrugadas) para centros agropecuarios/industriales. | Permitir franjas flexibles y nocturnas especiales para centros de formación con operación continua. |
| **49** | Tipos de Ambiente e Inventario | `#/admin/parametrizacion/ambientes` | Clasifica aulas, laboratorios, talleres y fincas. | No mapea la capacidad de conectividad (ancho de banda) ni características de accesibilidad para aprendices con discapacidad. | Añadir atributos de *Accesibilidad Reducida / Inclusiva* (RAMPA, Braille) y capacidad de red. |
| **50** | Catálogos de Monitoreo | `#/admin/parametrizacion/monitoreo` | Define KPIs, estados de riesgo y tipos de alertas. | Alertas desconectadas del Comité de Evaluación y Seguimiento al Aprendiz. | Disparar automáticamente la citación a Comité cuando la alerta alcance el nivel `CRÍTICO`. |
| **51** | Estados de Actores | `#/admin/parametrizacion/estados` | Máquina de estados para Aprendiz, Instructor, Empresa y Etapa Productiva. | No refleja los estados oficiales del reglamento del aprendiz (*Aplazado, Retirado Voluntario, Sancionado, Cancelado*). | Reemplazar la lista genérica por la totalidad de estados de matrícula normativos del sistema SOFIAPLUS / SENA. |
| **52** | Geografía Institucional | `#/admin/parametrizacion/geografia` | Regiones, Zonas, Centros de Formación y Sedes. | No contempla subsedes ni aulas móviles (Aulas Bus SENA / Navegantes). | Incluir tipos de sedes especiales (*Sede Principal, Subsede, Aula Móvil, Convenio Marco*). |
| **53** | RBAC — Roles y Permisos | `#/admin/parametrizacion/rbac` | Matriz de roles y permisos del sistema. | Falta el rol de *Coordinador de Formación / Bienestar* y *Líder de Investigación (SENNOVA)*. | Crear roles específicos para Bienestar al Aprendiz, Voceros de Ficha y Gestores SENNOVA. |

---

## 5. Tabla Consolidada de Discrepancias vs. SIGA / MIPG / Normativa SENA

| Área de Dominio | Estado Actual en Mockup | Requisito SIGA / MIPG / GFPI | Impacto en la Formación |
|---|---|---|---|
| **Progreso Académico** | Digitación libre y manual de `% Avance Curricular` por el instructor en el seguimiento. | Cálculo automático transparente basado en horas ejecutadas y RAPs aprobados en el Juicio Evaluativo. | **Alto:** Inconsistencia entre lo reportado en horarios y el historial académico real en SofiaPlus/ZAJUNA. |
| **Novedades Docentes** | Excepciones del instructor se guardan como registro estático sin flujo de aprobación. | Procedimiento de continuidad del servicio SIGA: aprobación por Coordinación y plan de contingencia obligatorio. | **Crítico:** Desprotección de las fichas que se quedan sin clase sin previo aviso ni reprogramación oficial. |
| **Planeación Pedagógica** | Las sesiones del horario solo asocian la Competencia. | GFPI exige asociar cada sesión a un *Resultado de Aprendizaje (RAP)* y a la *Actividad del Proyecto*. | **Alto:** Pérdida de la trazabilidad pedagógica de la formación profesional integral. |
| **Panel del Aprendiz** | Vista limitada en lista de clases sin indicador de progreso ni materiales. | Dimensión MIPG Transparencia: el aprendiz debe contar con acceso integral a su ruta de formación y avance. | **Medio-Alto:** Desorientación del aprendiz respecto al cumplimiento de su programa de formación. |
| **Novedades de Matrícula** | Estados de aprendiz genéricos (*En formación, Retirado, Certificado*). | Reglamento del Aprendiz (Acuerdo 007/2012): requiere estados normativos (*Aplazamiento, Traslado, Reingreso, Cancelación*). | **Alto:** Imposibilidad de tramitar comités de seguimiento y novedades académicas desde la plataforma. |

---

## 6. Recomendaciones de Mejora Arquitectónica y UX/UI

1. **Implementar el Módulo "Mi Ruta de Formación" para el Aprendiz:**
   - Crear una nueva pantalla navegable (`#/aprendiz/mi-ruta`) que muestre un mapa visual tipo árbol o barra de progreso por Fases (*Análisis, Diseño, Desarrollo, Evaluación*), destacando los RAPs logrados, las horas acumuladas y el porcentaje exacto de avance hacia la certificación.
2. **Crear la Bandeja Única de Novedades e Incidencias para Coordinación Académica:**
   - Diseñar un panel centralizado donde el Coordinador apruebe excusas de instructores, asigne remplazos inmediatos y reprograme sesiones afectadas con un solo clic.
3. **Validación Automática en Tiempo Real de Reglas de Negocio:**
   - Restringir la publicación de horarios que tengan cruces de ambiente, exceso de cupo, instructores con excusa aprobada en la franja o sesiones sin RAP asignado.
4. **Sincronización Abierta e Integración:**
   - Permitir la exportación de horarios hacia formatos estándar (`.ics` para Google Calendar / Apple / Outlook) y generar códigos QR de validación en los ambientes de formación para control de asistencia presencial.

---
*Documento elaborado como insumo de retroalimentación de aprendices para la optimización del Sistema de Gestión de Horarios SENA.*
