# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

grammar Slam::Grammar is HLL::Grammar;

#~ has	%!heredocs;

#~ token _BUILTIN		{ '_builtin'		>> }

#~ token	ADV_ANON		{ ':anon'	>>	{*} }
#~ token	ADV_INIT		{ ':init'		>>	{*} }
#~ token	ADV_LOAD		{ ':load'	>>	{*} }
#~ token	ADV_MAIN		{ ':main'	>>	{*} }
#~ token	ADV_METHOD	{ ':method'	>>	{*} }

#~ # NOTE: 'rule'
#~ rule ADV_MULTI {
	#~ ':multi' '(' ~ ')'  <signature=string_literal: ')'> {*}
#~ }

#~ token	ADV_OPTIONAL	{ [ ':optional'	>>
				#~ | '?'		]	{*} }

#~ # NOTE: 'rule'
#~ rule ADV_REG_CLASS {
	#~ ':register_class' '(' ~ ')' <register_class=QUOTED_LIT> {*}
#~ }

#~ token	ADV_SLURPY 	{ [ ':slurpy'	>> 
				#~ | '...'		]	{*} }
#~ token	ADV_VTABLE	{ ':vtable'	>>	{*} }
#~ #tokenADV_EXTENDS	{ ':extends'	>>	{*} }
#~ #tokenADV_OPT_FLAG	{ ':opt_flag'	>>	{*} }
#~ #tokenADV_PHYLUM	{ ':phylum'	>>	{*} }
#~ # TODO: Add adverbs :outer, :subid

#~ method ANY_HEREDOCS_OPEN() { %!heredocs }

#~ token ALIAS			{ 'alias'		>> }
#~ token AND			{ 'and'			>> }
#~ token ASM			{ 'asm'			>> }
#~ token AUTO			{ 'auto' 		>> }

#~ token BAREWORD {
	#~ <!RESERVED> 
	#~ <.ident>
	#~ {*}
#~ }

#~ token BASIC_TYPE {
	#~ [ <.AUTO> 
	#~ | <.FLOAT> 
	#~ | <.INT> 
	#~ | <.PMC> 
	#~ | <.STRING> 
	#~ | <.VOID> 
	#~ ]				{*}
#~ }

#~ token BREAK			{ 'break'		>> }
#~ token BUT			{ 'but'			>> }

#~ token CASE			{ 'case'			>> }
#~ token CLASS			{ 'class'		>> }
#~ token CONST			{ 'const'		>> 	{*} }
#~ token CONTINUE		{ 'continue'		>> }

#~ token DEFAULT		{ 'default'		>> }
#~ token DO			{ 'do'			>> }
#~ token DYNAMIC		{ 'dynamic' 		>> }

#~ token ELSE			{ 'else'			>> }
#~ token ENUM			{ 'enum'		>> }
#~ token EXTENDS		{ 'extends'		>> }
#~ token EXTERN		{ 'extern' 		>> }

#~ token FLOAT			{ 'float'		>> }
#~ token FLOAT_LIT { <dec_number> <FL_SUFFIX>? }
#~ token FL_SUFFIX { <[ f F l L ]> }

#~ token FOR			{ 'for'			>> }
#~ token FOREACH		{ 'foreach'		>> }

#~ token GOTO			{ 'goto'		>> }

#~ method HEREDOC_ENDS($ident) {
#~ say("HEREDOC_ENDS: I don't know what to do.");
#~ _dumper($ident);
#~ }

#~ token HERE_DOC_LIT {
	#~ '<<' <.ws> <QUOTED_LIT>
	#~ {*}
#~ }

#~ token HLL			{ 'hll'			>> }

#~ token IF			{ 'if'			>> }
#~ token IN			{ 'in'			>> }

#~ token IDENTIFIER {
	#~ | <BAREWORD>		{*} #= BAREWORD
	#~ | <QUOTED_LIT>		{*} #= QUOTED_LIT
#~ }

#~ token INCLUDE		{ 'include'	>> }
#~ token INLINE		{ 'inline' 		>> }
#~ token INT			{ 'int'			>> }

#~ token LEXICAL		{ 'lexical' 		>> }

#~ token METHOD		{ 'method' 		>> }	

#~ token NAMESPACE		{ 'namespace'		>> }

#~ token OR			{ 'or'			>> }

#~ token PMC			{ 'pmc'		>> }

#~ token QUOTED_LIT { <?['"]> <quote> }	# "'

#~ token REGISTER		{ 'register' 		>> }
#~ token REPEAT		{ 'repeat'		>> }
#~ token RESERVED {
	#~ [ '_builtin'		# Declaration
	#~ | 'alias'		# Declaration
	#~ | 'and'			# Operator
	#~ | 'asm'			# In-line assembly expression
	#~ | 'auto'		# Declaration
	#~ | 'break'		# Control flow in loops and switches.
	#~ | 'case'			# Reserved for switch statements.
	#~ | 'class'		# Declaration
	#~ | 'const'		# Storage specifier
	#~ | 'continue'		# Control flow in loops.
	#~ | 'default'		# Reserved for switch statements
	#~ | 'do'			# Loop syntax
	#~ | 'dynamic'		# Storage class
	#~ | 'else'			# if statement
	#~ | 'enum'		# Declaration
	#~ | 'extends'		# Declaration
	#~ | 'extern'		# Symbol scope
	#~ | 'float'		# Builtin type
	#~ | 'foreach'		# Loop syntax
	#~ # NB: Moved 'for' down because it's a prefix of the others, and tokens don't backtrack.
	#~ | 'for'			# Loop syntax
	#~ | 'goto'			# Control flow
	#~ | 'hll'			# Directive
	#~ | 'if'			# if statement
	#~ | 'inline'		# Declaration
	#~ | 'int'			# Builtin type
	#~ # NB: Moved 'in' down because it's a prefix of the others, and tokens don't backtrack.
	#~ | 'in'			# foreach statement (x in list)
	#~ | 'lexical'		# Storage class
	#~ | 'method'		# Declaration
	#~ | 'namespace'		# Directive
	#~ | 'or'			# Operator
	#~ | 'pmc'			# Builtin type
	#~ | 'register'		# Storage class
	#~ | 'repeat'		# Loop syntax
	#~ | 'return'		# Control flow
	#~ | 'static'		# Declaration
	#~ | 'string'		# Builtin type
	#~ | 'struct'		# Declaration
	#~ | 'switch'		# Reserved for switch statements
	#~ | 'tailcall'		# Control flow
	#~ | 'template'		# Declaration
	#~ | 'typedef'		# Declaration
	#~ | 'union'		# Declaration
	#~ | 'unless'		# Control flow
	#~ | 'until'		# Control flow
	#~ | 'using'		# Declaration
	#~ | 'void'			# Builtin type
	#~ | 'volatile'		# Storage specifier
	#~ | 'while'		# Loop syntax
	#~ ] >>
#~ }

#~ token RETURN		{ 'return'		>> }

#~ token	SINGLE_COLON	{ ':'	<!before ':'> }
#~ token	SINGLE_MINUS	{ '-'	<!before '-'> }
#~ token	SINGLE_PLUS	{ '+'	<!before '+'> }
#~ token	SINGLE_BANG	{ '!'	<!before '='> }
#~ token	SINGLE_HASH	{ '#'	<!before '#'> }

#~ token STATIC		{ 'static' 		>> }
#~ token STRING		{ 'string'		>> }

#~ token STRING_LIT {
	#~ | <QUOTED_LIT>		{*} #= QUOTED_LIT
	#~ | <HERE_DOC_LIT>	{*} #= HERE_DOC_LIT
#~ }

#~ token STRUCT		{ 'struct'		>> }
#~ token SWITCH		{ 'switch'		>> }
#~ token SYSTEM_HEADER	{ <?[<]>	<quote> {*} }
#~ #token SYSTEM_HEADER	{ \< ~ \>	<string_literal: \>>	{*} }

#~ token TAILCALL		{ 'tailcall'		>> }
#~ token TEMPLATE		{ 'template'		>> }

# rule TOP {
#	 <translation_unit>	{*} #= translation_unit
# }

#~ rule TOP {
	#~ <EXPR> ';'
#~ }

#~ token TYPEDEF		{ 'typedef' 		>> }

#~ token UL_SUFFIX { :i
	#~ | U [ L L? ]?
	#~ | L L? U?
#~ }

#~ token UNION			{ 'union'		>> }
#~ token UNLESS		{ 'unless'		>> }
#~ token UNTIL			{ 'until'		>> }

#~ token USER_HEADER	{ <?['"]>	<quote> {*} }		# "'
#~ #token USER_HEADER	{ \" ~ \"	<string_literal: \">	{*} } #"

#~ token USING			{ 'using'		>> }

#~ token VOID			{ 'void' 		>> }
#~ token VOLATILE		{ 'volatile'		>> 	{*} }

#~ token WHILE			{ 'while'		>> }


#~ rule access_qualifier {
	#~ | <token=CONST>		{*} #= CONST
	#~ | <token=VOLATILE>	{*} #= VOLATILE
#~ }

#~ rule compound_statement {
	#~ '{'			{*} #= open
	#~ ~ '}' <statements=local_statement>*
				#~ {*} #= close
#~ }

#~ rule conditional_statement {
	#~ $<kw>=[ 'if' | 'unless' ]
	#~ '(' ~ ')' <expression>
	#~ $<then>=<local_statement>
	#~ [ 'else' $<else>=<local_statement> ]?
	#~ {*}
#~ }

#~ rule dclr_adverb {
	#~ | <ADV_ANON>	{*} #= ADV_ANON
	#~ | <ADV_INIT>	{*} #= ADV_INIT
	#~ | <ADV_LOAD>	{*} #= ADV_LOAD
	#~ | <ADV_MAIN>	{*} #= ADV_MAIN
	#~ | <ADV_MULTI>	{*} #= ADV_MULTI
	#~ | <ADV_REG_CLASS> {*} #= ADV_REG_CLASS
	#~ | <ADV_VTABLE>	{*} #= ADV_VTABLE
	
	#~ # | <token=ADV_METHOD> (handled by 'method' keyword?)
#~ }

#~ # Matches a declarator alias, as in C<extern int '$Line' alias line;>

#~ rule dclr_alias {
	#~ <.ALIAS> <alias=new_alias_name> {*}
#~ }

#~ rule dclr_array_or_hash {
	#~ | $<hash>='%'		{*} #= hash
	#~ | <size=expression>?	{*} #= array
#~ }

# Matches either a C<declarator_name> (as in 'extern int Foo::x', the 'Foo::x'
# part) or another C<declarator> nested in parentheses.

#~ rule dclr_atom {
	#~ | # :dba('nested declarator')
	    #~ '(' ~ ')' <declarator>	{*} #= declarator
	#~ | <declarator_name>	{*} #= declarator_name
#~ }

# Matches a star ('*') -- the Close "pointer to something" indicator -- optionally 
# followed by C<access_qualifier>s.

#~ rule dclr_pointer {
	#~ $<token>='*' <access_qualifier>*	{*}
#~ }

# Matches either an array or hash declaration (C<decl[%]>), or a function's 
# parameter declaration list (C<decl(int a, string b)>) after a declarator.

#~ rule dclr_postfix {
	#~ | #:dba('function parameter list')
	    #~ '(' ~ ')' <parameter_list>		{*} #= parameter_list
	#~ | #:dba('hash or array declaration')
	    #~ '[' ~ ']' <dclr_array_or_hash>	{*} #= dclr_array_or_hash
#~ }

#~ # A I<declaration_sequence> is a sequence of L<declarative_statement>s. This is a
#~ # convenience target for namespace and translation unit definitions.

#~ rule declaration_sequence {
	#~ <decl=declarative_statement>*
#~ }

#~ rule declaration_statement {
	#~ | <namespace_alias_declaration> ';'	{*} #= namespace_alias_declaration
	#~ | <using_namespace_directive> ';'		{*} #= using_namespace_directive
	#~ | <using_declaration> ';'			{*} #= using_declaration
	#~ | <symbol_declaration_list>		{*} #= symbol_declaration_list
#~ }

#~ # A I<declarative_statement> is a statement that declares or defines a symbol, 
#~ # defines a namespace, or include another source file containing declarations
#~ # and/or definitions. This includes L<declaration_statement>s, as well as 
#~ # L<include_file>s and L<using_namespace_directive>s. 

#~ rule declarative_statement {
	#~ [ <include_directive>	{*} #= include_directive
	#~ | <namespace_definition>	{*} #= namespace_definition
	#~ | <declaration_statement>	{*} #= declaration_statement
	#~ ]
#~ }

# A declarator is that part of the declaration specific to a single name. The 
# declarator includes the symbol name, as well as any prefix indicating
# the symbol is a pointer, and any suffix indicating the symbol is a function,
# array, or hash.

#~ rule declarator {
	#~ # * const	->	foo	-> (int x, string y)
	#~ <dclr_pointer>* <dclr_atom> <dclr_postfix>*
	#~ {*}
#~ }

#~ rule declarator_name {
	#~ | [ <.HLL> ':' <hll_name> ]?
		#~ $<root>='::'
		#~ [ <path=IDENTIFIER> 
			#~ [ '::' <path=IDENTIFIER> ]* ]?
	#~ {*}
	#~ | <path=IDENTIFIER> [ '::' <path=IDENTIFIER> ]*
	#~ {*}
#~ }

#~ rule declarator_part {
	#~ <declarator>
	#~ <dclr_alias>?
	#~ <adverbs=dclr_adverb>*
	#~ {*} #= after_declarator
	#~ [ '=' <initializer=expression>
		#~ {*} #= initializer
	#~ |  <?before '{' >	
		#~ {*} #= block_open
		#~ <body=compound_statement>
		#~ {*} #= block_close
	#~ ]?
	#~ {*} #= done
#~ }

#~ rule do_while_statement {
	#~ <.DO> <local_statement>
	#~ $<kw>=[ <WHILE> | <UNTIL> ]
	#~ [ '(' || <panic: "do...while/until statements must have '(' ')' around test expression" > ]
	#~ <expression>
	#~ [ ')' || <panic: "missing ')' at end of test expression" > ]
	#~ [ ';' || <panic: "Missing ';' at end of do...while/until statement" > ]
	#~ {*}
#~ }

#~ # Expression statement represent most of your programs. Any expression, defined above, followed by a
#~ # semi-colon[;] is an expression statement.

#~ rule expression_statement {
	#~ <expression>
	#~ [ ';' || <panic: "Missing ';' at end of expression statement" > ]
	#~ {*}
#~ }

#~ # foreach (int x in array) say("# ", x);
#~ # string x; foreach (x in hash) say(x, " => ", hash[x]);

#~ rule foreach_header {
	#~ # NB: Try declaration first, to avoid typedef/expression problem.
	#~ [ <loop_var=parameter_declaration> || <loop_var=simple_identifier> ]
	#~ <.IN>
	#~ <list=expression>
#~ }

#~ rule foreach_statement {
	#~ <.FOREACH>		{*} #= open
	#~ '(' ~ ')' <header=foreach_header>
	#~ <body=local_statement>	{*} #= close
#~ }

#~ rule goto_statement {
	#~ <.GOTO> ~ ';' <label=BAREWORD> 
	#~ {*}
#~ }


#~ token hll_name {
	#~ <IDENTIFIER> {*}
#~ }

#~ # Includes a system or user header file.

#~ rule include_directive {
	#~ <.SINGLE_HASH> <.INCLUDE> 
	#~ [ <file=SYSTEM_HEADER> | <file=USER_HEADER> ] 
	#~ {*}
#~ }

#~ # A namespace definition is a block that assigns a namespace path to all the
#~ # declarations contained in the block.

#~ # namespace Foo {
#~ #	void bark();	// Defines Foo::bark();
#~ # }

#~ rule jump_statement {
	#~ | 'tailcall' <retval=postfix_expr> 
		#~ [ ';' || <panic: "Missing ';' at end of tailcall statement" > ]
		#~ {*} #= tailcall
	#~ # | continue [ <loop> ]? ';'         {*} #= continue
	#~ # | break [ <loop> ]? ';'             {*} #= break
#~ }

#~ rule label_declaration {
	#~ <label=label_name> <.SINGLE_COLON>
	#~ {*}
#~ }

#~ token label_name {
	#~ <label=BAREWORD> {*}
#~ }

#~ rule labeled_statement {
	#~ <labels=label_declaration>+
	#~ <statement=local_statement>
	#~ {*}
#~ }

#~ # A I<local_statement> is a statement that may appear in a local scope -- that is,
#~ # inside a class or function declaration. The 'usual' coding statements are here,
#~ # such as loops, goto, if/then/else, expressions, etc.

#~ rule local_statement {
	#~ | <null_statement>		{*} #= null_statement
	#~ | <compound_statement>	{*} #= compound_statement
	#~ | <conditional_statement>	{*} #= conditional_statement
	#~ | <do_while_statement>	{*} #= do_while_statement
	#~ | <while_do_statement>	{*} #= while_do_statement
	#~ | <foreach_statement>	{*} #= foreach_statement
	#~ | <goto_statement>		{*} #= goto_statement
	#~ | <return_statement>	{*} #= return_statement
	#~ | <jump_statement>	{*} #= jump_statement
	#~ | <labeled_statement>	{*} #= labeled_statement
	#~ | <declaration_statement>	{*} #= declaration_statement
	#~ | <expression_statement>	{*} #= expression_statement
#~ }

#~ rule namespace_alias_declaration {
	#~ <.NAMESPACE> <namespace_name> 
	#~ <.ALIAS> <alias=new_alias_name>
	#~ {*}
#~ }

#~ rule namespace_definition {
	#~ <is_extern=EXTERN>? <.NAMESPACE> <namespace=namespace_path> 
	#~ '{'	{*} #= open
		#~ <declaration_sequence>
	#~ '}'	{*} #= close
#~ }

#~ token namespace_name {
	#~ <IDENTIFIER> {*}		#= IDENTIFIER
#~ }

#~ rule namespace_path {
	#~ | [ <.HLL> ':' <hll_name> ]? 
		#~ $<root>='::' 
		#~ [ <path=namespace_name> [ '::' <path=namespace_name> ]* ]?
	#~ {*}
	#~ | <path=namespace_name> 
		#~ [ '::' <path=namespace_name> ]*		
	#~ {*}
#~ }

#~ token new_alias_name {
	#~ <alias=BAREWORD> {*}
#~ }

#~ rule null_statement {
	#~ ';'
	#~ {*}
#~ }

#~ # Matches the adverbs that may appear in a parameter declaration.

#~ # :named('foo')
#~ rule param_adverb {
	#~ | <token=ADV_NAMED>		{*} #= ADV_NAMED
	#~ | <token=ADV_OPTIONAL>	{*} #= ADV_OPTIONAL
	#~ | <token=ADV_SLURPY>		{*} #= ADV_SLURPY
#~ }

#~ # Matches a single parameter declaration, with optional trailing tokens.

#~ rule parameter_declaration {
	#~ <specifier_list>
	#~ <parameter=declarator> 
	#~ [ <adverbs=param_adverb> ]*
	#~ <default=expression>?
	#~ {*}
#~ }

#~ rule parameter_list {
	#~ {*} #= open
	#~ [ <param_list=parameter_declaration> [ ',' | <?before ')'> ] ]*
	#~ {*} #= close
#~ }

#~ rule qualified_identifier {
	#~ [ [ <.HLL> ':' <hll_name> ]? 		# Maybe an hll:close prefix
		#~ $<root>='::' ]?			# Maybe rooted namespace
	#~ <path=BAREWORD> 			# Definitely a bareword.
		#~ [ '::' <path=BAREWORD> ]*	# Maybe a namespace qualifier
	#~ {*}
#~ }

#~ rule return_statement {
	#~ <.RETURN> ~ ';'
	#~ <value=expression>?  
	#~ {*}
#~ }

#~ token short_ident {
	#~ [ <id=BAREWORD> | <id=QUOTED_LIT> ]
	#~ {*}
#~ }

#~ rule simple_identifier {
	#~ <BAREWORD> {*}
#~ }

#~ rule specifier_list {
	#~ <specs=tspec_not_type>*
	#~ <specs=tspec_type_specifier>
	#~ <specs=tspec_not_type>*
	#~ {*}
#~ }

#~ token symbol_declaration_end {
	#~ [ ';'	# Match a semicolon
	#~ || 	# or, match no semicolon if last decl ended with }
		#~ <?{	Q:PIR {
			#~ $P0 = get_hll_global [ 'Slam' ; 'Grammar' ], '$!Decl_block'
			#~ $I0 = $P0
			#~ .return ($I0)
			#~ }
		#~ }>
	#~ || 	# or, inject an error in the token stream.
		#~ <ERROR: "Missing semicolon(';') at end of declaration.">
	#~ ]
#~ }

#~ # NB: If the whole typedef-declared-at-comma thing is needed, put
#~ # action calls at the comma here. (I hope not.)
#~ rule symbol_declaration_list {
	#~ <specifier_list> 
	#~ <symbol=declarator_part> 
	#~ [ ','  <symbol=declarator_part> ]*	
	#~ <.symbol_declaration_end>
	#~ {*}
#~ }

#~ # New types may be introduced in Close via the C<typedef> keyword, and by the 
#~ # tagged declaration of aggregates (classes, structs, unions, and enums). New 
#~ # types I<must> be declared prior to being used as a type specifier in a declaration.

#~ token type_name {
	#~ [ <BASIC_TYPE>		{*} #= BASIC_TYPE
	#~ | <qualified_identifier> 	{*} #= qualified_identifier
	#~ ]
	#~ <?{ Q:PIR { 
		#~ $P0 = get_hll_global [ 'Slam' ; 'Grammar' ; 'Actions' ], '$Is_valid_type'
		#~ .return ($P0)
	#~ }}>
#~ }

#~ # A I<translation unit> is a compiled file, with all of the ancillary included 
#~ # bits that may appear. Essentially, whatever is needed to produce a C<.pbc>
#~ # file as output.

#~ # In Close, a translation unit is defined as a sequence of zero or more 
#~ # C<extern_statement> items. These may be plain old code, namespace blocks,
#~ # variables, classes, or functions.

#~ rule translation_unit {
	#~ {*} #= open
	#~ <declaration_sequence>
	#~ [ $ || <panic: 'Syntax error. Parsing terminated before end of input.'> ]
	#~ {*} #= close
#~ }

#~ rule tspec_basic_type {
	#~ <type=BASIC_TYPE>	{*}
#~ }

#~ rule tspec_builtin {
	#~ | <token=_BUILTIN>	{*}
#~ }

#~ rule tspec_function_attr {
	#~ | <token=INLINE>		{*}
	#~ | <token=METHOD>	{*}
#~ }

#~ rule tspec_not_type {
	#~ | <access_qualifier>		{*} #= access_qualifier
	#~ | <tspec_function_attr>	{*} #= tspec_function_attr
	#~ | <tspec_storage_class>	{*} #= tspec_storage_class
#~ }

#~ rule tspec_storage_class {
	#~ | <token=DYNAMIC>	{*}
	#~ | <token=EXTERN>		{*}
	#~ | <token=LEXICAL>		{*}
	#~ | <token=REGISTER>	{*}
	#~ | <token=STATIC>		{*}
	#~ | <token=TYPEDEF>	{*}
#~ }

#~ token tspec_type_name {
	#~ <type_name>		{*}
#~ }

#~ rule tspec_type_specifier {
	#~ | <tspec_builtin>		{*} #= tspec_builtin
#~ #	| <class_specifier>			{*} #= class_specifier
#~ #	| <enum_specifier>			{*} #= enum_specifier
#~ #	| <elaborated_type_specifier>	{*} #= elaborated_type_specifier
#~ #	| <typename_specifier>		{*} #= typename_specifier
	#~ # type-name is the only pattern that does not have a keyword.
	#~ | <tspec_type_name>		{*} #= tspec_type_name
#~ }


#~ rule using_declaration {
	#~ <.USING> <qualified_identifier>
	#~ # FIXME: Add alias. (General alias rule needed.)
#~ }

#~ rule using_namespace_directive {
	#~ <.USING> <.NAMESPACE> <namespace=namespace_path>
	#~ {*}
#~ }

#~ rule while_do_statement {
	#~ $<kw>=[ 'while' | 'until' ]
	#~ [ '(' || <panic: "while/until ... statements must have '(' ')' around test expression" > ]
	#~ <expression>
	#~ [ ')' || <panic: "missing ')' at end of test expression" > ]
	#~ <local_statement>
	#~ {*}
#~ }





#~ # Circumfix, as opposed to POSTcircumfix. Not sure what [...] does.
#~ token circumfix:sym<( )>		{ '(' <.ws> <EXPR>? ')' }
#~ token circumfix:sym<[ ]>		{ '[' <.ws> <EXPR>? ']' }

#~ token infix:sym<.>			{ <sym> <O('%member_access')> }

#~ token infix:sym<%>			{ <sym> <O('%multiplicative')> }
#~ token infix:sym<*>			{ <sym> <O('%multiplicative')> }
#~ token infix:sym</>			{ <sym> <O('%multiplicative')> }

#~ token infix:sym<+>			{ <sym> <O('%additive')> }
#~ token infix:sym<->			{ <sym> <O('%additive')> }

#~ token postfix:sym<.>		{ <sym> <O('%member_access')> }
#~ token postfix:sym<arrow>		{ '->'	<O('%member_access')> }

#~ token prefix:sym<++>		{ <sym> <O('%autoincrement')> }
#~ token prefix:sym<+>		{ <sym> <!before '+'> <O('%unary_sign')> }
#~ token prefix:sym<-->		{ <sym> <O('%autoincrement')> }
#~ token prefix:sym<->			{ <sym> <!before '-'> <O('%unary_sign')> }
#~ token prefix:sym<!>			{ <sym> <O('%logical_negative')> }


#~ token asm_contents {
	#~ '{{' ~ '}}'	<string_literal: '}}' >
	#~ {*}
#~ }

#~ rule asm_expr {
	#~ <.ASM> [ '(' ~ ')' <arg_list> ]?
	#~ <asm=asm_contents>
	#~ {*}
#~ }

#####################################################

token	ADV_FLAT		{ ':flat' >> }

# NOTE: 'rule'
token ADV_NAMED		{
	':named' 
#	[ '(' ~ ')' <named=QUOTED_LIT> ]? {*}
}

token COLON_SPACE	{ ':'	<?before <.WS>> }

proto token WS { <...> }

token WS:sym<spaces> { \h+ }
token WS:sym<line_comment> { '//' \N* [ \n | $ ] }
token WS:sym<block_comment> { '/*' .*? '*/' }
token WS:sym<heredoc> {
	\n
	[	<?ANY_HEREDOCS_OPEN()>
		[ $<lines>=[ \h* <ident> \h* [ \n | $ ] <?HEREDOC_ENDS($<ident>)> ]
		|| $<lines>=[ \N* \n ]
		]
	]*
}

token arglist {
	| <!before ')'> [ <.ws> <argument> <.ws> ] ** ',' 
	| <.ws> 
}

token argument {
	[ <argname=ident> <.COLON_SPACE> <.ws> ]?
	<EXPR('85')>
	[ <.ws> <arg_adverb> ]*
}

token arg_adverb {
	| <token=ADV_NAMED> 
	| <token=ADV_FLAT> 
}

token ws { 
	|| <?MARKED('ws')> 
	|| <!ww> <WS>* <?MARKER('ws')>  
}

########## EXPRESSIONS ##########

# These are declared in HLL::Compiler

# proto token circumfix { <...> }
# proto token postcircumfix { <...> }
# token term:sym<circumfix> { <circumfix> }

# token termish { <prefixish>* <term> <postfixish>* }
# token infixish { <OPER=infix> }
# token prefixish { <OPER=prefix> <.ws> }
# token postfixish { <OPER=postfix> | <OPER=postcircumfix> }

# token nullterm { <?> }
# token nullterm_alt { <term=.nullterm> }

# Return <termish> if it matches, <nullterm_alt> otherwise.
# method nulltermish() { self.termish || self.nullterm_alt }

INIT {
	### Operator Precedence, Associativity, etc.

	# Note that precedence strings, like <01>, are compared asciibetically. So 01 < 02, etc. And lower
	# ordering means lower precedence.

	Slam::Grammar.O( ':prec<F9>, :assoc<unary>',	'%prefix_scope' );		# ::x
	Slam::Grammar.O( ':prec<F8>, :assoc<left>',	'%infix_scope' );		# x::y
	
	Slam::Grammar.O( ':prec<EE>, :assoc<unary>',	'%postfix_increment' );	# x++, x--
	Slam::Grammar.O( ':prec<EC>, :assoc<unary>',	'%function_call' );		# x()
	Slam::Grammar.O( ':prec<EA>, :assoc<unary>',	'%array_subscript' );	# x[]
	Slam::Grammar.O( ':prec<E8>, :assoc<left>',	'%member_access' );	# x.y, x->y
	Slam::Grammar.O( ':prec<E6>, :assoc<unary>',	'%typeid' );			# typeid x
	
	Slam::Grammar.O( ':prec<DE>, :assoc<unary>', '%prefix_increment' );	# ++x, --x
	Slam::Grammar.O( ':prec<DC>, :assoc<unary>', '%negation' );			# +x, -x, !x, ~x
	Slam::Grammar.O( ':prec<DA>, :assoc<unary>',	'%type_cast' );		# (int) x
	Slam::Grammar.O( ':prec<D8>, :assoc<unary>',	'%indirection' );		# *x
	Slam::Grammar.O( ':prec<D6>, :assoc<unary>',	'%address_of' );		# &x
	Slam::Grammar.O( ':prec<D4>, :assoc<unary>',	'%new' );			# new x
	
	Slam::Grammar.O( ':prec<D2>, :assoc<left>',	'%member_indirect' );	# x.*y, x->*y
	
	Slam::Grammar.O( ':prec<CB>, :assoc<left>',	'%multiplicative' );		# x * y, x / y, x % y
	Slam::Grammar.O( ':prec<C8>, :assoc<left>',	'%additive' );			# x + y, x - y
	Slam::Grammar.O( ':prec<C4>, :assoc<left>',	'%bitwise_shift' );		# x << y, x >> y
	
	Slam::Grammar.O( ':prec<BA>, :assoc<left>',	'%relational' );		# x < y, x <= y, x >= y, x > y
	Slam::Grammar.O( ':prec<B5>, :assoc<left>',	'%equality' );			# x == y, x != y, x =:=, x =!= y
	
	Slam::Grammar.O( ':prec<AB>, :assoc<left>',	'%bitwise_and' );		# x & y
	Slam::Grammar.O( ':prec<A8>, :assoc<left>',	'%bitwise_xor' );		# x ^ y
	Slam::Grammar.O( ':prec<A4>, :assoc<left>',	'%bitwise_or' );		# x | y
	
	Slam::Grammar.O( ':prec<9A>, :assoc<left>',	'%logical_and' );		# x && y
	Slam::Grammar.O( ':prec<95>, :assoc<left>',	'%logical_or' );		# x || y
	
	Slam::Grammar.O( ':prec<8A>, :assoc<right>',	'%ternary' );			# x ? y : z
	Slam::Grammar.O( ':prec<85>, :assoc<right>',	'%assignment' );		# x = y, x [+-*/%>><<&^|]= y
	
	Slam::Grammar.O( ':prec<37>, :assoc<left>',	'%comma' );			# x, y
}

proto token term		{ <...> }
token term:sym<float>		{ <dec_number> }	# Inherited
token term:sym<identifier>		{ <ident> }		# Inherited
token term:sym<int>		{ <integer> }		# Inherited
token term:sym<quote>		{  <quote> }		# Inherited

#token term:sym<asm> 		{ <asm_expr> }

proto token quote		{ <...> }
token quote:sym<'...'>		{ <?[']>	<quote_EXPR: ':q'> }	#'
token quote:sym<"...">		{ <?["]>	<quote_EXPR: ':qq'> }	#"

# proto token infix		{ <...> }	# Inherited
token infix:sym«->»		{ <sym> <O('%member_access')> }
token infix:sym<.>			{ <sym> <O('%member_access')> }
token infix:sym<::>		{ <sym> <O('%infix_scope')> }
token infix:sym<::*>		{ <sym> <O('%infix_scope')> }

# proto token prefix	{ <...> }
token prefix:sym<::>		{ <sym> <O('%prefix_scope')> }
token prefix:sym<::*>		{ <sym> <O('%prefix_scope')> }
token prefix:sym<typeid>	{ <sym> <O('%typeid')> }

# proto token postcircumfix { <...> }
token postcircumfix:sym<call>	{ <.ws> '(' <arglist> ')' <O('%function_call')> }
token postcircumfix:sym<[ ]>	{ '[' <.ws> <index=EXPR> ']' <O('%array_subscript')> }


# proto token postfix	{ <...> }
token postfix:sym<++>		{ <.ws> <sym> <O('%postfix_increment')> }
token postfix:sym<-->		{ <.ws> <sym> <O('%postfix_increment')> }
