grammar Expression;
import Configuration;

/*
 * Nonterminal rules (a.k.a. parser rules) must be lowercase, e.g. "root" and "sum" below.
 *
 * Terminal rules (a.k.a. lexical rules) must be UPPERCASE, e.g. NUMBER below.
 * Terminals can be defined with quoted strings or regular expressions.
 *
 * You should make sure you have one rule that describes the entire input.
 * This is the "start rule". The start rule should end with the special token
 * EOF so that it describes the entire input. Below, "root" is the start rule.
 *
 * For more information, see reading 18 about parser generators, which explains
 * how to use Antlr and has links to reference information.
 */
root : sum EOF;
sum : product ('+' product)*;
product : primitive ('*' primitive)*;
primitive : NUMBER | VARIABLE | '(' sum ')';
NUMBER : [0-9.]+;
VARIABLE : [A-Za-z]+;

/* Tell Antlr to ignore spaces around tokens. */
SPACES : [ ]+ -> skip;
