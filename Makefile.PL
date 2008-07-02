use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Apache2::checkReferer',
    AUTHOR              => 'Henk van Oers <hvo.pm@xs4all.nl>',
    VERSION_FROM        => 'lib/Apache2/checkReferer.pm',
    ABSTRACT_FROM       => 'lib/Apache2/checkReferer.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Apache2-checkReferer-*' },
);
