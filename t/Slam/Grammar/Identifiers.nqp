#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Grammar::Identifiers
	is UnitTest::Testcase ;

has	$!sut;
	
INIT {
	use(	'UnitTest::Testcase' );
	use(	'UnitTest::Assertions' );
	
	use(	'Matcher::PAST::Node' );
	pir::load_bytecode('library/slam.pir');
}

TEST_MAIN();

method test_identifier() {
	my $slam := Slam::Compiler.new;
	my $past;

	my @code := <_   _a  a  _001  a_1  a__B  vitameatavegemin>;

	for @code -> $code {
		$past := $slam.compile: $code, :rule<term>, :target<past>;

		assert_match($past, var( name => $code ),
			"Should parse $code as identifier");
	}
}
