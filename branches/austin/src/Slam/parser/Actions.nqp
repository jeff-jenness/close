# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Slam::Actions is HLL::Actions;

method arglist($/) {
	my $past := PAST::Op.new:
		:node($/),
		:pasttype<call>,
		;

	for $<argument> {
		$past.push: $_.ast;
	}

	make $past;
}

method argument($/) {
	my $past := $<EXPR>.ast;
	$past.node($/);

	$past.named: ~$<argname>[0]
		if $<argname>;

	for $<arg_adverb> -> $adv {
		if $adv<token> eq 'flat' {
			$past.flat(1);
		}
		elsif $adv<token> eq 'named' {
			$past.named(1);
		}
	}

	make $past;
}

method ident($/) {
	make PAST::Var.new: :name(~ $/);
}

method infix:sym«->»($/) {
	make PAST::Var.new: :scope<attribute> ;
}

method infix:sym<.>($/) {
	make PAST::Var.new: :scope<attribute> ;
}

method postcircumfix:sym<[ ]>($/) {
	my $past := PAST::Var.new:
		:scope<keyed>,
		;
	$past.push: $<index>.ast;
	make $past;
}

method postcircumfix:sym<call>($/) {
	my $past := $<arglist>.ast;
	make $past;
}

#~ method postfix:sym<++>($/) {
#~ }

#~ method postfix:sym<-->($/) {
#~ }
	
method term:sym<int>($/) {
	make PAST::Val.new: :value($<integer>.ast) ;
}


method term:sym<identifier>($/) {
	my $past := PAST::Var.new:
		name => ~$<ident>,
		;
	make $past;
}
