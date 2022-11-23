--CURSOR
set serveroutput on;
DECLARE 
    CURSOR Ventas_Servicios is select EXTRACT(YEAR from c.fecha_inicio) as AÑO  ,e.nombre , count(l.id_servicios) as Cantidad , g.id_selecion_pago as Tipo_Pago from LINE_SERVICIOS l 
inner join servicio e on e.id_servicio = l.id_servicios
inner join pago g on g.id_pago = e.id_pago
inner join paquete_turistico p on l.id_paquete_turistico = p.id_paquete 
inner join contratacion c on p.id_contratacion = c.id_contratacion
group by c.fecha_inicio ,e.nombre ,l.id_servicios ,g.id_selecion_pago  ;
suma int;
BEGIN 
    suma:=0;
    for Datos in Ventas_Servicios loop
        suma:= suma +datos.cantidad;      
        dbms_output.put_line('En el año '||datos.año ||' el servicios '||datos.nombre||' vendio '||datos.cantidad|| ' en formar '||datos.tipo_pago);
    end loop;
    dbms_output.put_line('Cantidad vendidas total : ' || suma);
END;
