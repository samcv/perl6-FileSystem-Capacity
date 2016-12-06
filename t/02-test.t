use v6;
use lib 'lib';
use Test;
use FileSystem::Capacity::VolumesInfo;

plan 2;

subtest {

	# byte version	
	my %vols = volumes-info();

	for %vols.sort(*.key)>>.kv -> ($location, $data) {
	  like $location, /^.+/, "Location have a character or more";
	  ok ($data<size> > 0), "Size > 0";
	  ok ($data<used> >= 0), "Used >= 0";
	  like $data<used%>, /^\d ** 1..2\%/, "Used% is a percent";
	  ok ($data<free> >= 0), "Free >= 0";
	}
}

subtest {

	# human version	
	my %vols-human = volumes-info(:human);

	for %vols-human.sort(*.key)>>.kv -> ($location, $data) {
	  like $location, /^.+/, "Location have a character or more";
	  like $data<size>,  /\d+\s\w ** 2..5/, "Size is int, space and suffix";
	  like $data<used>,  /\d+\s\w ** 2..5/, "Used is int, space and suffix";
	  like $data<used%>, /^\d ** 1..2\%/, "Used% is a percent";
	  like $data<free>,  /\d+\s\w ** 2..5/, "Free is int, space and suffix";
	}
}