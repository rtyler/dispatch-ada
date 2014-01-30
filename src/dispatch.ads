with System;

package Dispatch is
   subtype Queue_Type is System.Address;

   procedure Async (Q        : in Queue_Type;
                    Callback : access procedure);

   procedure Schedule (Q        : in Queue_Type;
                       Secs     : in Long_Integer;
                       Callback : access procedure);

   procedure Run;
   pragma Import (C, Run, "dispatch_main");
   --
   --  Using "with" for aspects doesn't seem to work and confuses the compiler.
   --  Hopefully with GNAT GPL 2014, this will be fixed :(

   function Main return Queue_Type;
   pragma Import (C, Main, "dispatch_get_main_queue");

   private

   NANO_SECS_PER_SEC : constant := 1000000000;
   TIME_NOW : constant := 0;
   subtype Long_Natural is Long_Integer range 0 .. Long_Integer'Last;

   function dispatch_time (Time  : in Long_Natural;
                            D     : in Long_Natural) return Long_Natural;
   pragma Import (c, dispatch_time);

   procedure dispatch_after_f (Time     : in Long_Natural;
                               Q        : in Queue_Type;
                               Ctx      : in System.Address;
                               Callback : access procedure);
   pragma Import (C, dispatch_after_f);

   procedure dispatch_async_f (Q        : in Queue_Type;
                               Ctx      : in System.Address;
                               Callback : access procedure);
   pragma Import (C, dispatch_async_f);

   procedure dispatch_sync_f (Q        : in Queue_Type;
                              Ctx      : in System.Address;
                              Callback : access procedure);
   pragma Import (C, dispatch_sync_f);
end Dispatch;
