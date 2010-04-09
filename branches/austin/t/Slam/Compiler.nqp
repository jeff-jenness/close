#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Compiler
	is UnitTest::Testcase ;

has	$!sut;
	
INIT {
	use(	'UnitTest::Testcase' );
	use(	'UnitTest::Assertions' );
	use(	'Cuckoo' );
	
	pir::load_bytecode('library/slam.pir');
}

TEST_MAIN();

method set_up() {
	$!sut := Slam::Compiler.new;
}

method test_class_init() {
	assert_isa( pir::compreg__PS('close'), 'Slam::Compiler',
		'Class should compreg itself during :init processing');
}

method test_setup() {
	assert_isa($!sut.parsegrammar, 'Slam::Grammar',
		'Init should set parsegrammar');
	assert_isa($!sut.parseactions, 'Slam::Actions',	# FIXME: What's going on here?
		'Init should set parseactions');
}