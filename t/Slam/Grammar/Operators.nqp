#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Grammar::Operators
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
		say("Code: $code");

		Q:PIR {
			$P0 = null
			set_hll_global ['HLL';'Grammar'], '%!MARKHASH', $P0
		};
		
		$past := $slam.compile: $code, :rule<EXPR>, :target<past>; #, :parsetrace;
		#_dumper($past);
		
		my $matcher := $pair.value;
		assert_match($past, $matcher,
			'Failed to parse {' ~  $code ~ '} as expected');
	}
}

method test_member_dot() {
	my %code_matchers;
	%code_matchers<x.y>		:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x .y>		:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x. y>		:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x . y>		:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));

	%code_matchers{'x->y'}	:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers{'x-> y'}	:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers{'x -> y'}	:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));
	%code_matchers{'x ->y'}	:= var( :scope<attribute>, var( :name<x> ), var( :name<y> ));

	self.code_test: %code_matchers;	
}

method test_postcircumfix_array_index() {
	my %code_matchers;
	%code_matchers<x[0]>		:= var( :scope<keyed>, var( :name<x> ), val( :value<0> ));
	%code_matchers<x[ 1]>		:= var( :scope<keyed>, var( :name<x> ), val( :value<1> ));
	%code_matchers<x[ 2 ]>	:= var( :scope<keyed>, var( :name<x> ), val( :value<2> ));

	%code_matchers<x[ y ]>		:= var( :scope<keyed>, var( :name<x> ), var( :name<y> ));
	
	self.code_test: %code_matchers;
}

method test_postcircumfix_call() {
	my %code_matchers;
	%code_matchers<x()>		:= op( :pasttype<call>, var( :name<x> ), );
	%code_matchers<x( )>		:= op( :pasttype<call>, var( :name<x> ), );
	%code_matchers<x ( )>		:= op( :pasttype<call>, var( :name<x> ), );
	
	%code_matchers<x(y)>		:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x( y)>		:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x(y )>		:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ));
	%code_matchers<x( y )>		:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ));
	
	%code_matchers<x(y, z)>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ), var( :name<z> ));
	%code_matchers<x(y,z)>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ), var( :name<z> ));
	%code_matchers<x(y,z )>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ), var( :name<z> ));
	%code_matchers<x( y, z )>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ), var( :name<z> ));
	
	%code_matchers<x( y, z, a )>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y> ), var( :name<z> ), var( :name<a> ));
	
	%code_matchers<x(Y: y )>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y>, :named<Y> ));
	%code_matchers<x(Y: y, z )>	:= op( :pasttype<call>, var( :name<x> ), var( :name<y>, :named<Y> ), var( :name<z> ));
	
	%code_matchers<f( x( z ) )>	:= op( :pasttype<call>, var( :name<f> ), op( :pasttype<call>, var( :name<x> ), var( :name<z> )));
	
	self.code_test: %code_matchers;
}

method test_postfix_xcrement() {
	my %code_matchers;
	
	%code_matchers := Hash.new;
	
	%code_matchers<x>		:= var( :name<x> );
	%code_matchers<x++>		:= op( :named('&postfix:<++>'), var( :name<x> ), );
	%code_matchers<x ++>		:= op( :named('&postfix:<++>'), var( :name<x> ), );
	%code_matchers<x-->		:= op( :named('&postfix:<-->'), var( :name<x> ), );

	self.code_test: %code_matchers;

	%code_matchers := Hash.new;
	%code_matchers<x -->		:= op( :named('&postfix:<-->'), var( :name<x> ), );

	self.code_test: %code_matchers;
}

method test_scope_operator() {
	my %code_matchers;
	%code_matchers<x>		:= var( :name<x> );
	%code_matchers<x::y> 		:= op( :name('&infix:<::>'), var(:name<x>), var(:name<y>) );
	%code_matchers<::x>		:= op( :name('&prefix:<::>'), var(:name<x>), );
	%code_matchers<x :: y> 	:= op( :name('&infix:<::>'), var(:name<x>), var(:name<y>) );
	%code_matchers<:: x>		:= op( :name('&prefix:<::>'), var(:name<x>) );
	%code_matchers<::*x>		:= op( :name('&prefix:<::*>'), var( :name<x> ) );
	%code_matchers<::* x>		:= op( :name('&prefix:<::*>'), var( :name<x> ) );
	%code_matchers<::* x>		:= op( :name('&prefix:<::*>'), var( :name<x> ) );
	%code_matchers<x::*y>		:= op( :name('&infix:<::*>'), var( :name<x> ), var( :name<y> ) );
	%code_matchers<x::*y>		:= op( :name('&infix:<::*>'), var( :name<x> ), var( :name<y> ) );
	%code_matchers<x::* y>	:= op( :name('&infix:<::*>'), var( :name<x> ), var( :name<y> ) );
	%code_matchers<x ::* y>	:= op( :name('&infix:<::*>'), var( :name<x> ), var( :name<y> ) );

	self.code_test: %code_matchers;
}

method test_typeid() {
	my %code_matchers;
	%code_matchers<typeid x>		:= op( :name('&prefix:<typeid>'), var( :name<x> ) );

	self.code_test: %code_matchers;
}
	
method main() { self.test_typeid; }
