DROP TABLE HR.CONVOCATORIA_AULA_VIRTUAL PURGE;
DROP TABLE HR.CAPITULO_MODULO PURGE;
DROP TABLE HR.MODULO_PROFESOR PURGE;
DROP TABLE HR.CURSO_PROFESOR PURGE;
DROP TABLE HR.CURSO_MODULO PURGE;
DROP TABLE HR.ACADEMIA PURGE;
DROP TABLE HR.MATRICULA PURGE;
DROP TABLE HR.CONVOCATORIA PURGE;
DROP TABLE HR.SESION PURGE;
DROP TABLE HR.AULA_VIRTUAL PURGE;
DROP TABLE HR.CURSO PURGE;
DROP TABLE HR.MODULO PURGE;
DROP TABLE HR.CAPITULO PURGE;
DROP TABLE HR.PROFESOR PURGE;
DROP TABLE HR.ESTUDIANTE PURGE;
DROP TABLE HR.PERSONA PURGE;


CREATE TABLE HR.PERSONA (
	DNI CHAR(9) NULL,
	APELLIDOS VARCHAR2(100) NULL,
	NOMBRE VARCHAR2(100) NULL,
	CONSTRAINT PERSONA_PK PRIMARY KEY (DNI)
);

CREATE TABLE HR.ESTUDIANTE (
	DNI CHAR(9) NULL,
	TELEFONO CHAR(9) NULL,
	CONSTRAINT ESTUDIANTE_PK PRIMARY KEY (DNI)
);

CREATE TABLE HR.PROFESOR (
	DNI CHAR(9) NULL,
	CONSTRAINT PROFESOR_PK PRIMARY KEY (DNI)
);

CREATE TABLE HR.CAPITULO (
	IDENTIFICADOR NUMBER(5,0) NULL,
	DURACION_EJERCICIOS CHAR(5) NULL,
	DURACION_TEORIA CHAR(5) NULL,
	DURACION_TUTORIAL CHAR(5) NULL,
	CONSTRAINT CAPITULO_PK PRIMARY KEY (IDENTIFICADOR)
);

CREATE TABLE HR.MODULO (
	IDENTIFICADOR CHAR(7) NULL,
	NOMBRE VARCHAR2(100) NULL,
	CONSTRAINT MODULO_PK PRIMARY KEY (IDENTIFICADOR)
);

CREATE TABLE HR.CURSO (
	IDENTIFICADOR CHAR(7) NULL,
	COSTE NUMBER(6,2) NULL,
	COSTE_MATRICULA NUMBER(6,2) NULL,
	DURACION_CURSO CHAR(6) NULL,
	NOMBRE VARCHAR2(100) NULL,
	CONSTRAINT CURSO_PK PRIMARY KEY (IDENTIFICADOR)
);

CREATE TABLE HR.AULA_VIRTUAL (
	IDENTIFICADOR CHAR(4) NULL,
	CAPACIDAD NUMBER(2,0) NULL,
	CONSTRAINT AULA_VIRTUAL_PK PRIMARY KEY (IDENTIFICADOR)
);

CREATE TABLE HR.SESION (
	AULA_ID CHAR(4) NULL,
	FECHA_HORA_INICIO DATE NULL,
	FECHA_HORA_FINALIZACION DATE NULL,
	CHAT CLOB NULL,
	VIDEO BLOB NULL,
	PROFESOR_DNI CHAR(9) NULL,
	CONSTRAINT SESION_PK PRIMARY KEY (AULA_ID,FECHA_HORA_INICIO),
	CONSTRAINT FK_AULA_VIRTUAL FOREIGN KEY (AULA_ID) REFERENCES HR.AULA_VIRTUAL(IDENTIFICADOR),
	CONSTRAINT FK_PROFESOR FOREIGN KEY (PROFESOR_DNI) REFERENCES HR.PROFESOR(DNI)
);

CREATE TABLE HR.CONVOCATORIA (
	IDENTIFICADOR CHAR(7) NULL,
	FECHA_INICIO DATE NULL,
	FECHA_FINALIZACION DATE NULL,
	CURSO CHAR(7) NULL,
	CONSTRAINT CONVOCATORIA_PK PRIMARY KEY (IDENTIFICADOR),
	CONSTRAINT FK_CURSO FOREIGN KEY (CURSO) REFERENCES HR.CURSO(IDENTIFICADOR)
);

CREATE TABLE HR.ACADEMIA (
	DIAS_LABORALES CHAR(7) NULL,
	HORA_APERTURA CHAR(5) NULL,
	HORA_CIERRE CHAR(5) NULL
);

CREATE TABLE HR.MATRICULA (
	CANTIDAD_PAGADA NUMBER(6,2) NULL,
	FECHA_INSCRIPCION DATE NULL,
	PERSONA_DNI CHAR(9) NULL,
	CONVOCATORIA_ID CHAR(7) NULL,
	CONSTRAINT MATRICULA_PK PRIMARY KEY (PERSONA_DNI,CONVOCATORIA_ID),
	CONSTRAINT FK_MATRICULA_PERSONA FOREIGN KEY (PERSONA_DNI) REFERENCES HR.PERSONA(DNI),
	CONSTRAINT FK_CONVOCATORIA FOREIGN KEY (CONVOCATORIA_ID) REFERENCES HR.CONVOCATORIA(IDENTIFICADOR)
);

CREATE TABLE HR.CURSO_MODULO (
	CURSO_ID CHAR(7) NULL,
	MODULO_ID CHAR(7) NULL,
	CONSTRAINT CURSO_MODULO_PK PRIMARY KEY (CURSO_ID,MODULO_ID),
	CONSTRAINT FK_CURSO_MODULO_CURSO FOREIGN KEY (CURSO_ID) REFERENCES HR.CURSO(IDENTIFICADOR),
	CONSTRAINT FK_CURSO_MODULO_MODULO FOREIGN KEY (MODULO_ID) REFERENCES HR.MODULO(IDENTIFICADOR)
);

CREATE TABLE HR.CURSO_PROFESOR (
	CURSO_ID CHAR(7) NULL,
	PROFESOR_DNI CHAR(9) NULL,
	CONSTRAINT CURSO_PROFESOR_PK PRIMARY KEY (CURSO_ID,PROFESOR_DNI),
	CONSTRAINT FK_CURSO_PROFESOR_CURSO FOREIGN KEY (CURSO_ID) REFERENCES HR.CURSO(IDENTIFICADOR),
	CONSTRAINT FK_CURSO_PROFESOR_PROFESOR FOREIGN KEY (PROFESOR_DNI) REFERENCES HR.PROFESOR(DNI)
);

CREATE TABLE HR.MODULO_PROFESOR (
	MODULO_ID CHAR(7) NULL,
	PROFESOR_DNI CHAR(9) NULL,
	CONSTRAINT MODULO_PROFESOR_PK PRIMARY KEY (MODULO_ID,PROFESOR_DNI),
	CONSTRAINT FK_MODULO_PROFESOR_MODULO FOREIGN KEY (MODULO_ID) REFERENCES HR.MODULO(IDENTIFICADOR),
	CONSTRAINT FK_MODULO_PROFESOR_PROFESOR FOREIGN KEY (PROFESOR_DNI) REFERENCES HR.PROFESOR(DNI)
);

CREATE TABLE HR.CAPITULO_MODULO (
	CAPITULO_ID NUMBER(5,0) NULL,
	MODULO_ID CHAR(7) NULL,
	CONSTRAINT CAPITULO_MODULO_PK PRIMARY KEY (CAPITULO_ID,MODULO_ID),
	CONSTRAINT FK_CAPITULO_MODULO_CAPITULO FOREIGN KEY (CAPITULO_ID) REFERENCES HR.CAPITULO(IDENTIFICADOR),
	CONSTRAINT FK_CAPITULO_MODULO_MODULO FOREIGN KEY (MODULO_ID) REFERENCES HR.MODULO(IDENTIFICADOR)
);

CREATE TABLE HR.CONVOCATORIA_AULA_VIRTUAL (
	CONVOCATORIA_ID CHAR(7) NULL,
	AULA_ID CHAR(4) NULL,
	CONSTRAINT CONVOCATORIA_AULA_VIRTUAL_PK PRIMARY KEY (CONVOCATORIA_ID,AULA_ID),
	CONSTRAINT FK_C_AV_CONVOCATORIA FOREIGN KEY (CONVOCATORIA_ID) REFERENCES HR.CONVOCATORIA(IDENTIFICADOR),
	CONSTRAINT FK_C_AV_AULA_VIRTUAL FOREIGN KEY (AULA_ID) REFERENCES HR.AULA_VIRTUAL(IDENTIFICADOR)
);
