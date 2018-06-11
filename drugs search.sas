ODS TAGSETS.EXCELXP
file='file_path.xls'
STYLE=minimal
OPTIONS (Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );
PROC SQL;
	title "Drugs Search";
	select *
	from Work.database1 as hc
	where index(lowcase(trim(hc.GNN)), 'drug1') > 0 or
				index(lowcase(trim(hc.BN)), 'drug1') > 0 or
				index(lowcase(trim(hc.GNN)), 'drug2') > 0 or
				index(lowcase(trim(hc.BN)), 'drug2') > 0;
ODS TAGSETS.EXCELXP CLOSE;
