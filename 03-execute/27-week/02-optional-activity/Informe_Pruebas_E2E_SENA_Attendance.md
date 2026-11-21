# Informe Técnico de Pruebas End-to-End (E2E) — Sistema de Asistencia SENA

**Proyecto:** Sistema de Control de Asistencia SENA (`SENA Attendance`)  
**Arquitectura bajo prueba:** Arquitectura de 7 Capas (`N = 7`: Experiencia, Presentación HTTP, Aplicación, Dominio Puro, Puertos, Persistencia, Infraestructura)  
**Aprendiz:** Tomás Barrera Ortiz  
**Programa / Ficha:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Semana:** Semana 27 · 21 de noviembre de 2026  

---

## 1. ¿Qué son las Pruebas End-to-End (E2E)?

Las **pruebas End-to-End (de extremo a extremo)** validan el comportamiento completo de una aplicación simulando escenarios reales de usuario desde la interfaz web hasta la base de datos y de regreso, atravesando todas las capas del sistema (Frontend SPA, API REST Express, reglas de negocio de Dominio, seguridad JWT/RBAC y motor SQLite/PostgreSQL).

A diferencia de las pruebas unitarias (que verifican una función aislada), las pruebas E2E garantizan que **los flujos críticos del negocio funcionan integrados** sin errores de contrato, permisos, persistencia ni experiencia de usuario.

---

## 2. Estrategia y Alcance de Pruebas Ejecutadas

Se ejecutaron **dos niveles complementarios de validación E2E** el 21 de noviembre de 2026 sobre el código real de `Sistema-de-asistencia`:

1. **Suite Completa Backend + API E2E (`npm test` → `backend/tests/run-all.js`):**
   - **10 suites automatizadas** que cubren salud (`/health`, `/ready`), rotación criptográfica de QR (`HMAC` 15 s), cálculo de bloques de puntualidad (`BR-02`), reglas puras de dominio, fronteras de 7 capas, invariantes de gobernanza (`BR-01` a `BR-12`), **flujos E2E de las Fases 1 a 4 (`e2e-discovery.test.js`)**, asignación instructor-ficha y auditoría de seguridad (`19/19` controles).
2. **Suite E2E en Navegador Real (`e2e_browser_sena_attendance.py` — Playwright + Google Chrome):**
   - Levanta el servidor Express + SQLite real en `http://127.0.0.1:4319` y ejecuta un navegador **Google Chrome** automatizado contra `frontend/index.html` validando renderizado, accesibilidad, autenticación real por roles, QR dinámico y 0 excepciones JavaScript.

---

## 3. Resultados de Ejecución Real (21-11-2026)

### 3.1 Resumen Ejecutivo de Métricas

| Indicador | Resultado Real | Criterio de Aceptación | Estado |
| :--- | :---: | :---: | :---: |
| **Suites Backend + API E2E (`npm test`)** | **10 / 10 PASS** (`4.22 s`) | 100 % suites en verde | ✅ CUMPLE |
| **Flujos API E2E Hoja de Ruta (`e2e-discovery.test.js`)** | **10 / 10 escenarios PASS** | Fases 1 a 4 completas | ✅ CUMPLE |
| **Pruebas E2E Navegador Real (Playwright + Chrome)** | **5 / 5 PASS** (`0` errores JS) | Flujos UI críticos sin fallos | ✅ CUMPLE |
| **Controles de Auditoría de Seguridad y Dominio** | **19 / 19 PASS** (`0` hallazgos) | 0 hallazgos críticos/altos | ✅ CUMPLE |
| **Benchmark de Concurrencia (`NFR-01`, 60 reqs)** | **`p95 = 99.70 ms`** (`p50 = 74.38 ms`) | `p95 < 300 ms` | ✅ CUMPLE |

---

### 3.2 Matriz de Casos E2E API (`e2e-discovery.test.js` — Fases 1 a 4)

| ID | Fase | Flujo End-to-End Validado | Resultado Esperado / Verificado | Estado |
| :---: | :---: | :--- | :--- | :---: |
| **E2E-API-01** | Fase 1 | Consulta de catálogo público (`GET /public/fichas`) | HTTP `200`, retorna arreglo con fichas activas institucionales | ✅ PASS |
| **E2E-API-02** | Fase 1 | Auto-registro de aprendiz (`POST /public/student/register`) | HTTP `201`, vincula ficha y emite token JWT válido | ✅ PASS |
| **E2E-API-03** | Fase 1 | Login bidireccional (por documento y por correo `@misena.edu.co`) | HTTP `200` en ambos modos | ✅ PASS |
| **E2E-API-04** | Fase 1 | Recuperación de clave (`forgot-password` + `reset-password`) | HTTP `200`, **nunca expone `resetToken` en HTTP**, token hash de 1 solo uso | ✅ PASS |
| **E2E-API-05** | Fase 2 | Detección de aula activa (`GET /api/student/active-session`) | HTTP `200`, retorna bandera `hasActiveSession` | ✅ PASS |
| **E2E-API-06** | Fase 2 | Apertura de sala QR por Instructor + check-in aprendiz con código de 6 caracteres | HTTP `201` sala → HTTP `200` asistencia `accepted` sin re-login | ✅ PASS |
| **E2E-API-07** | Fase 3 | **Regla de 4 Ojos (`BR-08`)** en baja de ficha académica | Coord 1 radica (`202`), autoaprobación bloqueada (`403`), Coord 2 aprueba (`200`) | ✅ PASS |
| **E2E-API-08** | Fase 3 | Auditoría inmutable (`GET /api/coord/audit-logs`) | Registra evento `APPROVE_FICHA_DELETION` con trazabilidad completa | ✅ PASS |
| **E2E-API-09** | Fase 4 | Gate de verificación de clave actual (`POST /api/auth/verify-password`) | Clave errónea `401`, clave correcta `200` (`verified: true`) | ✅ PASS |
| **E2E-API-10** | Fase 4 | **Habeas Data (Ley 1581 / `BR-11`)** (`DELETE /api/student/delete-account`) | HTTP `200`, cuenta inactiva (`active=0`), `APRENDIZ_ANONIMIZADO` sin romper FKs | ✅ PASS |

---

### 3.3 Matriz de Casos E2E en Navegador Real (`e2e_browser_sena_attendance.py`)

| ID | Escenario en Google Chrome (Playwright) | Validaciones Realizadas | Evidencia Capturada | Estado |
| :---: | :--- | :--- | :--- | :---: |
| **E2E-UI-01** | Carga del Portal Unificado SENA | Logo oficial (`alt="SENA"`), campo código rápido 6 chars, 0 credenciales demo precargadas | `evidencias_e2e/01_portal_unificado_sena.png` | ✅ PASS |
| **E2E-UI-02** | Credenciales inválidas (`401`) | Región accesible `#loginFeedback` (`role="alert"`) muestra `"Credenciales inválidas."` | Registro JSON | ✅ PASS |
| **E2E-UI-03** | Login unificado de Instructor (`1079606375`) | Carga rol `INSTRUCTOR`, tablero en tiempo real, controles de sala y **Código QR Dinámico** | `evidencias_e2e/02_panel_instructor.png` | ✅ PASS |
| **E2E-UI-04** | Login unificado de Aprendiz (`1077228780`) | Carga rol `APRENDIZ` (`Tomas Berserk`), estado de aula activa y campo código de 6 caracteres | `evidencias_e2e/03_panel_aprendiz.png` | ✅ PASS |
| **E2E-UI-05** | Cierre de sesión y estabilidad JS | Retorno limpio a `#portalScreen` y **0 excepciones JavaScript no controladas** | `evidencias_e2e/e2e_browser_results.json` | ✅ PASS |

---

## 4. Controles Críticos Adicionales Verificados

- **Seguridad RBAC (7/7):** Un aprendiz recibe `403 Forbidden` al intentar crear/cerrar salas, hacer *override*, resolver excusas o descargar evidencias ajenas; un instructor no asignado no puede abrir fichas ajenas ni usar rutas de coordinación.
- **Integridad de Dominio y Resiliencia Offline:**
  - `BR-02` (puntualidad): 15 min tolerancia (`6 h`), 15:01 (`5 h`), 60:01 (`4 h`).
  - `BR-03` (QR): rotación HMAC cada 15 s + 1 franja de tolerancia.
  - `BR-07` (excusas): 3 días hábiles descontando fines de semana y festivos colombianos; aprobar restaura exactamente `6 h` (`BR-09`).
  - `offline-queue.js`: deduplica el mismo check-in sin conexión y lo sincroniza automáticamente al recuperar red.

---

## 5. Artefactos Entregados en la Semana 27

1. **`Informe_Pruebas_E2E_SENA_Attendance.md`** — Este informe técnico con trazabilidad completa.
2. **`Presentacion_Pruebas_E2E_SENA_Attendance.pptx`** — Presentación ejecutiva y técnica para sustentación.
3. **`e2e_browser_sena_attendance.py`** — Script ejecutable de pruebas E2E en navegador real (Playwright + Chrome).
4. **`e2e-discovery.test.js`** — Suite automatizada de pruebas E2E de API (Fases 1 a 4).
5. **`evidencias_e2e/`** — Capturas reales de ejecución en navegador (`01_portal_unificado_sena.png`, `02_panel_instructor.png`, `03_panel_aprendiz.png`) y reporte JSON (`e2e_browser_results.json`).
