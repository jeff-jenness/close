# Copyright 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class Slam::Type::Specifier
	is Slam::Type::Atom ;

has	$!expression_type;
has	$!register_type;

INIT {
	auto_accessors( :private );
}

my method _init_obj($symbol?, *%named) {
	if $symbol.defined {
		
		die( "Positional arg to new must be a SlamAstSymbol" )
			unless $symbol.isa: SlamAstSymbol;
		
		self.name: $symbol.name;

		if $symbol.isa: Slam::Type::Specifier {
			self.expression_type: $symbol.expression_type;
			self.register_type: $symbol.register_type;
		}
	}
	
	super(|%named);
}

our method merge($other) {
	die( '$other parameter to Specifier::merge must be a Specifier or Atom' )
		unless $other.isa( Slam::Type::Specifier ) || $other.isa( Slam::Type::Atom );

	super($other);
}