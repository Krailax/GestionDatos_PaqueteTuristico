create table PAIS(
    id_pais varchar(30) primary key not null
);

create table PROVINCIA(
    id_provincia varchar(30) primary key not null,
    id_pais varchar(30),
    constraint pais_provincia foreign key (id_pais) references PAIS(id_pais) 
);

create table CANTON(
    id_canton varchar(30) primary key not null,
    id_provincia varchar(30),
    constraint provincia_canton foreign key (id_provincia) references PROVINCIA(id_provincia)
);

CREATE TABLE TIPO_USUARIO(
    id_tipo_usuario varchar(30) primary key not null,
    descripcion varchar(30) not null
);

CREATE TABLE TIPO_REPUTACION(
    id_tipo_usuario varchar(30) primary key not null,
    descripcion varchar(30) not null
);

CREATE TABLE SELECION_PAGO(
    id_selecion_pago varchar(30) primary key not null,
    id_descripcion varchar(30) not null
);

CREATE TABLE PAGO(
    id_pago int primary key not null,
    id_selecion_pago varchar(30),
    constraint pago_selecionpago foreign key (id_selecion_pago) references SELECION_PAGO(id_selecion_pago)
);

CREATE TABLE CONTRATACION(
    id_contratacion int primary key not null,
    id_pago int,
    inicio_viaje varchar(30), 
    fin_viaje varchar(30) ,
    fecha_inicio date not null,
    fecha_fin date not null,
    constraint contratacion_pago foreign key (id_pago) references PAGO(id_pago),
    constraint contratacion_i_viaje foreign key (inicio_viaje) references CANTON(id_canton),
    constraint contratacion_f_viaje foreign key (fin_viaje) references CANTON(id_canton)
);

CREATE TABLE PAQUETE_TURISTICO(
    id_paquete int primary key not null,
    id_usuario int ,
    id_contratacion  int,
    id_line_servicios int,
    id_descripcion varchar(30),
    total_pago number(4,4),
    constraint line_paquete foreign key (id_line_servicios) references LINE_SERVICIOS(id_line_servicios),
    constraint paquete_contratacion foreign key (id_contratacion) references CONTRATACION(id_contratacion),
    constraint paquete_usuario foreign key (id_usuario) references Usuario(id_usuario)
);

CREATE TABLE USUARIO(
    id_usuario int primary key not null,
    id_tipo_usuario varchar(30),
    nombre varchar(30) not null,
    apellido varchar(30) not null,
    telefono number(10) not null,
    cedula number(10) not null,
    fecha_ingreso date not null,
    id_selecion_pago varchar(30),
    constraint usuario_selecionapago foreign key (id_selecion_pago) references SELECION_PAGO(id_selecion_pago),
    constraint usuario_tipo_usuario foreign key (id_tipo_usuario) references TIPO_USUARIO(id_tipo_usuario)
);

CREATE TABLE Reputacion_USUARIO(
    id_reputacion int primary key not null,
    id_usuario int,
    id_tipo_reputacion varchar(30),
    descripcion varchar(30),
    constraint reputacion_usuario foreign key (id_usuario) REFERENCES USUARIO(id_usuario),
    constraint reputacion_tipo foreign key (id_tipo_reputacion) REFERENCES TIPO_REPUTACION(id_tipo_reputacion)
);

CREATE TABLE TIPO_SERVICIO(
    id_tipo_servicio varchar(30) primary key not null,
    id_descripcion varchar(30)
);


CREATE TABLE CONVENIO(
    id_convenio varchar(30) primary key not null,
    id_reputacion int,
    contacto_1 varchar(30) not null,
    c_tel_1 number(1)not null,
    contacto_2 varchar(30) not null,
    c_tel_2 number(1) not null,
    contacto_3 varchar(30) ,
    c_tel_3 number(1),
    constraint convenio_reputacion foreign key (id_reputacion) references REPUTACION_USUARIO(id_reputacion)
);


CREATE TABLE SERVICIO(
    id_tipo_servicio varchar(30),
    id_servicio int primary key not null,
    nombre varchar (30) not null,
    id_canton varchar(30),
    id_convenio varchar(30),
    id_pago int,
    ubicacion varchar(30) not null,
    descripcion varchar(30) not null,
    capacidad_persona int,
    precio number(4,2) not null,
    disponibilidad int not null,
    constraint union_convenio foreign key (id_convenio) references CONVENIO(id_convenio),
    constraint union_canton foreign key (id_canton) references CANTON(id_canton),
    constraint union_servicios foreign key (id_tipo_servicio) references TIPO_SERVICIO(id_tipo_servicio),
    constraint union_pago foreign key (id_pago) references Pago(id_pago)
);


CREATE TABLE LINE_SERVICIOS(
    id_line_servicios int primary key,
    id_paquete_turistico int,
    id_servicios int,
    constraint line_a_servicios foreign key (id_servicios) references SERVICIO(id_servicio),
    constraint line_a_paquetess foreign key (id_paquete_turistico) references PAQUETE_TURISTICO(id_paquete)
);
