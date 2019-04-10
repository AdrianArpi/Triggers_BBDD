set serveroutput on
create or replace trigger mod_auditar after delete or insert on empleado for each row --Se ejecutara una sola vez
BEGIN --Si no escribimos for each row, se ejecuta una sola vez, no tiene sentido poneer :old.nombre
	if deleting then
		dbms_output.put_line(' Se ha eliminado en tcliente');
	end if;
	if inserting then
		insert into auditarempleado
			values(to_char(sysdate, 'dd/mm/yyyy--hh24:mi')|| '  '
				|| :new.num_emp || ' ' || :new.nombre || ' INSERCION');
		dbms_output.put_line(' Se ha actualizado en tcliente');
	end if;
	dbms_output.put_line(' Se ha borrado a ' || :old.nombre); --Con esta opcion podemos acceder a cada uno de los parametros de la tabla
END;
/

--El trigger debe corregirse