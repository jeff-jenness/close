#! /usr/bin/env parrot-nqp
#
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# # Slam - a Close compiler #
#
# ## Description ##
#
# This is the command-line driver for Slam. 
#
# This file contains logic to set up the main program, load any necessary libraries,
# and parse the command-line arguments.

# Load the Kakapo library
INIT {
	if pir::isnull(Kakapo::is_loaded) {
		pir::load_language('parrot');
		my $env := pir::new__PS('Env');
		my $root_dir := $env<SLAM_ROOT_DIR> || '.';
	
		pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
	}
}

class Slam::Driver
	is Program;

has	@!close_files;
has	%!options;

INIT {
	auto_accessors(:private);
	
	Program::instance( Slam::Driver.new( :from_parrot ) );
}

method _init_obj(*@pos, *%named) {
	my $result := super(|@pos, |%named);
	
	@!close_files := @!close_files;
	$result;
}

method main() {
	self.parse_command_line(@*ARGS);

	if %!options<version> {
		say( self.version );
	}
	
	my $compiler := pir::compreg__PS( 'close' );
	for @!close_files -> $file {
		my $source := $*FileSystem.get_contents: $file;
		$compiler.compile: $source;
	}
		
	0;
}

method options() {
	[<version|V>];
}

method parse_command_line(@args) {
	pir::load_bytecode('Getopt/Obj.pbc');
	my $getopts := Parrot::new( 'Getopt::Obj' );
	$getopts.notOptStop(1);

	for self.options -> $opt { 
		pir::push__vPS( $getopts, $opt ); 
	}

	%!options := $getopts.get_options(@args);
	@!close_files := @args;
}

method version() {
	q{{{

This is Slam version 2010.3.20, a compiler for the Close language on the Parrot VM.
Copyright 2009-2010, Austin Hastings.

This code is distributed under the terms of the Artistic License 2.0. Browse to 
http://www.opensource.org/licenses/artistic-license-2.0.php or see the LICENSE 
file accompanying the source code.
}}};
}
