# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Slam::SymbolTable
	is Slam::Debuggable;

has $!default_hll;

INIT {
	auto_accessors( :private );	# Share the ! accessors
}

our method current_scope() {
	self.stack[0];
}

our method current_namespace() {
	for self.stack {
		if $_.is_namespace {
			return $_;
		}
	}
	
	die( "No current namespace on stack.");
}

our method declare($symbol) {
	self.note: "Declaring symbol: '{$symbol.name}'";
	
	my $scope;
	
	if $symbol.is_builtin {
		$scope := self.pervasive_scope;
		
		if $symbol.has_qualified_name {
			#NOTE("Error: qualified name not allowed in pervasive scope");
			$symbol.error(:message(
				"A qualified name may not be a builtin."));
			$symbol.hll(Parrot::undef());
			$symbol.namespace(Parrot::undef());
		}
	}
	else {
		if $symbol.has_qualified_name {
			#NOTE("Fetching namespace");
			$scope := self._fetch_namespace_of($symbol);
		}
		else {
			#NOTE("Using current scope");
			$scope := self.current_scope;
		}
	}

	#NOTE("In scope: ", $scope);
	$scope.attach($symbol);
}
