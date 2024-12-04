drop procedure if exists ReservationToRequisition;
GO
create procedure ReservationToRequisition @id_user varchar(10), @id_reserv varchar(8), @time_start DATETIME,
                                          @time_end DATETIME
as
begin
    declare @id_req INT;
    declare @collected INT;

    insert into Requisition (id_user, time_start, time_end, status_req)
    values (@id_user, @time_start, @time_end, 'Active');

    set @id_req = SCOPE_IDENTITY();

    INSERT INTO Req_Equip(re.id_equip, id_req)
    SELECT re.id_equip, @id_req
    from Res_Equip as re
    where re.id_reserv = @id_reserv
      and re.assigned_to = 1;

    SET @collected = @@ROWCOUNT;
    update Requisition
    set Requisition.collected = @collected
    where Requisition.id_req = @id_req;

end;