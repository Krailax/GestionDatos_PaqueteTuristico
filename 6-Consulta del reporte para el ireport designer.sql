--Consulta utilizada para el ireport designer : muestra la ganancia total anual
select reporte.fecha , sum(reporte.suma) from (select  extract(year from c.fecha_inicio) fecha ,sum(p.total_pago)suma from paquete_turistico p 
inner join  contratacion c on c.id_contratacion = p.id_contratacion
group by c.fecha_inicio ) reporte
group by reporte.fecha