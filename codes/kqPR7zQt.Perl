#!/usr/bin/perl 

use strict;
use warnings;
use XML::LibXML;

my @paths = (
    '/Foo/Bar[@attr="val"]/Baz/Bak',
    '/Foo/Baz/Bak',
    '/Foo/Bar/Baz/Bak/Bay',
);

my $doc = XML::LibXML::Document->new();;

for my $path (@paths) {
    my $val = '** VAL **';
    my @elements = split /\//, $path;

    if ($path =~ /^\//) { # Throw away blank
        shift @elements;
    }
   
    my $previous;
    while ( my $element = shift @elements ) {
        my $node;
        my $attrs = extract_attrs($element);
        (my $node_name = $element) =~ s/\[.+?\]//g;

        if (!$previous) {
            if (!$doc->documentElement) {
                $doc->setDocumentElement(XML::LibXML::Element->new($node_name));
                for my $key (keys %{$attrs}) {
                    $doc->documentElement->setAttribute($key, $attrs->{$key});
                }
                print qq{Set document elmeent to "$node_name"\n};
            }
            else {
                my $root1 = $doc->documentElement->nodeName;
                my $root2 = $element;

                if ($root1 ne $root2) {
                    die qq{MISMATCH! Root elements do not match: "$root1" <> "$root2"};
                }
            }
            $node = $doc->documentElement;
        }
        else { 
            ($node) = @{$previous->find(qq{./$node_name})};

            if ( ! $node ) {
                $node = XML::LibXML::Element->new($node_name);
                print qq{Got node for $element\n};
                for my $key (keys %{$attrs}) {
                    print qq{Set attr $key to $attrs->{$key}\n};
                    $node->setAttribute($key, $attrs->{$key});
                }
                $previous->addChild($node);
                print "Append $node_name to " . $previous->nodeName . qq{\n};
            }
        }
        $previous = $node;
    }
    # $previous has become the leaf here
    $previous->appendText($val);
    print "$doc\n";
    1;
}

sub extract_attrs {
    my $element = shift;

    my @attr_strings = ($element =~ m/(\[.+?\])/); # Capture everything between [ and ].
    if (scalar @attr_strings > 1) {
        die q{Invalid attribute specification. Specify multiple attrs as [@attr1=val1,@attr2=val2]};
    }
    my %attrs;
    if (@attr_strings) {
        for my $string (split /,/, $attr_strings[0]) {
            my ($key, $val) = ($string =~ m/\[@?\s*(\w+)\s*=\s*"(\w+)"\s*\]/);

            if (!$key) {
                die qq{Malformed attribute specification: "$string". Should be [key="value"] (DOUBLE QUOTES MANDATORY)\n};
            }
            if (exists $attrs{$key}) {
                warn qq{Duplicate key "$key" in attrs};
            }
            $attrs{$key} = $val;
        }
    }
    return \%attrs;
}