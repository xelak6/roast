use v6;
use Test;

# L<S32::Containers/List/"=item reverse">

plan 19;



=begin pod

Tests for "reverse", which always reverse lists now. See flip()
in S32-str for the string reversal

=end pod


my @a = reverse(1, 2, 3, 4);
my @e = (4, 3, 2, 1);

is(@a, @e, "list was reversed");

{
    my $a = reverse("foo");
    is($a, "foo", "string was not reversed; that's what flip() is for");

    @a = reverse "foo", "bar";
    is(+@a, 2, 'the reversed list has two elements');
    is(@a[0], "bar", 'the list was reversed properly');

    is(@a[1], "foo", 'the list was reversed properly');
}

# #?rakudo skip 'want()'
# {
#     my @cxt_log;
# 
#     class Foo {
#         my @.n;
#         method foo () {
#             push @cxt_log, want();
#             (1, 2, 3)
#         }
#         method bar () {
#             push @cxt_log, want();
#             return @!n = do {
#                 push @cxt_log, want();
#                 reverse self.foo;
#             }
#         }
#     }
# 
#     my @n = do {
#         push @cxt_log, want();
#         Foo.new.bar;
#     };
# 
#     is(~@cxt_log, ~("List (Any)" xx 4), "contexts were passed correctly around masak's bug");
#     is(+@n, 3, "list context reverse in masak's bug");
#     is(~@n, "3 2 1", "elements seem reversed");
# }

{
    my @a = "foo";
    my @b = @a.reverse;
    ok(@a.reverse ~~ Iterable, '.reverse returns an Iterable');
    my $b = @a.reverse;
    ok($b ~~ Iterable, '.reverse assigned to a scalar is Iterable');
    is(@b[0], "foo", 'our list is reversed properly');
    is($b, "foo", 'in scalar context it is still a list');
    is(@a[0], "foo", "original array left untouched");
    @a .= reverse;
    is(@a[0], "foo", 'in place reversal works');
}

{
    my @a = ("foo", "bar");
    my @b = @a.reverse;
    my $b = @a.reverse;
    is(@b[0], "bar", 'our array is reversed');
    is(@b[1], "foo", 'our array is reversed');

    is($b, "bar foo", 'in scalar context it is still a list');

    is(@a[0], "foo", "original array left untouched");
    is(@a[1], "bar", "original array left untouched");

    @a .= reverse;
    is(@a[0], "bar", 'in place reversal works');
    is(@a[1], "foo", 'in place reversal works');
}

# RT #77914
#?rakudo todo "RT #77914"
{
    is (<a b>, <c d>).reverse.join, 'dcba', '.reverse flattens lists';
}

# vim: ft=perl6
