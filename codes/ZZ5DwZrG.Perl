#!/usr/bin/perl
$|=1;
##
## Description: Z340-Olsen attempts to brute-force decrypt lines 1-3, and 11-13 of the
## Zodiac killer's "Z340" cipher, the lines determined by Dan Olsen @ FBI to contain a
## higher than normal amount of randomness. It takes one argument, a threshold value.
## This value tells the engine to not bother reporting on any results that contain less
## than <threshold> signal words. The default is 2, if not specified.
##
## Usage: z340-olsen.pl <threshold>
##
## Example: z340-olsen.pl 3
##
## Rosetta:
##
## English  Zodiac
## -------  ----------------------------
##  A       Capital H
##  B       Capital E
##  C       Capital R
##  D       Greater Than
##  E       Backwards P
##  F       Backwards L
##  G       Up Arrow
##  H       Down Arrow
##  I       Capital P
##  J       Backwards K
##  K       Capital I
##  L       Circle, Bottom Filled
##  M       Capital L
##  N       Capital T
##  O       Capital G
##  P       Circle, Top Filled
##  Q       Backwards D
##  R       Capital N
##  S       Plus Sign
##  T       Capital B
##  U       Circle, Vertical Slash
##  V       Black Box
##  W       Circle
##  X       Box, Southeast Filled
##  Y       Capital D
##  Z       Capital W
##  0       Capital Y
##  1       Dot
##  2       Less Than
##  3       Box, Southwest Filled
##  4       Capital K
##  5       Backwards F
##  6       Circle, Horizontal Slash
##  7       Backwards Y
##  8       Butt, Right Dot
##  9       Backwards C
##  Ä       Capital M
##  Ë       Capital U
##  Ï       Capital Z
##  Ö       Crosshairs
##  Ü       Capital H
##  À       Capital J
##  È       Forward Slash
##  Ì       Black Circle
##  Ò       Upside Down T
##  Ù       Backwards B
##  ä       Circle, Left Filled
##  ë       Filled P
##  ï       Capital F
##  ö       Circle Dot
##  ü       Triangle
##  Æ       Capital S
##  Þ       Butt, Left Dot
##  Ý       Black Triangle
##
##  Cipher Block:
##
## ABCDEFGHIJKLMNOPQ <-- Row 1
## RESTUVWXYZ0123456 <-- Row 2
## T789ÄSËÏOZU6MVÖÜÀ <-- Row 3
## ËSCÈÌÒBKY0TEÙNÄ4W <-- Row 11
## P29FCÀK3ÌNäÄ1SëTï <-- Row 12
## ÖöüÆ7VSRKÌïT9UÞÝC <-- Row 13

use utf8;   ## Perl doesn't handle Unicode interally unless you explicitly tell it to do so.
            ## Standard 8-bit ASCII doesn't have enough free symbols available to use in place
            ## of the 52 symbols in the block..So, we have to resort to Unicode here.

binmode (STDOUT,":utf8"); ## Same goes for printing Unicode chars..

print "\n\nZ340-Olsen: Spinning up..\n";

if ($ARGV[0])
{
    $threshold=$ARGV[0];
    print "Z340-Olsen: Threshold set to $threshold signal words. Note: Anything above 5 is probably a waste of time.\n";
}
else
{
    $threshold=2;
    print "Z340-Olsen: Default detection threshold of 2 signal words has been set.\n";
    print "Z340-Olsen: Decryption results that contain fewer than $threshold signal words will be ignored.\n";
}

@signalWords=("children","letter","stalking","conscience","christmass","cipher","pattern","reborn","piggies","become","beautiful","thinking","evening","daughter","deposit","battery","choaked","street","minuts","pulled","followed","offered","grabbed","during","california","prosecute","others","around","continue","people","closeing","crackproof","missed","police","reason","truley","phantom","because","rather","school","vallejo","useing","triger","howers","cerous","meannie","killed","victom","speaking","lyeing","awfully","announce","description","adjusted","someone","considerably","manpower","slaves","afterlife","killing","zodiac","scream","squirm","underground","intersting","idenity","woeman","untill");



for ($z=1;$z>0;$z++) ## Forever..
{
    ## We begin by defining the alphabets in use. Zodiac's alphabet, and ours. The cipherblock is comprised of Z340 Rows 1-3 + 11-13.

    $zodiacAlphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ÄËÏÖÜÀÈÌÒÙäëïöüÆÞÝ";
    $normalAlphabet="abcdefghijklmnopqrstuvwxyz";
    $cipherBlock="ABCDEFGHIJKLMNOPQRESTUVWXYZ0123456T789ÄSËÏOZU6MVÖÜÀËSCÈÌÒBKY0TEÙNÄ4WP29FCÀK3ÌNäÄ1SëTïÖöüÆ7VSRKÌïT9UÞÝC";

    ## Just a small speed improvement. These can be calculated up front..

    $lengthOfZodiacAlphabet=length $zodiacAlphabet;
    $lengthOfNormalAlphabet=length $normalAlphabet;

    ## Now, for every letter of the Zodiac alphabet, lets assign that symbol to a letter in the normal (English) alphabet.

    for ($x=0;$x<$lengthOfZodiacAlphabet;$x++)
    {
        $thisSymbol=substr($zodiacAlphabet,$x,1);
        $thisLetter=substr($normalAlphabet,int(rand($lengthOfNormalAlphabet)),1);
        $cipherHash{$thisLetter}.=" $thisSymbol ";
        $cipherBlock=~s/$thisSymbol/$thisLetter/g;
    }

    ## Tell the user how we're doing every so often..

    if ($z%3==0)
    {
            print "Z340-Olsen: Processing: Pass #$z [$cipherBlock]\r";
    }

    ## Check the decoding attempt for signal words..

    foreach $signal (@signalWords)
    {
        if ($cipherBlock=~/$signal/)
        {
            $signalValue++;
            $signalsFound.=" $signal";
        }
    }

    if ($signalValue>=$threshold)
    {
        chomp($dateStamp=`date`);
        print "Z340-Olsen: Processing: Pass #$z [$cipherBlock]\r";
        print "\nZ340-Olsen:\n";
        print "Z340-Olsen: Hmm.. Found something interesting..\n";
        print "Z340-Olsen: I just decoded this: [$cipherBlock]\n";
        print "Z340-Olsen: Have a look at the resulting message above, and see if it's readable. You might be onto something..\n";
        print "Z340-Olsen: Detection Time: $dateStamp, Pass: #$z, Count: $signalValue, Signal Words: $signalsFound )\n";
        print "Z340-Olsen: \n";
        print "Z340-Olsen: Key dump is as follows.. Not all letters of the alphabet may have been utilized. This is normal.\n";
        print "Z340-Olsen:\n";
        foreach $key (sort keys %cipherHash)
        {
            if (length($key))
            {
                print "Z340-Olsen: The letter \"$key\" should be used in place of these Zodiac symbols: $cipherHash{$key}\n";
            }
        }

        print "Z340-Olsen:\n";
        print "Z340-Olsen: Please refer to the symbol map in the source code. (Example: The Ý symbol corresponds to the black triangle.)\n";
        print "Z340-Olsen:\n";
        print "Z340-Olsen: Continuing search..\n";
    }

    %cipherHash="";
    $signalValue=0;
    $signalsFound="";

}