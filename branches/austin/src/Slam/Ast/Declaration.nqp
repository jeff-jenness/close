# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class SlamAstDeclaration 
	is SlamAstNode ; 

has	$!symbol;
has	$!type;
has	$!type_tail;
has	$!definition;

INIT {
	auto_accessors( :private );
}

our method attach($type_atom) {
	if $!type {
		$!type_tail.attach: $type_atom;
	}
	else {
		$!type := $type_atom;
	}
	
	$!type_tail := $type_atom;
}

our method storage_class() {
	self.symbol.storage_class;
}

our %_Storage_class_type_map;

our method to_quad() {

	unless %_Storage_class_type_map.elems {
		%_Storage_class_type_map<dynamic> := Slam::Quad::Declaration::Lexical;
		%_Storage_class_type_map<extern> := Slam::Quad::Declaration::Global;
		%_Storage_class_type_map<lexical> := Slam::Quad::Declaration::Lexical;
		%_Storage_class_type_map<register> := Slam::Quad::Declaration::Local;
		%_Storage_class_type_map<static> := Slam::Quad::Declaration::Global;
	}
	
	my $quad := %_Storage_class_type_map{ self.storage_class }.new:
		:ast_node( self ),
		;
}
