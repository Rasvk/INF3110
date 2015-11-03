import java.util.List;

class ExpressionException extends Exception { 
	String errorMsg;

	ExpressionException(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	ExpressionException(String expected, char found) {
		this.errorMsg = String.format("Expected %s found '%c'!", expected, found);
	}

	public void reason() {
		System.out.println("ERROR: " + errorMsg);
	}
}

/* <exp> ::= <identifier> | <number> | <exp> | <arithmetic-exp> | <bool-exp> */
abstract class Expression {
	public abstract int evaluate(List<VarDecl> vars) throws ExpressionException;
}

/* <number> ::= <int> */
class Number extends Expression {
	int value;

	public Number(int value) {
		this.value = value;
	}

	@Override
	public int evaluate(List<VarDecl> vars) {
		return value;
	}
}

/* <identifier> ::= <string> */
class Ident extends Expression {
	String id;

	public Ident(String id) {
		this.id = id;
	}

	@Override
	public int evaluate(List<VarDecl> vars) throws ExpressionException {
		for (VarDecl var : vars) {
			if (id.equals(var.id))
				return var.value;
		}
		throw new ExpressionException("Ident not found in VarDecl-List");
	}
}

/* <bool-exp> ::= <exp> '>' <exp> | <exp> '<' <exp> | <exp> '=' <exp> */
class BoolExp extends Expression {
	Expression exp1;
	Expression exp2;
	char operator;

	public BoolExp(Expression exp1, char operator, Expression exp2) {
		this.exp1 = exp1;
		this.exp2 = exp2;
		this.operator = operator;
	}

	@Override
	public int evaluate(List<VarDecl> vars) throws ExpressionException {
		int val1 = exp1.evaluate(vars);
		int val2 = exp2.evaluate(vars);
		
		switch (operator) {
			case '>': return val1 > val2 ? 1 : 0;
			case '<': return val1 < val2 ? 1 : 0;
			case '=': return val1 == val2 ? 1 : 0;
			default:
				throw new ExpressionException("'>', '<' or '='", operator);
		}
	}
}

/* <arithmetic-exp> ::= <exp> '+' <exp> | <exp> '-' <exp> | <exp> '*' <exp> */
class ArithExp extends Expression {
	Expression exp1;
	Expression exp2;
	char operator;

	public ArithExp(Expression exp1, char operator, Expression exp2) {
		this.exp1 = exp1;
		this.exp2 = exp2;
		this.operator = operator;
	}

	@Override
	public int evaluate(List<VarDecl> vars) throws ExpressionException {
		int val1 = exp1.evaluate(vars);
		int val2 = exp2.evaluate(vars);
		
		switch (operator) {
			case '+': return val1 + val2;
			case '-': return val1 - val2;
			case '*': return val1 * val2;
			default:
				throw new ExpressionException("'+', '-' or '*'", operator);
		}
	}
}