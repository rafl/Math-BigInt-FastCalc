use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Math::BigInt::FastCalc',
    'VERSION_FROM'	=> 'lib/Math/BigInt/FastCalc.pm', # finds $VERSION
    'PREREQ_PM'		=> {
	Math::BigInt => 1.61,
      }, # e.g., Module::Name => 1.1
#    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
#	# retrieve abstract from module
#      (ABSTRACT_FROM => 'lib/Math/BigInt/FastCalc.pm', 
#       AUTHOR     => 'Tels <http://bloodgate.com>') : ()),
    'LIBS'		=> [''], 	# e.g., '-lm'
    'DEFINE'		=> '', 		# e.g., '-DHAVE_SOMETHING'
	# Insert -I. if you add *.h files later:
    'INC'		=> '', 		# e.g., '-I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # 'OBJECT'		=> '$(O_FILES)', # link all the C files too
);
