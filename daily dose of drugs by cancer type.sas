Option nofmterr;
ODS TAGSETS.EXCELXP
file='file_path.xls'
STYLE=minimal
OPTIONS (Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );

Proc SQL;
	select (input(TRANWRD(hc.STR, "MG",""), 4.) * hc.QTY_DSPNSD_NUM)/hc.DAYS_SUPLY_NUM as daily_dose, hc.GNN , cct.linkid <> '' as has_mel_or_lym
	from Work.database1 as hc
		left join (select *
					from Work.database2 as cct
					where cct.siterwho1 like '33011%' or
					cct.siterwho1 like '33012%' or
					cct.siterwho1 like '33041%' or
					cct.siterwho1 like '33042%' or
					cct.siterwho1 like '34000%') as cct
		on hc.linkid = cct.linkid
	where
			(index(lowcase(trim(hc.GNN)), 'drug1') > 0 or
				index(lowcase(trim(hc.BN)), 'drug1') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug2') > 0 or
				index(lowcase(trim(hc.BN)), 'drug2') > 0) and
			lowcase(trim(hc.STR)) like '%mg';


PROC SQL;
	title "liquids";
	select input(TRANWRD(SCAN(hc.STR,1,"/"), "MG",""), 4.) as f, input(TRANWRD(IFC(SCAN(hc.STR,2,"/") = "ML", "1ML", SCAN(hc.STR,2,"/")), "ML",""), 4.) as s, (input(TRANWRD(SCAN(hc.STR,1,"/"), "MG",""), 3.)/input(TRANWRD(SCAN(hc.STR,2,"/"), "ML",""), 3.)) * (hc.QTY_DSPNSD_NUM/hc.DAYS_SUPLY_NUM) as daily_dose, hc.GNN , cct.linkid <> '' as has_mel_or_lym
	from Work.database1 as hc
		left join (select *
					from Work.database2 as cct
					where cct.siterwho1 like '33011%' or
					cct.siterwho1 like '33012%' or
					cct.siterwho1 like '33041%' or
					cct.siterwho1 like '33042%' or
					cct.siterwho1 like '34000%') as cct
		on hc.linkid = cct.linkid
	where
			(index(lowcase(trim(hc.GNN)), 'drug1') > 0 or
				index(lowcase(trim(hc.BN)), 'drug1') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug2') > 0 or
				index(lowcase(trim(hc.BN)), 'drug2') > 0) and
			lowcase(trim(hc.STR)) like '%mg%ml';

run;
ODS TAGSETS.EXCELXP CLOSE;
