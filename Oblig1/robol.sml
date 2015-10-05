(* Expressions *)
datatype exp 
  = Ident of string
  | Number of int
  | ArithExp of aExp
  | BooleanExp of bExp
and aExp
  = Plus of exp * exp
  | Minus of exp * exp
  | Multiply of exp * exp
and bExp
  = LargerThan of exp * exp
  | LessThan of exp * exp
  | Equal of exp * exp

(* Create buffer for storing variables *)
type variable = string * exp
type buffer = variable list 
(* Cons the new variable to the start of the buffer *)
fun buf_set (b: buffer, (k, v): variable) = 
  (k, v)::List.filter (fn (k1, v1) => not (k = k1)) b
(* Search buffer for variable with the correct key *)
fun buf_get ([]: buffer, key: string) = NONE
  | buf_get ((k, v)::b: buffer, key: string) =
    if k = key then SOME(v) else buf_get(b, key)

(* Error in case variable is not found in buffer *)
exception BufferError of string
val buffErr : string = "Variable not found!"

(* Directions *)
datatype direction = North | South | East | West

(* Statements *)
datatype stmt 
  = Stop
  | Move of direction * exp
  | Assign of string * exp
  | While of bExp * stmt list

(* Variable declaration *)
type varDecl = string * exp

(* Position (x, y) *)
type position = int * int
type start = position

(* Robot, grid and program *)
type robot = varDecl list * start * stmt list
type grid = int * int
type program = grid * robot

(* state is for use in evalStmt *)
type state = grid * position * buffer

(* Evaluate an expression *)
fun evalExp (b: buffer, Ident x) =
    let val num = buf_get(b, x)
    in if isSome num then evalExp(b, valOf(num)) else raise BufferError buffErr end
  | evalExp (b: buffer, Number x)     = x
  | evalExp (b: buffer, ArithExp x)   = evalArithExp (b, x)
  | evalExp (b: buffer, BooleanExp x) = if evalBoolExp (b, x) then 1 else 0
and evalArithExp (b: buffer, Plus (exp1, exp2)) = evalExp(b, exp1) + evalExp(b, exp2)
  | evalArithExp (b: buffer, Minus (exp1, exp2)) = evalExp(b, exp1) - evalExp(b, exp2)
  | evalArithExp (b: buffer, Multiply (exp1, exp2)) = evalExp(b, exp1) * evalExp(b, exp2)
and evalBoolExp (b: buffer, LargerThan (exp1, exp2)) = evalExp(b, exp1) > evalExp(b, exp2)
  | evalBoolExp (b: buffer, LessThan (exp1, exp2)) = evalExp(b, exp1) < evalExp(b, exp2)
  | evalBoolExp (b: buffer, Equal (exp1, exp2)) = evalExp(b, exp1) = evalExp(b, exp2)

(* Exception if position is out of bounds *)
exception OutOfBoundsException of position

(* Check if position is within the grid *)
fun checkBounds((x, y): grid, (posX, posY): position) =
  if posX >= 0 andalso posY >= 0 andalso posX <= x andalso posY <= y 
    then (posX, posY): position else raise OutOfBoundsException (posX, posY)

(* Evaluate a Statement *)
fun move (g: grid, (x0, y0): position, n: int, d: direction) = case d of
    North => checkBounds(g, (x0, y0 + n))
  | South => checkBounds(g, (x0, y0 - n))
  | East => checkBounds(g, (x0 + n, y0))
  | West => checkBounds(g, (x0 - n, y0))
  
(* Evaluate a statement *)
fun evalStmt (s: state, Stop) = s
  | evalStmt (s: state, While x) =
      evalWhile(s, While x)
  | evalStmt ((board, pos, buf): state, Move (dir, num)) =
      (board, move(board, pos, evalExp(buf, num), dir), buf)
  | evalStmt ((board, pos, buf): state, Assign (k, v)) =
      (board, pos, buf_set(buf, (k, Number (evalExp(buf, v)))))
and evalWhile ((board, pos, buf): state, While (cond, statements)) =
  if evalExp(buf, BooleanExp cond) = 0 then (board, pos, buf) 
  else evalWhile(evalStmtList((board, pos, buf), statements), While (cond, statements))
and evalStmtList (s: state, []: stmt list) = s
  | evalStmtList (s: state, (Stop::xs): stmt list) = s 
  | evalStmtList (s: state, (x::xs): stmt list) =
      evalStmtList(evalStmt(s, x), xs)

(* Get the position of a state *)
fun get_pos((board, pos, buf): state) : position = pos

(* Interpret the program *)
fun interpret ((g: grid, (decls, p: position, stmtlst): robot): program) = 
  let val startState : state = (g, p, decls)
  in get_pos(evalStmtList(startState, stmtlst)) end
  handle OutOfBoundsException pos => 
    (print "Robot fell of grid!\n"; (pos))


(* program - Tests *)
val test1 : program =
  ((64, 64),
   ([],
    (23, 30),
    [Move (West, Number 15),
     Move (South, Number 15),
     Move (East, ArithExp 
                    (Plus 
                      (Number 2, Number 3))),
     Move (North, ArithExp 
                    (Plus 
                      (Number 10, Number 27))),
     Stop]))

val test2 : program =
  ((64, 64),
   ([("i", Number 5),
     ("j", Number 3)],
    (23, 6),
    [Move (North, ArithExp 
                    (Multiply 
                      (Number 3, Ident "i"))),
     Move (East, Number 15),
     Move (South, Number 4),
     Move (West, ArithExp 
                  (Plus 
                    (ArithExp 
                      (Plus 
                       (ArithExp 
                        (Multiply (Number 2, Ident "i")), 
                        ArithExp 
                        (Multiply (Number 3, Ident "j")))),
                     Number 5))),
     Stop]))

val test3 : program = 
  ((64, 64),
   ([("i", Number 5),
     ("j", Number 3)],
    (23, 6),
    [Move (North, ArithExp
                    (Multiply
                      (Number 3, Ident "i"))),
     Move (West, Number 15),
     Move (East, Number 4),
     While (LargerThan 
              (Ident "j", Number 0),
            [Move (South, Ident "j"),
             Assign ("j", ArithExp 
                          (Minus 
                            (Ident "j", Number 1)))]),
     Stop]))

val test4 : program = 
  ((64, 64),
   ([("j", Number 3)],
    (1, 1),
    [While (LargerThan
            (Ident "j", Number 0),
             [Move (North, Ident "j")]),
     Stop]))