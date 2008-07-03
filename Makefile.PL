use strict;
use warnings;
use ExtUtils::MakeMaker;

my @requires = qw(
    Apache2::RequestRec
    Apache2::RequestUtil
    Apache2::Connection
    Apache2::Log
    Apache2::Const
    Test::More
);

WriteMakefile(
    NAME                => 'Apache2::checkReferer',
    AUTHOR              => 'Henk van Oers <hvo.pm@xs4all.nl>',
    VERSION_FROM        => 'lib/Apache2/checkReferer.pm',
    ABSTRACT_FROM       => 'lib/Apache2/checkReferer.pm',
    PL_FILES            => {},
    PREREQ_PM           => { map {($_ => '')} @requires },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Apache2-checkReferer-*' },
);
