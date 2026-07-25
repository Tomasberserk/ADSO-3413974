# Matriz MoSCoW y Evaluación Cualitativa del Proyecto

Este documento presenta la matriz MoSCoW para la jornada de hoy y realiza una evaluación reflexiva sobre la calidad del desarrollo actual, contrastando el prototipo construido con los principios de diseño centrado en el usuario.

---

## 1. Matriz MoSCoW de la Jornada de Hoy (Foco en Calidad y Análisis)

Con el fin de consolidar la entrega académica y no comprometer la estabilidad del sistema que ya está funcionando, clasificamos las actividades de hoy de la siguiente manera:

```
┌────────────────────────────────────────────────────────────────────────┐
│                              MATRIZ MoSCoW                             │
│                                                                        │
│  MUST HAVE (Crítico para hoy)           SHOULD HAVE (Importante)       │
│  ┌───────────────────────────────────┐  ┌───────────────────────────┐  │
│  │ - Inventario de componentes y     │  │ - Evaluar la usabilidad y │  │
│  │   funcionalidades actuales.       │  │   accesibilidad en el     │  │
│  │ - Análisis de flujos de usuario   │  │   salón de clase real.    │  │
│  │   y lógica de puntualidad.        │  │ - Documentar debilidades  │  │
│  │ - Autorreflexión del equipo.      │  │   en el flujo de claves.  │  │
│  └───────────────────────────────────┘  └───────────────────────────┘  │
│                                                                        │
│  COULD HAVE (Opcional si hay tiempo)    WON'T HAVE (Futuras sesiones)  │
│  ┌───────────────────────────────────┐  ┌───────────────────────────┐  │
│  │ - Diseñar en papel el nuevo flujo │  │ - Cambiar código fuente   │  │
│  │   de registro offline.            │  │   o bases de datos.       │  │
│  │ - Plantear mejoras visuales a     │  │ - Desplegar infraestructura │  │
│  │   las alertas de retardo.         │  │   adicional en la nube.   │  │
│  └───────────────────────────────────┘  └───────────────────────────┘  │
└────────────────────────────────────────────────────────────────────────┘
```

### 🟩 Must Have (Debe tener) - Esencial para hoy
* **Inventario Funcional:** Mapear de forma clara las pantallas, roles y flujos construidos en `INVENTARIO.md`.
* **Análisis de Lógica de Negocio:** Detallar las reglas de asistencia fraccionada y el algoritmo anti-fraude en `INGENIERIA_INVERSA.md`.
* **Autorreflexión Cualitativa:** Analizar los errores conceptuales cometidos por el equipo al programar directo sin planificar en papel.

### 🟨 Should Have (Debería tener) - Aporta valor significativo
* **Identificación de Puntos de Fricción:** Señalar las dificultades que sufren estudiantes sin internet o teléfonos compatibles con la cámara en el aula.
* **Evaluación de Usabilidad Básica:** Auditar si las pantallas y botones (ej. botón de reportes) son claros para docentes que no tienen afinidad tecnológica.

### 🟦 Could Have (Podría tener) - Opcional si queda tiempo
* **Bocetos de Experiencia:** Diseñar maquetas sencillas en papel de un sistema de registro de asistencia offline que almacene temporalmente la firma del QR.

### 🟥 Won't Have (No se hará hoy) - Fuera de alcance
* **Modificación de Código:** No tocar ningún archivo fuente de la aplicación desplegada para evitar regresiones de última hora en la calificación.
* **Cambios Tecnológicos Duros:** No realizar migraciones a TypeScript o MongoDB; el stack se evalúa cualitativamente tal como se encuentra implementado.

---

## 2. KPIs Cualitativos de la Solución Actual

Evaluamos el desempeño del prototipo construido en base a criterios cualitativos de experiencia de usuario e impacto pedagógico:

| KPI / Métrica Cualitativa | Calificación | Justificación del Estado Actual |
|---|---|---|
| **Facilidad de Onboarding (Estudiante)** | ⭐⭐⭐⭐☆ | Alta: Los estudiantes nuevos se adaptan rápido gracias al autoregistro directo en el formulario móvil. |
| **Tiempo de Registro en el Aula** | ⭐⭐⭐☆☆ | Medio: El proceso toma segundos si la cámara lee bien, pero estudiantes con fallas de enfoque o señal retrasan el inicio de la clase. |
| **Transparencia en el Cálculo de Horas**| ⭐⭐⭐☆☆ | Media: El estudiante ve cuántas horas se le validaron, pero no recibe un desglose claro de por qué se le descontó tiempo si entró con retraso. |
| **Seguridad Contra Suplantación** | ⭐⭐⭐⭐⭐ | Excelente: El código rotativo y dinámico en bloques de 15 segundos desincentiva eficazmente que se envíen fotos del QR fuera del aula. |
| **Control Administrativo (Coordinador)**| ⭐⭐⭐⭐☆ | Bueno: La bandeja de evidencias y el control de instructores facilita la auditoría del cumplimiento de las clases. |

---

## 3. Evaluación de Necesidad y Valor: ¿Era necesario lo trabajado?

* **¿Era crítico el desarrollo tal como se hizo?**
  El prototipo funcional era **necesario para demostrar el concepto** y cumplir con el hito de la asistencia calificada en clase. Validó que la lógica de retardo fraccionado y el QR rotativo resuelven el problema de la asistencia y la honestidad en el aula.
* **¿Qué cosas no eran necesarias en esta etapa?**
  El equipo dedicó demasiado esfuerzo a estructurar de manera compleja las conexiones a bases de datos relacionales duales y validaciones de red muy estrictas antes de definir cómo resolver la experiencia de los estudiantes que no cuentan con datos móviles, lo cual es el verdadero reto en el salón de clase.

---

## 4. Autorreflexión: ¿En qué fallamos como equipo?

Nuestra principal lección como grupo tras este desarrollo es: **"Los sistemas de información se construyen primero en papel"**.

1. **Apresuramiento por Funcionalidad:** Nos motivó la idea de ver la aplicación corriendo y desplegada. Esto nos hizo ignorar metodologías como **MoSCoW** y **Design Thinking** al inicio, codificando pantallas complejas antes de entender si el usuario final (docentes mayores o aprendices sin cobertura) las usaría fácilmente.
2. **Falta de Empatía en el Salón:** No nos sentamos a "vivir" la clase. Diseñamos bajo el supuesto de que todos los estudiantes tendrían celulares modernos con planes de internet ilimitados y cámaras de alta definición.
3. **El Costo del Retrabajo:** Al saltar directo al código sin una fase de diseño cualitativo en papel, ahora debemos corregir pantallas de error ambiguas y simplificar el flujo de seguridad, lo cual habría sido trivial de solucionar dibujando maquetas al inicio del proyecto.
