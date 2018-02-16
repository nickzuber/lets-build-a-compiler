open Ast
open Compiler
open Pprint_ast

let () =
  let start = Unix.gettimeofday () in
  display "Running tests";
  Test_uniquify.main ();
  Test_flatten.main ();
  Test_select.main ();
  print_endline (create_title "Test summary");
  Printf.printf " •\x1b[32m %d tests passed\x1b[39m" !Runner.pass;
  (* Show unimplemented *)
  if (!Runner.unimplemented > 0) then
    Printf.printf "\n •\x1b[33m %d tests were unimplemented\x1b[39m" !Runner.unimplemented
  else
    ();
  (* Show failures *)
  if (!Runner.fail > 0) then
    Printf.printf "\n •\x1b[31m %d tests failed\x1b[39m" !Runner.fail
  else
    ();
  Printf.printf "\n • Ran in %f seconds\n\n" ((Unix.gettimeofday ()) -. start)
