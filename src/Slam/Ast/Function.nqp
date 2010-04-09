# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class SlamAstFunction
	is SlamAstDeclaration ;

has	%!attributes;
has	$!block;
has	$!name;
has	@!parameters;

INIT {
	auto_accessors( :private );
}

our method absorb( $declaration ) {
	die( "Only know how to absorb declarations" )
		unless $declaration.isa: 'SlamAstDeclaration';
	
	self.name: $declaration.name;
	self.type: $declaration.type;
}