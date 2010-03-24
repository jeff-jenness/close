#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Grammar
	is UnitTest::Testcase ;

has	$!sut;
	
INIT {
	use(	'UnitTest::Testcase' );
	use(	'UnitTest::Assertions' );
	use(	'Cuckoo' );
	
	pir::load_bytecode('library/slam.pir');
}

TEST_MAIN();

method test1() {
	my $g := Slam::Grammar.new;
	
	my $result := $g.parse: q{  2; };
	
	_dumper($result);
}