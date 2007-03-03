use ExtUtils::MakeMaker;

use strict;

sub MY::metafile {
  package MY;
  my $self = shift;
  if (!eval { require YAML; 1 })
  {
    warn ("YAML not installed, 'make dist' will not override META.yml");
    return $self->SUPER::metafile_target(@_);
  };

  require YAML::Node;
  my $node = new YAML::Node {};

  $node->{name}			= $self->{DISTNAME};
  $node->{author}		= 'Tels';
  $node->{abstract}		= 'Math::BigInt::Calc with some XS for more speed';
  $node->{version}		= $self->{VERSION};
  $node->{version_from}		= $self->{VERSION_FROM};
  $node->{license}		= 'perl';
  $node->{distribution_type}	= 'module';
  $node->{generated_by}		= "$self->{DISTNAME} version $self->{VERSION}";
  $node->{installdirs}		= $self->{INSTALLDIRS},
  $node->{requires}		= $self->{PREREQ_PM};

  my $dump = YAML::Dump( $node );

  $dump =~ s/^(.*)$/\t\$(NOECHO) \$(ECHO) "$1" >>META.yml/gm;
  $dump =~ s/>>META\.yml/>META.yml/;

  "metafile:\n$dump";
}

my @extra;
my $PERL_CORE = grep $_ eq "PERL_CORE=1", @ARGV;
push @extra, 'MAN3PODS' => {} if $PERL_CORE;

WriteMakefile(
    'NAME'		=> 'Math::BigInt::FastCalc',
    'VERSION_FROM'	=> 'lib/Math/BigInt/FastCalc.pm', # finds $VERSION
    'PREREQ_PM'		=> {
	'Math::BigInt' => 1.79,
    },
    INSTALLDIRS		=> 'perl',
    @extra,
 );
