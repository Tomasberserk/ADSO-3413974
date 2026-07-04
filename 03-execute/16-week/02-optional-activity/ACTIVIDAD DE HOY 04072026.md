ACTIVIDAD DE HOY 04/07/2026



Aplicativo/sistema llamado de Asistencia



Ingeniería de requerimentos:

&#x09;instrumento de recolección de información: Entrevista 



PREGUNTAS:

1¿Puede describir paso a paso cómo llama a lista actualmente en Sofia Plus?

2\. En promedio, ¿cuánto tiempo le toma registrar la asistencia de los 30 aprendices?

3\. ¿En qué momento de la sesión realiza el llamado y por qué?

4\. ¿La plataforma le carga la lista de la ficha automáticamente o debe buscarla/filtrarla

cada vez?

5\. ¿Qué es lo que más le incomoda o le hace perder tiempo al momento de llamar a lista?

6\. ¿Ha tenido problemas de lentitud, caídas o que la plataforma no guarde los cambios?

7\. ¿Le ha tocado repetir el registro o corregir errores? ¿Con qué frecuencia?

8\. ¿Qué tan fácil o difícil resulta marcar tardanzas, excusas o inasistencias justificadas?

9\. ¿La plataforma le funciona bien cuando no tiene buena conexión a internet?

10.En una escala de 1 a 5, ¿qué tan satisfecho está con el sistema actual de asistencia y

por qué?

11\. ¿Cómo afecta el tiempo que gasta en el llamado al desarrollo normal de la clase?

12\. Si pudiera cambiar una sola cosa del proceso de llamado, ¿cuál sería?

13\. ¿Qué funciones le gustaría que tuviera un sistema ideal (marcado rápido, uso desde el

celular, modo sin conexión, etc.)?

14\. ¿Le sería útil marcar a todos como “presentes” y solo cambiar las excepciones? ¿Por

qué?

15\. ¿Consideraría útil un historial por aprendiz para observar su comportamiento de

asistencia?

16\. ¿Hay algo más que quiera agregar sobre el proceso de asistencia que no le haya

preguntado?





REQUISITOS FUNCIONALES



ID		Nombre		Descripción		Prioridad

RF-01	Cargar lista de la ficha	El sistema debe cargar automáticamente el listado de los 30 aprendices activos de la ficha 34113974 al iniciar una sesión de asistencia.	Alta

|ID|NOMBRE|DESCRIPCION|PRIORIDAD|
|-|-|-|-|
|RNF-01|Cargar lista de la ficha|El sistema debe cargar automáticamente el listado de los 30 aprendices activos de la ficha 34113974 al iniciar una sesión de asistencia.|Alta|
|RNF-02|Marcado rápido masivo|Debe permitir marcar por defecto a todos los aprendices como “Presente” y modificar únicamente las excepciones.|Alta|
|RNF-03|Registrar estado de asistencia|Debe permitir asignar a cada aprendiz un estado: Presente, Ausente, Tarde o Excusa justificada.|Alta|
|RNF-04<br />|Registrar hora de llegada|Al marcar el estado “Tarde”, el sistema debe registrar automáticamente la hora de llegada del aprendiz.|Media|
|RNF-05|Registrar justificación|Debe permitir adjuntar el motivo y un soporte a las inasistencias justificadas.|Media|
|RNF-06|Buscar aprendiz|Debe permitir buscar un aprendiz por nombre o número de documento dentro de la lista.|Media|
|RNF-07|Editar registro|Debe permitir corregir la asistencia dentro de una ventana de tiempo definida tras cerrar el llamado.|Media|
|RNF-08|Operar sin conexión|Debe permitir registrar la asistencia sin conexión y sincronizar los datos al recuperar internet.|Media|











REQUISITOS NO FUNCIONALES


|ID|NOMBRE|DESCRIPCION|PRIORIDAD|
|-|-|-|-|
|RF-01|Usabilidad|El llamado completo de los 30 aprendices no debe requerir más de 5 toques/clics en el flujo de marcado rápido.|Alta|
|RF-02|Rendimiento|La lista debe cargar en menos de 2 segundos y cada marcación debe registrarse en menos de 300 ms.|Alta|
|RF-03|Eficiencia (tiempo)|El proceso completo de llamado no debe superar 1 minuto en condiciones normales de operación.|Alta|
|RF-04<br />|Compatibilidad|Debe funcionar en navegador de escritorio y en dispositivos móviles mediante diseño responsive.|Media|
|RF-05|Disponibilidad|El sistema debe estar disponible al menos el 99% del horario de formación.|Media|
|RF-06|Buscar aprendiz|Debe permitir buscar un aprendiz por nombre o número de documento dentro de la lista.|Media|
|RF-07|Confiabilidad|No debe perder registros ante fallos de conexión, apoyándose en guardado local temporal.|Media|
|RF-08|Seguridad|El acceso debe restringirse por roles (instructor, coordinador) y proteger los datos conforme a la Ley 1581 de 2012.|Media|



