ODS TAGSETS.EXCELXP
file='file_path.xls'
STYLE=minimal
OPTIONS (Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );

PROC SQL;
	title "Table of Generic freq by string search";
	select distinct(lowcase(cm.generic)), count(*) as cnt
	from Work.database1 as cm
		inner join Work.database2 as hc
			on find(lowcase(hc.GNN), lowcase(cm.generic)) > 0
	group by lowcase(cm.generic)
	order by cnt desc;


ODS TAGSETS.EXCELXP CLOSE;
