# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class SlamAstOp
	is SlamAstNode ;

has	$!operation;
has	@!children;

INIT {
	auto_accessors( :private );
}

my method _init_obj($op?, *@children, *%named) {
	@!children := @children;
	$!operation := $op
		if $op;
	
	super(|%named);
}