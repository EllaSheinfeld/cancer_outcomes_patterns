
ods pdf file='file_path.pdf';


PROC SQL;

	create table Work.tempdist
		(str char(10), QTY_DSPNSD_NUM num, DAYS_SUPLY_NUM num, dose num);

	insert into Work.tempdist
	select hc.STR, hc.QTY_DSPNSD_NUM, hc.DAYS_SUPLY_NUM, (input(TRANWRD(hc.STR, "MG",""), 2.) * hc.QTY_DSPNSD_NUM)/hc.DAYS_SUPLY_NUM as dose
	from Work.database1 as hc
	where (index(lowcase(trim(hc.GNN)), 'drug1') > 0 or
				index(lowcase(trim(hc.BN)), 'drug1') > 0) and
				lowcase(trim(hc.STR)) like '%mg';
run;

proc univariate data=WORK.tempdist;
	var dose;
	histogram;
run;

proc sql;
	drop table Work.tempdist;
run;
ods pdf close;
