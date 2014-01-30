with Ada.Command_Line,
     Ada.Text_IO;

with Dispatch;


procedure Test_Runner is
   use Ada.Text_IO;

   procedure Honk is
   begin
      Put_Line ("honk honk");
      delay 1.0;
      Put_Line ("honk");
   end Honk;

   procedure c_exit;
   pragma Import (C, c_exit, "exit");

   procedure Suicide is
   begin
      Put_Line ("terminating!");
      c_exit;
   end Suicide;

   procedure Beep is
   begin
      Put_Line ("deferred beep");
      Dispatch.Async (Dispatch.Main, Suicide'Access);
   end Beep;
begin
   Put_Line (">> Running Dispatch-Ada tests");

   Dispatch.Async (Dispatch.Main, Honk'Access);
   Dispatch.Schedule (Dispatch.Main, 4, Beep'Access);

   Put_Line ("..starting runloop");

   Dispatch.Run;

end Test_Runner;
