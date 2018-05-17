select * from hrmresource;

update hrmresource set lastname =replace (LASTNAME,'(zz)','') ;
commit;
rollback ;
