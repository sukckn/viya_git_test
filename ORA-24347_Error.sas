proc ds2;
data _null_;
dcl package sqlstmt sqlQuery;
dcl double RESPONSE_DTTM;

	method run();
		dcl varchar(250) conn sqlStmt;
		dcl int rc;
		
		conn= 'driver=sql;conopts=(DRIVER=ORACLE;CATALOG=sas_core;USER=SAS_CORE;PASSWORD=BRXyMswXBCQJ9bmAGt9Q;PATH=gsz-oracle.emea.sas.com:1521;SCHEMA=SAS_CORE)';

		sqlStmt= 'select rh.response_dttm AS RESPONSE_DTTM 
                    from ci360_v_contact_history_da vch 
                  left join ci360_t_response_history rh on vch.contact_id = rh.contact_id';

		sqlQuery= _new_ sqlstmt(sqlStmt, conn);
		sqlQuery.execute();  

		rc= 0;
		do while (rc = 0);
			rc= sqlQuery.fetch([RESPONSE_DTTM]);
		end;
	end;
enddata;
run; quit;