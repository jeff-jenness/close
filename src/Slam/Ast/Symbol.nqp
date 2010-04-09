# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class SlamAstSymbol
	is SlamAstNode ; 

INIT {
	does_role( 'HasAttribute::Name' );
	does_role( 'HasAttribute::ContainingScope' );
	does_role( 'HasAttribute::Declaration' );	
}