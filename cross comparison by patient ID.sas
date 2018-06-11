ODS TAGSETS.EXCELXP
file='file_path.xls'
STYLE=minimal
OPTIONS (Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );
PROC SQL;
	title "Cross comparison - patient ID frq";
	select distinct lowcase(cm.generic) as generic, hc.GNN, count(distinct hc.linkid) as cnt
	from Work.database1 as cm
		left join Work.database2 as hc
			on index(lowcase(trim(hc.GNN)), lowcase(trim(cm.generic))) > 0 or
				index(lowcase(trim(hc.BN)), lowcase(trim(cm.brand))) > 0 or
				index(lowcase(trim(hc.GNN)), lowcase(trim(cm.brand))) > 0 or
				index(lowcase(trim(hc.BN)), lowcase(trim(cm.generic))) > 0
	group by lowcase(cm.generic), hc.GNN;
ODS TAGSETS.EXCELXP CLOSE;
