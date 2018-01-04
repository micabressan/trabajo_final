use POSIX;

chomp ($s = <stdin>);

$answer = 0;
$cur = 0;
foreach $item (split('', $s))
{
    if (isdigit($item))
    {
        $cur++;
    }
    else
    {
        $cur = 0;
    }
    if ($cur > $answer)
    {
        $answer = $cur;
    }
}

if ($cur > $answer)
{
    $answer = $cur;
}

print $answer."\n";