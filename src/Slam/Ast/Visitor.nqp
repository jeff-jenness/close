# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class Slam::Ast::Visitor ;

INIT {
	Parrot::define_multisub('visit', :method, :starting_with<visit>);
}

our	%Class_children_list;

method class_children_list($class_pmc) {
	my $class_name := $class_pmc.get_namespace.string_name;
	
	unless %Class_children_list.contains: $class_name {
		my @mro := pir::class__pp($node).inspect('all_parents');
		my @children;
		
		for @mro -> $parent_class {
			@children.append: self.class_children_list($parent_class);
		}
		
		my %children;
		my $seen := 1;
		
		@children.map: -> $name { %children{$name} := $seen; };
		%Class_childen_list{$class_name} := @children.keys.sort;
	}
	
	%Class_children_list{$class_name};
}

our	%Node_children_map;

method node_children_map() {
	unless %Node_children_map.elems {
		%m := %Node_children_map;
		
		m<Slam::Symbol>		:= [];
		m<Slam::Symbol::Typed>	:= [<type>];
	}
	
	%Node_children_map;
}

method visit__ANY($node) {
	die("Abstract visit() method needs to be overridden");
}


class Slam::Ast::Visitor::ResolveSymbols ;

INIT {
	Parrot::define_multisub('visit', :method, :starting_with<visit>);
}

method visit__Slam_Symbol_Reference($node) {
	die( "This method should only be called on Slam::Symbol::Reference nodes" )
		unless $node.isa: Slam::Symbol::Reference;
		
	# Resolve symbol
}

