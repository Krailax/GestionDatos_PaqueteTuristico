/*HISTORICO DE VENTA DE AGENTE[AÑO,NOMBRE,TIPO DE PAQUETE , CANTIDAD DE PAQUETE VENDIDO]*/
select extract(YEAR FROM c.fecha_ingreso) AÑO, c.nombre NOMBRE_AGENTE ,p.id_descripcion TIPO_PAQUETE , p.cantidad Cantidad_Vendidad
from USUARIO c inner join   PAQUETE_TURISTICO p 
on c.id_usuario= p.id_usuario and c.id_tipo_usuario='AGENTE';


/*HISTORICO DE LOCALES POR PAQUETE [AÑO,LUGAR,CANTIDAD DE PAQUETE A MAYOR A MENOR]*/
select max (extract(YEAR FROM w.fecha_inicio)),s.nombre,s.id_canton, count(l.id_servicios) as CANTIDAD_SERVICIO from SERVICIO s
inner join line_servicios l on l.id_servicios = s.id_servicio
inner join paquete_turistico t on t.id_paquete = l.id_paquete_turistico
inner join contratacion w on w.id_contratacion = t.id_contratacion
group by  l.id_servicios ,s.id_canton , s.nombre
order by l.id_servicios desc;

/*HISTORICO DE COMPRA POR CLIENTE WEB [AÑO,NOMBRE,CANTIAD DE PAQUETE,DINERO TOTAL]*/
select extract(YEAR FROM c.fecha_ingreso) AÑO, c.nombre NOMBRE_AGENTE , p.cantidad , p.total_pago 
from USUARIO c  inner join  PAQUETE_TURISTICO p 
on c.id_usuario= p.id_usuario and c.id_tipo_usuario='CLIENTE_VIRTUAL'
;

/*HISTORICO DE SASTIFACION [AÑO , LUGARA VISITAR , REPUTACION]*/
select extract(YEAR FROM w.fecha_inicio),s.id_canton ,d.id_tipo_reputacion from SERVICIO s
inner join CONVENIO c on s.id_convenio  = c.id_convenio 
inner join reputacion_usuario d on d.id_reputacion = c.id_reputacion
inner join line_servicios l on l.id_servicios = s.id_servicio
inner join paquete_turistico t on t.id_paquete = l.id_paquete_turistico
inner join contratacion w on w.id_contratacion = t.id_contratacion;

