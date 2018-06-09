proc sql;
   title 'Oral Chemo Frequencies';
	select distinct(cm.generic), count(*) as cnt
	from Work.database1 as cm, Work.database2 as mh
	where lowcase(cm.generic) = lowcase(mh.GNN)
	group by cm.generic
	order by cnt desc;
   title 'Generic names in database1 that are missing from database2';
	select distinct(lowcase(cmm.generic))
	from Work.database1 as cmm
	where lowcase(cmm.generic) not in ( 	select distinct(cm.generic)
								from Work.database1 as cm, Work.database2 as mh
								where lowcase(cm.generic) = lowcase(mh.GNN));
   title 'Generic names in database2 that are missing from database1';
	select distinct(lowcase(mhh.GNN))
	from Work.database2 as mhh
	where lowcase(mhh.GNN) not in (select distinct(cm.generic)
									from Work.database1 as cm, Work.database2 as mh
									where lowcase(cm.generic) = lowcase(mh.GNN));
