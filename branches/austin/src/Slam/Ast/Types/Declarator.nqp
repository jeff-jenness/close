# Copyright 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class Slam::Type::Declarator
	is Slam::Type::Atom ;

has	$!type;

INIT {
	auto_accessors( :private );
}

our method attach($atom) {
	die(  "Cannot attach to a declarator that already has a type" )
		if $!type.defined;
	
	self.type: $atom;
}

our method merge($other) {
	# Only merge with const/volatile Atoms
	die( "{ pir::typeof__sp(self) } cannot merge with { pir::typeof__sp($other) }, only Atoms" )
		if ! $other.isa( 'Slam::Type::Atom' )
			|| $other.isa( 'Slam::Type::Specifier' )
			|| $other.isa( 'Slam::Type::Declarator');
	
	super($other);
}