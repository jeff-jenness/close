# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Slam::Debuggable;

has $!debug;
has $!debug_name;

our method note(*@msg) {
	say($!debug_name,': ', |@msg)
		if $!debug;
}

