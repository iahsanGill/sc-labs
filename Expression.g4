grammar Expression;

// Grammar rules
expr: term (('+' | '-') term)* ;
term: factor (('*' | '/') factor)* ;
factor: INT | '(' expr ')' ;

// Lexer rules
INT: [0-9]+ ;
WS: [ \t\r\n]+ -> skip ;