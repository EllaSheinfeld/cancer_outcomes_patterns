Proc sql;
	Title 'drug1 & drug2 count';
	select (hc.patient_id)
	from Work.database_name as hc
		join (select distinct hc2.patient_id as patient_id
				from Work.database_name as hc2
				where index(lowcase(trim(hc2.GNN)), 'drug1') > 0 or
						index(lowcase(trim(hc2.BN)), 'drug1') > 0) as arbp
				on hc.patient_id = arbp.patient_id
where index(lowcase(trim(hc.GNN)), 'drug2') > 0 or
				index(lowcase(trim(hc.BN)), 'drug2') > 0;
