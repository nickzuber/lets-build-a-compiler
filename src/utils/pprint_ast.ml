open Ast

let padding_offset = 2

let build_offset padding : string =
  String.make padding ' '

let rec string_of_program ?(padding=0) node : string =
  match node with
  | Program expr ->
    let str = string_of_expression expr ~padding:(padding + padding_offset) in
    Printf.sprintf "%sProgram\n%s" (build_offset padding) str

and string_of_expression ?(padding=0) node : string =
  match node with
  | Read -> Printf.sprintf "%sRead" (build_offset padding)
  | Int n -> Printf.sprintf "%sInt: %d" (build_offset padding) n
  | Variable v -> Printf.sprintf "%sVariable: %s" (build_offset padding) v
  | BinaryExpression (op, lhs, rhs) ->
    Printf.sprintf "%sBinaryExpression\n%s\n%s\n%s"
      (build_offset padding)
      (string_of_binop op ~padding:(padding + padding_offset))
      (string_of_expression lhs ~padding:(padding + padding_offset))
      (string_of_expression rhs ~padding:(padding + padding_offset))
  | UnaryExpression (op, operand) ->
    Printf.sprintf "%sUnaryExpression\n%s\n%s"
      (build_offset padding)
      (string_of_unop op ~padding:(padding + padding_offset))
      (string_of_expression operand ~padding:(padding + padding_offset))
  | LetExpression (v, binding, expr) ->
    Printf.sprintf "%sLetExpression\n%s\n%s\n%s"
      (build_offset padding)
      (build_offset (padding + padding_offset) ^ v)
      (string_of_expression binding ~padding:(padding + padding_offset))
      (string_of_expression expr ~padding:(padding + padding_offset))

and string_of_binop ?(padding=0) node : string =
  match node with
  | Plus -> Printf.sprintf "%sPlus" (build_offset padding)

and string_of_unop ?(padding=0) node : string =
  match node with
  | Minus -> Printf.sprintf "%sMinus" (build_offset padding)