#! /usr/bin/env parrot-nqp
#
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# # Slam - a Close compiler #
#
# ## Description ##
#
# This is the main compiler class for Slam. 
#
class Slam::Compiler
	is HLL::Compiler;

INIT {
	Slam::Compiler.language('close');
	Slam::Compiler.parsegrammar(Slam::Grammar);
	Slam::Compiler.parseactions(Slam::Actions);
}

method _init_obj(*@pos, *%named) {
	super();
	
	%_Details := Hash.new(
		:language(		'close' ),
		:parsegrammar(	Slam::Grammar.new ),
		:parseactions(	Slam::Actions.new ),
	) unless our %_Details;

	%named.merge: %_Details;
	self._init_args(|@pos, |%named);
	
	self.addstage('transcode', :before<parse>);
	self;
}

method parse($source, *%adverbs) {
	unless %adverbs<actions> {
		%adverbs<actions> := %adverbs<target> eq 'parse' 
			?? pir::null__P()
			!! self.parseactions;
	}

	my %options_map := hash(
		actions => 'actions',
		parsetrace => 'rxtrace',
		rule => 'rule',
	);
	
	my %parse_flags;
	
	for %options_map -> $map {
		%parse_flags{$map.value} := %adverbs{$map.key}
			if %adverbs.contains: $map.key;
	}
	
	my $match := self.parsegrammar.parse($source, :p(0), |%parse_flags);
	
	self.panic('Failed to parse source')
		unless $match;
	
	$match;
}

method transcode($source, *%options) {
	if %options.contains: <tcode> {
		for %options<tcode>.split(' ') -> $charset {
			my $cset_id := pir::find_charset__IS( $charset );
			pir::assign__vSS( 
				$source, 
				pir::trans_charset__SSI( $source, $cset_id )
			);
				
			# No catch - if there's a transcode error, let it pass out.
		}
	}
	
	$source;
}

# Inherited methods:
#~ .sub 'init' :vtable :method
#~ .sub 'attr' :method
#~ .sub 'panic' :method
#~ .sub 'language' :method
#~ .sub 'stages' :method
#~ .sub 'parsegrammar' :method
#~ .sub 'parseactions' :method
#~ .sub 'astgrammar' :method
#~ .sub 'commandline_banner' :method
#~ .sub 'commandline_prompt' :method
#~ .sub 'removestage' :method
#~ .sub 'addstage' :method
#~ .sub 'compile' :method
#~ .sub 'parse' :method
#~ .sub 'past' :method
#~ .sub 'post' :method
#~ .sub 'pir' :method
#~ .sub 'evalpmc' :method
#~ .sub 'eval' :method
#~ .sub 'interactive' :method
#~ .sub 'EXPORTALL' :method
#~ .sub 'evalfiles' :method
#~ .sub 'process_args' :method
#~ .sub 'command_line' :method
#~ .sub 'parse_name' :method
#~ .sub 'dumper' :method
#~ .sub 'usage' :method
#~ .sub 'version' :method
