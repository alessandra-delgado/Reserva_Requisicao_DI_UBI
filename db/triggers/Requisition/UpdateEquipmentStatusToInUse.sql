drop trigger if exists UpdateEquipmentStatusToInUse;
go
create trigger UpdateEquipmentStatusToInUse
    on Req_Equip
    after insert
    as
begin
    declare @id_equip int;
    declare @id_req int;

    declare equipment_fetch cursor for
        select id_equip, id_req from inserted

    open equipment_fetch;

    fetch next from equipment_fetch into @id_equip, @id_req
    while @@FETCH_STATUS = 0
        begin
            update Equipments set status_equip = 'inUse' where id_equip = @id_equip
            fetch next from equipment_fetch into @id_equip, @id_req
        end
    close equipment_fetch;
    deallocate equipment_fetch;
end;
go