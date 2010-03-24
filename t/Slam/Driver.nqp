#! /usr/bin/env parrot-nqp
# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or 
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
	# Load the Kakapo library
	my $env := pir::new__PS('Env');
	my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
	pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
}

class Test::Slam::Driver
	is UnitTest::Testcase ;

has	$!sut;
	
INIT {
	use(	'UnitTest::Testcase' );
	use(	'UnitTest::Assertions' );
	use(	'Cuckoo' );
	
	pir::load_bytecode('library/slam.pir');
	pir::load_bytecode('src/Slam/Driver.pir');
}

TEST_MAIN();

#method main() { self.set_up; self.test_files; }

method set_up() {
	$!sut := Dummy::Slam::Driver.new;
}

class Dummy::Slam::Driver 
	is Slam::Driver {
}

method test_file() {
	verify_that( 'Running with a file on the command line tries to compile the file' );
	
	# given
	my $*FileSystem := Cuculus::MockFS.new;
	$*FileSystem.add_entry: 'file.c=', contents => "Contents of file.c=";

	my $compiler := cuckoo( Slam::Compiler ).new;
	pir::compreg__vSP('close', $compiler);
	
	# when
	$!sut.run: argv => < slam file.c= >;
	
	#then
	verify( $compiler ).compile( "Contents of file.c=" );
}

method test_files() {
	verify_that( 'Running with multiple files on the command line tries to compile them all' );
	
	# given
	my $*FileSystem := Cuculus::MockFS.new;
	$*FileSystem.add_entry: 'file1.c=', contents => "Contents of file1.c=";
	$*FileSystem.add_entry: 'file2.c=', contents => "Contents of file2.c=";
	$*FileSystem.add_entry: 'file3.c=', contents => "Contents of file3.c=";

	my $compiler := cuckoo( Slam::Compiler ).new;
	pir::compreg__vSP('close', $compiler);
	
	# when
	$!sut.run: argv => < slam file1.c= file2.c= file3.c= >;
	
	#then
	verify( $compiler ).compile( "Contents of file1.c=" );
	verify( $compiler ).compile( "Contents of file2.c=" );
	verify( $compiler ).compile( "Contents of file3.c=" );
}

method test_version() {
	verify_that( 'Running with --version prints the version message' );
	
	# given
	my $fake_stdout := Parrot::new( 'StringHandle' );
	$fake_stdout.open('stdout', 'rw');

	$!sut.stdout: $fake_stdout;

	# when
	$!sut.run(< slam --version >);
	
	# then
	my $output := $fake_stdout.readall;

	assert_true( $output.index( 'Slam version') != -1,
		'Output must include correct phrase');
}
