from antlr4 import *
from antlr_output.ExpressionLexer import ExpressionLexer
from antlr_output.ExpressionParser import ExpressionParser
from antlr4.error.ErrorListener import ErrorListener

# Custom error listener to handle parsing errors
class CustomErrorListener(ErrorListener):
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        raise Exception(f"Syntax error at line {line}, column {column}: {msg}")

# Function to parse expressions
def parse_expression(input_text):
    input_stream = InputStream(input_text)
    lexer = ExpressionLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = ExpressionParser(stream)
    parser.removeErrorListeners()  
    parser.addErrorListener(CustomErrorListener())

    return parser.expr()

if __name__ == "__main__":
    while True:
        try:
            expression = input("Enter an expression: ")
            tree = parse_expression(expression)
            print("Parse Tree:", tree.toStringTree())
        except Exception as e:
            print(e)