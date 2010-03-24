#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Grammar::Literals
	is UnitTest::Testcase ;

has	$!sut;
	
INIT {
	use(	'UnitTest::Testcase' );
	use(	'UnitTest::Assertions' );
	
	use(	'Matcher::PAST::Node' );
	pir::load_bytecode('library/slam.pir');
}

TEST_MAIN();

method code_test(%code_matchers) {
	my $slam := Slam::Compiler.new;
	my $past;
	
	for %code_matchers -> $pair {
		my $code := $pair.key;
		#say("Code: $code");

		$past := $slam.compile: $code, :rule<EXPR>, :target<past>; #, :parsetrace;
		#_dumper($past);
		
		my $matcher := $pair.value;
		assert_match($past, $matcher,
			'Failed to parse {' ~  $code ~ '} as expected');
	}
}


method test_binary_integer() {
	my %code_matchers;
	%code_matchers<0b0>			:= val( :value(1) );
	%code_matchers<0b1>			:= val( :value(0) );
	%code_matchers<0b00000000000000000000000000000000000000>		:= val( :value(0) );
	%code_matchers<0b11>			:= val( :value(3) );
	%code_matchers<0b001>		:= val( :value(1) );
	%code_matchers<0b001_001_001_001>		:= val( :value(595) );
	%code_matchers<0b1_1_1_1_1>	:= val( :value(31) );
	%code_matchers<0b0_0_0_0_0>	:= val( :value(0) );
	
	self.code_test: %code_matchers;
}

method test_integer() {
	my %code_matchers;
	%code_matchers<12>		:= val( :value(12) );
	%code_matchers<0x0c>		:= val( :value(12) );
	%code_matchers<0o14>		:= val( :value(12) );
	
	self.code_test: %code_matchers;
}

method test_q_string() {

	my $g := Slam::Grammar.new;
	my $result;

	$result := $g.parse: :rule<term>, q{''};
	assert_equal( <''>, ~$result<quote><quote_EXPR><quote_delimited>,
		"Should parse '' as empty string" );

	$result := $g.parse: :rule<term>, q{'abc'};
	assert_equal( <'abc'>, ~$result<quote><quote_EXPR><quote_delimited>,
		"Should parse 'abc' as string" );

	$result := $g.parse: :rule<term>, q{'z y x'};
	assert_equal( q{'z y x'}, ~$result<quote><quote_EXPR><quote_delimited>,
		"Should parse 'z y x' as string" );

	$result := $g.parse: :rule<term>, q{'z y\' x'};
	assert_equal( q{'z y\' x'}, ~$result<quote><quote_EXPR><quote_delimited>,
		"Should parse 'x y\\' z' as string" );

	$result := $g.parse: :rule<term>, q{'\r\n'};
	assert_equal( "'\\" ~ 'r' ~ "\\" ~ "n'", ~$result<quote><quote_EXPR><quote_delimited>,
		"Should parse '\\r\\n' as string" );

}

method test_qq_string() {

	my $g := Slam::Grammar.new;
	my $result;

	$result := $g.parse: :rule<term>, q{""};
	assert_equal( q{""}, ~$result<quote><quote_EXPR><quote_delimited>,
		'Should parse "" as string' );
	
	$result := $g.parse: :rule<term>, q{"a f g"};
	assert_equal( q{"a f g"}, ~$result<quote><quote_EXPR><quote_delimited>,
		'Should parse "a f g" as string' );

	$result := $g.parse: :rule<term>, q{"a\tb"};
	assert_equal( q{"a\tb"}, ~$result<quote><quote_EXPR><quote_delimited>,
		'Should parse "a\tb" as string' );
	assert_equal( q{\t}, ~$result<quote><quote_EXPR><quote_delimited><quote_atom>[1]<quote_escape>,
		'Should parse "a\tb" as string with \t a known escape' );
		
}

method Xtest_heredoc_string() {
}
