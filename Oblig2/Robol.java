import java.util.List;
import java.util.LinkedList;

public interface Robol {
	void interpret();
}

/* <program> ::= <grid> <robot> */
class Program implements Robol {
	Grid grid;
	Robot robot;

	public Program(Grid grid, Robot robot) {
		this.grid = grid;
		this.robot = robot;
	}

	public void interpret() {
		robot.interpret(grid);
		System.out.println("Robot stops at " + robot.reportPos());
	}
}

/* <grid> ::= 'size' <int> <int> */
class Grid {
	int x;
	int y;

	public Grid(int x, int y) {
		this.x = x;
		this.y = y;
	}
}

/* <position> ::= <int> <int> */
class Position {
	int x;
	int y;

	public Position(int x, int y) {
		this.x = x;
		this.y = y;
	}

	public boolean outOfBounds(Grid g) {
		return (this.x < 0 || this.x > g.x || 
				this.y < 0 || this.y > g.y);			
	}
}

/* <robot> ::= <var-decl-list> <start> <stmt-list> 
   <var-decl-list> ::= <var-decl> | <var-decl> <var-decl-list>
   <stmt-list> ::= <stmt> | <stmt> <stmt-list> */
class Robot {
	List<VarDecl> varDecls;
	Position pos;
	List<Statement> stmts;

	public Robot(Position start) {
		this.pos = start;
		this.varDecls = new LinkedList<VarDecl>();
		this.stmts = new LinkedList<Statement>();
	}

	public void interpret(Grid grid) {
		for (Statement stmt : stmts) {
			try {
				if (!stmt.interpret(varDecls, pos, grid)) return;
			} catch (OutOfBoundsException e) {
				e.reason();
			} catch (ExpressionException e) {
				e.reason();
			}
		}
	}

	public void addVarDecl(VarDecl varDecl) {
		varDecls.add(varDecl);
	}

	public void addStmt(Statement stmt) {
		stmts.add(stmt);
	}

	public String reportPos() {
		return String.format("(%d, %d)", pos.x, pos.y);
	}
}

/* <var-decl> ::= 'var' <string> '=' <int> */
class VarDecl {
	String id;
	int value;

	public VarDecl(String id, int value) {
		this.id = id;
		this.value = value;
	}
}




class Test {
	public static void main(String[] args) {
		Grid testGrid = new Grid(64, 64);

		Robot robot1 = new Robot(new Position(23, 30));
		robot1.addStmt(new Move("West", new Number(15)));
		robot1.addStmt(new Move("South", new Number(15)));
		robot1.addStmt(new Move("East", new ArithExp(new Number(2), '+', new Number(3))));
		robot1.addStmt(new Move("North", new ArithExp(new Number(10), '+', new Number(27))));
		robot1.addStmt(new Stop());
		Program test1 = new Program(testGrid, robot1);
		test1.interpret();


		Robot robot2 = new Robot(new Position(23, 6));
		robot2.addVarDecl(new VarDecl("i", 5));
		robot2.addVarDecl(new VarDecl("j", 3));
		robot2.addStmt(new Move("North", new ArithExp(new Number(3), '*', new Ident("i"))));
		robot2.addStmt(new Move("East", new Number(15)));
		robot2.addStmt(new Move("South", new Number(4)));
		robot2.addStmt(new Move("West", 
			new ArithExp(new ArithExp(new Number(2), '*', new Ident("i")), '+',
						 new ArithExp(new ArithExp(new Number(3), '*', new Ident("j")), '+',
						 new Number(5)))));
		robot2.addStmt(new Stop());
		Program test2 = new Program(testGrid, robot2);
		test2.interpret();

		
		Robot robot3 = new Robot(new Position(23, 6));
		robot3.addVarDecl(new VarDecl("i", 5));
		robot3.addVarDecl(new VarDecl("j", 3));
		robot3.addStmt(new Move("North", new ArithExp(new Number(3), '*', new Ident("i"))));
		robot3.addStmt(new Move("West", new Number(15)));
		robot3.addStmt(new Move("East", new Number(4)));
		List<Statement> robot3While = new LinkedList<Statement>();
		robot3While.add(new Move("South", new Ident("j")));
		robot3While.add(new Assignment("j", new ArithExp(new Ident("j"), '-', new Number(1))));
		robot3.addStmt(new While(new BoolExp(new Ident("j"), '>', new Number(0)), robot3While));
		robot3.addStmt(new Stop());
		Program test3 = new Program(testGrid, robot3);
		test3.interpret();


		Robot robot4 = new Robot(new Position(1, 1));
		robot4.addVarDecl(new VarDecl("j", 3));
		List<Statement> robot4While = new LinkedList<Statement>();
		robot4While.add(new Move("North", new Ident("j")));
		robot4.addStmt(new While(new BoolExp(new Ident("j"), '>', new Number(0)), robot4While));
		robot4.addStmt(new Stop());
		Program test4 = new Program(testGrid, robot4);
		test4.interpret();
	}
}