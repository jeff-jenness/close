# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class SlamAstValue
	is SlamAstNode ;

has	$!value;
has	$!type;

INIT {
	auto_accessors( :private );
}

class SlamAstFloat
	is SlamAstValue ;

my method _init_obj(*@pos, *%named) {
	self.type: $*SYMBOLS.type: <float>;
	super(|@pos, |%named);	
}

class SlamAstInteger
	is SlamAstValue ;

my method _init_obj(*@pos, *%named) {
	self.type: $*SYMBOLS.type: <int>;
	super(|@pos, |%named);	
}

class SlamAstString
	is SlamAstValue ;

my method _init_obj(*@pos, *%named) {
	self.type: $*SYMBOLS.type: <string>;
	super(|@pos, |%named);	
}
