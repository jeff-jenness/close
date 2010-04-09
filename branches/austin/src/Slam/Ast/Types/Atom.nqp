# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class Slam::Type::Atom
	is Slam::Symbol ;

INIT {
	auto_accessors( :private );
	does_role( 'Slam::HasAttributes' );
}

our method merge($other) {
	die( '$other parameter to Slam::Type::Atom::merge must be a type atom' )
		unless $other.isa( Slam::Type::Atom );

	if my $othername := $other.name {
		if my $name := self.name {
			die( "Cannot merge two names of type atoms" )
				if $othername ne $name;
		}
		else {
			self.name: $othername;
		}
	}
	
	if my $scope := $other.scope {
		die( "Don't know how to merge two scopes of type atoms" )
			if self.scope && self.scope ne $scope;
			
		self.scope: $scope;
	}
	
	self.merge_attributes: $other;
}