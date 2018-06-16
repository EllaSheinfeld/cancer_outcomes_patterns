ODS TAGSETS.EXCELXP
file='file_path.xls'
STYLE=minimal
OPTIONS (Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );
option nofmterr;
proc sql;
	create table Work.YearBefore
		(linkid char(11), date num informat=date9. format=date9., GNN char(29))
		;
	insert into Work.YearBefore
	select distinct hc.linkid,mdy(input(hc.srvc_mon,2.), input(hc.srvc_day,2.), input(hc.srvc_yr,4.)), hc.GNN
	from Work.database1 as hc
		inner join (select *
					from Work.database2 as cct
					where cct.siterwho1 = '26000') as cct
		on hc.linkid = cct.linkid
	where (index(lowcase(trim(hc.GNN)), 'drug1') > 0 or
				index(lowcase(trim(hc.BN)), 'drug1') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug2') > 0 or
				index(lowcase(trim(hc.BN)), 'drug2') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug3') > 0 or
				index(lowcase(trim(hc.BN)), 'drug3') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug4') > 0 or
				index(lowcase(trim(hc.BN)), 'drug4') > 0) and
		 (0 < INTCK('DAY',
		 		mdy(input(hc.srvc_mon,2.), input(hc.srvc_day,2.), input(hc.srvc_yr,4.)),
				hc.SRVDATE) <= 365);

proc transpose data=Work.YearBefore out=Work.YearBeforeTransposed prefix=Drug;
 var GNN;
 by linkid;
run;
proc sql;
	select *
	from Work.YearBeforeTransposed;
run;
ODS TAGSETS.EXCELXP CLOSE;
