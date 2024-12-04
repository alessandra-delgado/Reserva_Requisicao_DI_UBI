drop trigger if exists ReservationToSatisfied;
go
create trigger ReservationToSatisfied
    on Reservation
    after update
    as
    if (update(status_res))
        begin
            declare @id_user varchar(10);
            declare @id_reserv varchar(8);
            declare @time_start DATETIME;
            declare @time_end DATETIME;

            declare for_satisfied cursor for
                select id_user, id_reserv, time_start, time_end
                from inserted
                where status_res like 'Satisfied'

            open for_satisfied;

            fetch next from for_satisfied into @id_user, @id_reserv, @time_start, @time_end
            while @@FETCH_STATUS = 0
                begin
                    exec ReservationToRequisition @id_user, @id_reserv, @time_start, @time_end
                    fetch next from for_satisfied into @id_user, @id_reserv, @time_start, @time_end
                end
            close for_satisfied;
            deallocate for_satisfied;
        end;
go