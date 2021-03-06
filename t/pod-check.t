#!perl -w
#
#  Test that the POD we include in our scripts is valid, via the external
# podchecker command.
#
# Steve
# --
#

use strict;
use Test::More;

my $bin_dir = $ENV{AS_INSTALLED_TESTING} ? '/usr/bin' : 'bin';
foreach my $file ( glob( "$bin_dir/xen-*-* $bin_dir/xt-*-*" ) )
{
    ok( -e $file, "$file" );
    ok( -x $file, " File is executable: $file" );
    ok( ! -d $file, " File is not a directory: $file" );

    if ( ( -x $file ) && ( ! -d $file ) )
    {
        #
        #  Execute the command giving STDERR to STDOUT where we
        # can capture it.
        #
        my $cmd           = "podchecker $file";
        my $output = `$cmd 2>&1`;
        chomp( $output );

        is( $output, "$file pod syntax OK.", " File has correct POD syntax: $file" );
    }
}

done_testing();
