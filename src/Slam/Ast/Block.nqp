# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.
#
# $Id: $

class SlamAstBlock
	is SlamAstNode ;

has	@!children;

INIT {
	auto_accessors( :private );
}
