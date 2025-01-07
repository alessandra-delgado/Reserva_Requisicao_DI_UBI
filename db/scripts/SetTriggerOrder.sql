EXEC sp_settriggerorder
     @triggername= 'ReturnedEquip',
     @order='First',
     @stmttype = 'INSERT';

EXEC sp_settriggerorder
     @triggername= 'IncrementHitOrMissOnReturn',
     @order='Last',
     @stmttype = 'INSERT';