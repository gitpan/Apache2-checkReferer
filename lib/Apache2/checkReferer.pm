package Apache2::checkReferer;

use warnings;
use strict;

=head1 NAME

Apache2::checkReferer - Prevent most "deep linking"

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

use Apache2::RequestRec ();
use Apache2::RequestUtil ();
use Apache2::Connection ();
use Apache2::Log ();
use Apache2::Const -compile => qw(OK FORBIDDEN);

=head1 SYNOPSIS

In httpd.conf:

=over 4

<Location /img/mybig.jpeg>

    PerlAccessHandler Apache2::checkReferer
    
    # option (default no) allow direct access
    # only check referer if there is one.
    PerlSetVar noRefererOK yes
    
</Location>

=back

You can steal my pictures, put them on your own server.
Most browsers send a referer header, some (behind a proxy) do not.
Also some search bots do not send a referer header.

=head1 FUNCTIONS

=head2 handler

A mod_perl2 handler. Checks wether or not your site's name is used in the referer header.

=cut

sub handler {
    my $r = shift;

    $r->subprocess_env;
    
    unless (defined $ENV{'HTTP_REFERER'}) {
        my $location = $r->location;
        my $uri      = $r->uri;
        my $ip       = $r->connection->remote_ip;
        my $ok       = lc($r->dir_config('noRefererOK')) || 'no';
        if ($ok ne 'yes' && $ok ne 'no') {
            $ok = 'no';
        }
        $r->log_error("checkReferer: $location, $uri, $ip noRefererOK=$ok");
        return Apache2::Const::FORBIDDEN
            if $ok eq 'no';
        return Apache2::Const::OK;
    }
    
    my $referer = $ENV{'HTTP_REFERER'};
    my $host    = $ENV{'HTTP_HOST'} || 'no host';
    
    my $prefered = qr{://\Q$host\E[:/]}i;
    if ($referer !~ $prefered) {
        my $location = $r->location;
        my $uri      = $r->uri;
        $r->log_error("checkReferer: $location, $uri, $host, $referer .");
        return Apache2::Const::FORBIDDEN;
    }
    
    return Apache2::Const::OK;
}

=head1 AUTHOR

Henk van Oers, C<< <hvo.pm at xs4all.nl> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-apache2-checkreferer at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Apache2-checkReferer>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.



=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Apache2::checkReferer


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Apache2-checkReferer>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Apache2-checkReferer>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Apache2-checkReferer>

=item * Search CPAN

L<http://search.cpan.org/dist/Apache2-checkReferer>

=back


=head1 ACKNOWLEDGEMENTS

Thanks to Mark Overmeer, Jan-Pieter Cornet and Juerd Waalboer
of the Amsterdam Perl Mongers (http://amsterdam.pm.org) for their
contributions and advise.

=head1 COPYRIGHT & LICENSE

Copyright 2008 Henk van Oers, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Apache2::checkReferer
