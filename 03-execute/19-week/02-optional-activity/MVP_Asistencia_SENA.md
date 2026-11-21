# Socialización MVP — Sistema de Asistencia SENA (Semana 19)

**Aprendiz:** Tomás Barrera Ortiz  
**Programa / Ficha:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Actividad:** Socialización del Producto Mínimo Viable (MVP)  

---

## Enlace de Despliegue (Vercel)

- **Aplicación desplegada en producción:** https://ejemplo-sigma.vercel.app/

---

## Resumen del MVP Socializado

El MVP expuesto corresponde al **Sistema de Control de Asistencia SENA (`SENA Attendance`)**, diseñado para agilizar el llamado a lista en ambiente de formación, eliminar errores manuales y prevenir registros fraudulentos fuera del aula.

### Funcionalidades clave demostradas en el MVP
1. **Acceso Unificado por Rol:** Portal único para Aprendiz, Instructor y Coordinador Académico.
2. **Sesión de Clase con QR Dinámico:** Generación de código QR rotativo y código manual de 6 caracteres para contingencia (cuando la cámara del dispositivo no funciona).
3. **Registro Rápido de Asistencia:** Marcado ágil en aula con cálculo automático de puntualidad (tolerancia de 15 minutos y bloques horarios de retardo).
4. **Gestión de Excusas y Reportes:** Radicación de justificaciones, seguimiento por ficha y exportación de reportes para trazabilidad institucional.
5. **Resiliencia en Aula:** Soporte para registro manual de contingencia (*override* docente) y cola *offline* ante caídas temporales de conectividad.
