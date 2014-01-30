package body Dispatch is
   procedure Async (Q        : in Queue_Type;
                    Callback : access procedure) is
   begin
      dispatch_async_f (Q, System.Null_Address, Callback);
   end Async;


   procedure Schedule (Q        : in Queue_Type;
                       Secs     : in Long_Integer;
                       Callback : access procedure) is
      D : Long_Natural := Secs * NANO_SECS_PER_SEC;
   begin
      dispatch_after_f (dispatch_time (TIME_NOW, D),
                        Q,
                        System.Null_Address,
                        Callback);
   end Schedule;
end Dispatch;
