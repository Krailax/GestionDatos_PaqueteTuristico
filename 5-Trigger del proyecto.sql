--TRIGGER CON CURSOR
set serveroutput on;
select r.id_usuario ,count(r.id_tipo_reputacion) AS cantidad_r  from REPUTACION_USUARIO r where r.id_tipo_reputacion ='MALA' group by r.id_usuario ,r.id_tipo_reputacion ;

CREATE OR REPLACE TRIGGER CONTROL_VENTAS_PAQUETE
BEFORE INSERT ON PAQUETE_TURISTICO FOR EACH ROW
DECLARE
CURSOR PERMITIR_PAQUETE IS select r.id_usuario ,count(r.id_tipo_reputacion) AS cantidad_r  from REPUTACION_USUARIO r where r.id_tipo_reputacion ='MALA' group by r.id_usuario ,r.id_tipo_reputacion ;
cantidad int;
id_buscar int;
BEGIN
    cantidad :=0;
    id_buscar := :new.id_usuario;
    for dato in PERMITIR_PAQUETE LOOP
        if(id_buscar = dato.id_usuario) then
            cantidad := dato.cantidad_r;
        end if;
    END LOOP;    
    if cantidad >= 3 then
        RAISE_APPLICATION_ERROR(-20002,'Este cliente esta en lista negra por mal comportamiento');
    end if;
    if cantidad <=2 then
        dbms_output.put_line('Ventas realizada de paquete');
    end if;
END CONTROL_VENTAS_PAQUETE;


--Prueba de funcionamiento
INSERT INTO PAQUETE_TURISTICO VALUES(11,2,4,'ventas sssss',50.50,4); --aqui inserta el valor
INSERT INTO PAQUETE_TURISTICO VALUES(12,1,4,'ventas sssss',50.50,4); --aqui no permite el ingresor del dato