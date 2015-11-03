import java.util.List;

class OutOfBoundsException extends Exception {
	String errorMsg;

	OutOfBoundsException(int xPos, int yPos) {
		errorMsg = String.format("Fell out of bounds at (%d, %d)!", xPos, yPos);
	}

	public void reason() {
		System.out.println("ERROR: " + errorMsg);
	}
}

/* <stmt> ::= <stop> | <move> <exp> | <assignment> | <while> */
abstract class Statement {
	public abstract boolean interpret(List<VarDecl> varDecls, Position pos, Grid grid)
	throws OutOfBoundsException, ExpressionException;
}

/* <stop> ::= 'stop' */
class Stop extends Statement {
	
	@Override
	public boolean interpret(List<VarDecl> varDecls, Position pos, Grid grid) {
		return false;
	}
}

/* <move> ::= 'North' | 'South' | 'East' | 'West' */
class Move extends Statement {
	String direction;
	Expression exp;

	public Move(String direction, Expression exp) {
		this.direction = direction;
		this.exp = exp;
	}

	@Override
	public boolean interpret(List<VarDecl> varDecls, Position pos, Grid grid) 
	throws OutOfBoundsException, ExpressionException {
		int val = exp.evaluate(varDecls);
		
		switch (direction) {
			case "North": pos.y += val; break;
			case "South": pos.y -= val; break;
			case "East": pos.x += val; break;
			case "West": pos.x -= val; break;
		}

		if (pos.outOfBounds(grid)) {
			throw new OutOfBoundsException(pos.x, pos.y);
		}

		return true;
	}
}

/* <assignment> ::= <identifier> '=' <exp> */
class Assignment extends Statement {
	String id;
	Expression exp;

	public Assignment(String id, Expression exp) {
		this.id = id;
		this.exp = exp;
	}

	@Override
	public boolean interpret(List<VarDecl> varDecls, Position pos, Grid grid) 
	throws ExpressionException {
		int val = exp.evaluate(varDecls);
		VarDecl decl = findDecl(varDecls);
		decl.value = val;

		return true;
	}

	private VarDecl findDecl(List<VarDecl> varDecls) throws ExpressionException {
		for (VarDecl decl : varDecls)
			if (id.equals(decl.id)) return decl;

		throw new ExpressionException("Ident not found in VarDecl-List");
	}
}

/* <while> ::= 'while' <bool-exp> <stmt-list> */
class While extends Statement {
	BoolExp condition;
	List<Statement> stmts;

	public While(BoolExp condition, List<Statement> stmts) {
		this.condition = condition;
		this.stmts = stmts;
	}

	@Override
	public boolean interpret(List<VarDecl> varDecls, Position pos, Grid grid) 
	throws ExpressionException, OutOfBoundsException {
		if (condition.evaluate(varDecls) == 1) {
			for (Statement stmt : stmts) {
				if (!stmt.interpret(varDecls, pos, grid)) 
					return true; // Break while loop	
			}
			return interpret(varDecls, pos, grid);
		}
		return true;
	}
}