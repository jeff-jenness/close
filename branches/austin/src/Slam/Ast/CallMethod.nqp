# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class SlamAstCallMethod 
	is SlamAstCall ;

has	$!object ;

INIT {
	auto_accessors( :private );
}

