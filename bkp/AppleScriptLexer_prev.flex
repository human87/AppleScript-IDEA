package com.idea.plugin.applescript.lang.lexer;
import com.intellij.lexer.*;
import com.intellij.psi.tree.IElementType;
import static com.idea.plugin.applescript.psi.AppleScriptTypes.*;

%%

%{
  public _AppleScriptLexer() {
    this((java.io.Reader)null);
  }
%}

%public
%class _AppleScriptLexer
%implements FlexLexer
%function advance
%type IElementType
%unicode

//EOL="\r"|"\n"|"\r\n"
//LINE_WS=[\ \t\f]
//WHITE_SPACE=({LINE_WS}|{EOL})+
ONE_NL=(\r|\n|\r\n)
WHITE_SPACE=[\ \t\f]
NLS={ONE_NL}({ONE_NL}|{WHITE_SPACE})*

STARTS_BEGINS_WITH=("start""s"? "with")|("begin""s"? "with")
ENDS_WITH="end""s"? "with"
DOES_NOT_CONTAIN=("does not contain")|("doesn't contain")
IS_IN=("is in")("is contained by")
IS_NOT_IN=("is not in")|("is not contained by")|("isn't contained by")

//todo duplicate variants with and without to/is parts otherwise it is not parsed correctly
GT=(">"|"is"? "greater than"|"comes after"|"is not less than or equal" "to"?|"isn't less than or equal" "to"?)
LE=("?"|"<="|"is"? "less than or equal" "to"?|"is not greater than"|"isn't greater than"|"does not come after"|"doesn't come after")
GE=("?"|">="|"is"? "greater than or equal" "to"?|"is not less than"|"isn't less than"|"does not come before"|"doesn't come before")
LT=("<"|"is"? "less than"|"comes before"|"is not greater than or equal" "to"?|"isn't greater than or equal" "to"?)
NE=("isn't equal" "to"?|"is not equal" "to"?|"doesn't equal"|"does not equal"|"is not"|"isn't")
EQ=("="|"is"? "equal to"|"is"|"equal"|"equals")
REF_OP=("a reference to"|"a ref to"|"a ref"|"reference to"|"ref")

DIV=("/"|"?")
BUILT_IN_TYPE=("string"|"integer"|"real"|"boolean"|"class"|"constant"|"list"|"record"|"data"|"date"|"number"|"reference"|"styled text"|"text")
STRING_LITERAL=\"([^\"\\]|\\.)*\"
DIGITS=[0-9]+
DEC_EXPONENT=[Ee][+-]?[_0-9]*
VAR_IDENTIFIER=([a-zA-Z][a-zA-Z0-9_]*)|(\|(([^\|])|(\\\|))*[^\\]\|)
COMMENT=(("#".*)|("--".*)|(("(*"[^"*"](([^"*"]*("*"+[^"*"")"])?)*("*"+")")?))|"(*"))
RAW_CODE=("<<"[^">>"]*">>")

%%
<YYINITIAL> {
  {WHITE_SPACE}             { return com.intellij.psi.TokenType.WHITE_SPACE; }

  "("                       { return LPAREN; }
  ")"                       { return RPAREN; }
  "�"                       { return CC; }
  "+"                       { return PLUS; }
  "-"                       { return MINUS; }
  "*"                       { return STAR; }
  "div"                     { return INT_DIV; }
  "mod"                     { return MOD; }
  "^"                       { return POW; }
  "or"                      { return LOR; }
  "and"                     { return LAND; }
  "&"                       { return BAND; }
  "not"                     { return LNOT; }
  "as"                      { return AS; }
  "'s"                      { return APS; }
  "the"                     { return THE_KW; }
  "does"                    { return DOES; }
  "apart from"              { return APART_FROM; }
  "aside from"              { return ASIDE_FROM; }
  "out of"                  { return OUT_OF; }
  "instead of"              { return INSTEAD_OF; }
  "that"                    { return THAT; }
  "reference"               { return REFERENCE; }
  "is"                      { return IS; }
  "its"                     { return ITS; }
  "pi"                      { return PI_CONSTANT; }
  "minutes"                 { return MINUTES_CONSTANT; }
  "hours"                   { return HOURS_CONSTANT; }
  "days"                    { return DAYS_CONSTANT; }
  "weeks"                   { return WEEKS_CONSTANT; }
  "(*"                      { return MULTI_LINE_COMMENT_START; }
  "*)"                      { return MULTI_LINE_COMMENT_END; }
  ","                       { return COMMA; }
  "{"                       { return LCURLY; }
  "}"                       { return RCURLY; }
  ":"                       { return COLON; }
  "return"                  { return RETURN; }
  "exit"                    { return EXIT; }
  "repeat"                  { return REPEAT; }
  "end"                     { return END; }
  "times"                   { return TIMES; }
  "while"                   { return WHILE; }
  "until"                   { return UNTIL; }
  "with"                    { return WITH; }
  "from"                    { return FROM; }
  "to"                      { return TO; }
  "by"                      { return BY; }
  "in"                      { return IN; }
  "considering"             { return CONSIDERING; }
  "ignoring"                { return IGNORING; }
  "tell"                    { return TELL; }
  "error"                   { return ERROR; }
  "try"                     { return TRY; }
  "using"                   { return USING; }
  "terms"                   { return TERMS; }
  "number"                  { return NUMBER; }
  "partial"                 { return PARTIAL; }
  "result"                  { return RESULT; }
  "on"                      { return ON; }
  "global"                  { return GLOBAL; }
  "local"                   { return LOCAL; }
  "application"             { return APPLICATION; }
  "app"                     { return APP; }
  "but"                     { return BUT; }
  "responses"               { return RESPONSES; }
  "case"                    { return CASE; }
  "diacriticals"            { return DIACRITICALS; }
  "expansion"               { return EXPANSION; }
  "hyphens"                 { return HYPHENS; }
  "punctuation"             { return PUNCTUATION; }
  "timeout"                 { return TIMEOUT; }
  "of"                      { return OF; }
  "seconds"                 { return SECONDS; }
  "second"                  { return SECOND; }
  "transaction"             { return TRANSACTION; }
  "use"                     { return USE; }
  "version"                 { return VERSION; }
  "importing"               { return IMPORTING; }
  "without"                 { return WITHOUT; }
  "script"                  { return SCRIPT; }
  "framework"               { return FRAMEWORK; }
  "scripting"               { return SCRIPTING; }
  "additions"               { return ADDITIONS; }
  "if"                      { return IF; }
  "then"                    { return THEN; }
  "else"                    { return ELSE; }
  "date"                    { return DATE; }
  "true"                    { return TRUE; }
  "false"                   { return FALSE; }
  "machine"                 { return MACHINE; }
  "zone"                    { return ZONE; }
  "file"                    { return FILE; }
  "alias"                   { return ALIAS; }
  "my"                      { return MY; }
  "some"                    { return SOME; }
  "every"                   { return EVERY; }
  "whose"                   { return WHOSE; }
  "where"                   { return WHERE; }
  "given"                   { return GIVEN; }
  "index"                   { return INDEX; }
  "first"                   { return FIRST; }
  "third"                   { return THIRD; }
  "fourth"                  { return FOURTH; }
  "fifth"                   { return FIFTH; }
  "sixth"                   { return SIXTH; }
  "seventh"                 { return SEVENTH; }
  "eighth"                  { return EIGHTH; }
  "ninth"                   { return NINTH; }
  "tenth"                   { return TENTH; }
  "last"                    { return LAST; }
  "front"                   { return FRONT; }
  "back"                    { return BACK; }
  "middle"                  { return MIDDLE; }
  "named"                   { return NAMED; }
  "thru"                    { return THRU; }
  "through"                 { return THROUGH; }
  "beginning"               { return BEGINNING; }
  "before"                  { return BEFORE; }
  "after"                   { return AFTER; }
  "behind"                  { return BEHIND; }
  "property"                { return PROPERTY; }
  "prop"                    { return PROP; }
  "parent"                  { return PARENT; }
  "current"                 { return CURRENT; }
  "anything"                { return ANYTHING; }
  "yes"                     { return YES; }
  "no"                      { return NO; }
  "ask"                     { return ASK; }
  "ref"                     { return REF; }
  "run"                     { return RUN; }
  "quit"                    { return QUIT; }
  "open"                    { return OPEN; }
  "close"                   { return CLOSE; }
  "launch"                  { return LAUNCH; }
  "space"                   { return SPACE; }
  "tab"                     { return TAB; }
  "linefeed"                { return LINEFEED; }
  "quote"                   { return QUOTE; }
  "it"                      { return IT; }
  "me"                      { return ME; }
  "about"                   { return ABOUT; }
  "above"                   { return ABOVE; }
  "against"                 { return AGAINST; }
  "around"                  { return AROUND; }
  "at"                      { return AT; }
  "below"                   { return BELOW; }
  "beneath"                 { return BENEATH; }
  "beside"                  { return BESIDE; }
  "between"                 { return BETWEEN; }
  "for"                     { return FOR; }
  "into"                    { return INTO; }
  "onto"                    { return ONTO; }
  "over"                    { return OVER; }
  "since"                   { return SINCE; }
  "under"                   { return UNDER; }
  "idle"                    { return IDLE; }
  "continue"                { return CONTINUE; }
  "copy"                    { return COPY; }
  "put"                     { return PUT; }
  "count"                   { return COUNT; }
  "each"                    { return EACH; }
  "get"                     { return GET; }
  "set"                     { return SET; }
  "returning"               { return RETURNING; }
  "contain"                 { return CONTAIN; }
  "contains"                { return CONTAINS; }

  {NLS}                     { return NLS; }
  {STARTS_BEGINS_WITH}      { return STARTS_BEGINS_WITH; }
  {ENDS_WITH}               { return ENDS_WITH; }
  {DOES_NOT_CONTAIN}        { return DOES_NOT_CONTAIN; }
  {IS_IN}                   { return IS_IN; }
  {IS_NOT_IN}               { return IS_NOT_IN; }
  {GT}                      { return GT; }
  {LE}                      { return LE; }
  {GE}                      { return GE; }
  {LT}                      { return LT; }
  {NE}                      { return NE; }
  {EQ}                      { return EQ; }
  {REF_OP}                  { return REF_OP; }
  {DIV}                     { return DIV; }
  {BUILT_IN_TYPE}           { return BUILT_IN_TYPE; }
  {STRING_LITERAL}          { return STRING_LITERAL; }
  {DIGITS}                  { return DIGITS; }
  {DEC_EXPONENT}            { return DEC_EXPONENT; }
  {VAR_IDENTIFIER}          { return VAR_IDENTIFIER; }
  {COMMENT}                 { return COMMENT; }
  {RAW_CODE}                { return RAW_CODE; }

  [^] { return com.intellij.psi.TokenType.BAD_CHARACTER; }
}