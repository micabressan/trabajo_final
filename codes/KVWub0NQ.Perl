use strict;
use warnings;
use Encode;
use Data::Dumper;
use Math::Round;

$ARGV[0] = defined $ARGV[0] ? $ARGV[0] : 0;

my $sql = $ARGV[0] =~ m{sql} ? 1 : 0;

if ($sql)
{
    open SQL, ">drop_calc.sql";
    print STDERR "generating drop_calc.sql\n";
    print SQL "use l2gf_calc\n";
    print SQL "truncate Item_Drops;\ntruncate Items;\ntruncate NPCs;\n"
}

print STDERR "processing ai_tree.txt\n";
open AITREE, "ai_tree.txt";
my %ai_tree;
while (<AITREE>)
{
    chop;
    if ($_ =~ m{^([^:]+):(.*)})
    {
        $ai_tree{$1} = $2;
    }   
}
close AITREE;

print STDERR "processing asm-dec-npcname-e.dat\n";
open NPCNAME, "asm-dec-npcname-e.dat";
my %npc_names;
my %npc_name_cnt;
while (<NPCNAME>)
{
    my ($npc_id, $npc_name, $npc_title) = split "\t", $_;
    next if $npc_id eq 'id';
    $npc_name =~ s{^[au],|\\0$}{}g;
    $npc_title =~ s{^[au],|\\0$}{}g;
    my $treasure = '';
    $treasure = ' (Treasure Chest)' if $npc_name eq 'Kill Me' || $npc_name eq 'Open Me';
    $npc_names{$npc_id}{name} = $npc_name.(defined $npc_name_cnt{$npc_name} ? " ".($npc_name_cnt{$npc_name}+1) : '').$treasure;
    $npc_name_cnt{$npc_name}++;
    $npc_names{$npc_id}{title} = $npc_title;
}
close NPCNAME;

print STDERR "processing asm-dec-itemname-e.dat\n";
open ITEMNAME, "system_data/asm-dec-itemname-e.dat";
my %item_names;
while (<ITEMNAME>)
{
    if ($_ =~ m{^(\d+)\t([^\t]+)})
    {
        $item_names{$1} = $2;
    }   
}
close ITEMNAME;

print STDERR "processing Itemdata.txt\n";
open ITEMDATA, "<:encoding(ucs-2le)", "Itemdata.txt";
my %items;
my %item_ids;
while (<ITEMDATA>)
{
    if ($_ =~ m{item_begin\t[^\t]+\t(\d+)\t\[([^]]+)\]})
    {
        $items{$2} = $1;
    }
    if ($sql)
    {
        if ($_ =~ m{item_begin\t([a-z_]+)\t(\d+)\t\[([^]]+)\]\t(.*)\titem_end})
        {
            my %params;
            ($params{item_type}, $params{item_id}, $params{item_code_name}) = ($1, $2, $3);
            $item_ids{$params{item_code_name}} = $params{item_id};
            next if !defined $item_names{$params{item_id}};
            my @params = split "\t", $4;
            for (@params)
            {
                my ($name, $value) = split "=", $_, 2;
                if (defined $name)
                {
                    $params{$name} = $value;
                }
            }
            print SQL "INSERT INTO Items (Item_ID, Name, Crystal_Type, Default_Price, Item_Type, Armor_Type, Weapon_Type, Etcitem_Type) VALUES ($params{item_id}, \"$item_names{$params{item_id}}\", \"$params{crystal_type}\", $params{default_price}, \"$params{item_type}\", \"$params{armor_type}\", \"$params{weapon_type}\", \"$params{etcitem_type}\");\n" if $sql;
        }        
    }
}
close ITEMDATA;

sub parse_simple_drop($)
{
    my ($drop) = @_;
    my @drop;
    $drop =~ s{{\[([^]]+)\];(\d+);(\d+);(.*?)}}
    {
        push @drop, [$1, $2, $3, $4];
    }sexg;
    return \@drop;
}

sub parse_multi_drop($)
{
    my ($drop) = @_;
    $drop =~ s/\};\{\{\{/\};@\{\{\{/g;
    my @drop_groups = split ";@", $drop;
    my @drop;
    for my $drop_group (@drop_groups)
    {    
        if ($drop_group =~ m{{{(.*)};([^\}]+)}})
        {
            my $drops = parse_simple_drop($1);
            push @drop, [@{$drops}, $2]
        }
    }
    return \@drop;
}

sub chance($)
{
    my ($prc) = @_;
    if ($prc >= 5)
    {
        return ' '.(round($prc*10)/10).'%';    
    }
    return ' 1/'.round(100/$prc);
}

sub from_to($$)
{
    my ($from, $to) = @_;
    
    return $from != $to ? " [$from-$to]" : ($to != 1 ? " [$to]" : "");
}

sub item_name($)
{
    my ($item_code_name) = @_;
    return $item_names{$items{$item_code_name}};
}

my %mob_hp_inc =
(
  s_npc_prop_hp_lv_mq	=> -75,
  s_npc_prop_hp_lv_mh	=> -50,
  s_npc_prop_hp_lv_p1	=> 10,
  s_npc_prop_hp_lv_p2	=> 21,
  s_npc_prop_hp_lv_p3	=> 33,
  s_npc_prop_hp_lv_p4	=> 46,
  s_npc_prop_hp_lv_p5	=> 61,
  s_npc_prop_hp_lv_p6	=> 77,
  s_npc_prop_hp_lv_m2   => 100,
  s_npc_prop_hp_lv_m3	=> 200,
  s_npc_prop_hp_lv_m4	=> 300,
  s_npc_prop_hp_lv_m5	=> 400,
  s_npc_prop_hp_lv_m6	=> 500,
  s_npc_prop_hp_lv_m7	=> 600,
  s_npc_prop_hp_lv_m8	=> 700,
  s_npc_prop_hp_lv_m9	=> 800,
  s_npc_prop_hp_lv_m10	=> 900,
  s_npc_prop_hp_lv_m11	=> 1000,
  s_npc_prop_hp_lv_m12	=> 1100,
);

my %fighters =
(
    boss       => 1,
    collection => 1,
    treasure   => 1,
    warrior    => 1,
    zzoldagu   => 1,
);

print STDERR "processing npcdata_7x.txt\n";
open NPCDATA, "<:encoding(ucs-2le)", "npcdata_7x.txt";
my %drops;
my %info;
my %agro;
my %level;
my %type;
NPC: while (<NPCDATA>)
{
    chop;
    if ($_ =~ m{npc_begin\t([^\t]+)\t(\d+)\t\[([^]]+)\]})
    {
        my ($npc_type, $npc_id, $npc_name) = ($1, $2, $3);
        $type{$npc_id} = $npc_type;
        if ($_ =~ m{npc_ai=\{\[([^\]]+)\]})
        {
            if (defined $fighters{$npc_type} && defined $ai_tree{$1} && $ai_tree{$1} =~ m{aggressive|_ag_})
            {
                $agro{$npc_id} = 1;
            }
        }
        
        my %spoil;
        if ($_ =~ m{\tcorpse_make_list={(.*?)}\t})
        {
            my $drop = parse_simple_drop($1);
            if (scalar @{$drop})
            {
                for my $item (@{$drop})
                {
                    my ($item_code_name, $from, $to, $chance) = @{$item};
                    my $drop_str = item_name($item_code_name).":".from_to($from, $to).chance($chance);
                    push @{$spoil{$chance}}, $drop_str;
                    print SQL "INSERT INTO Item_Drops (Item_ID, NPC_ID, Cnt_From, Cnt_To, Chance, Type) VALUES ($item_ids{$item_code_name}, $npc_id, $from, $to, \"$chance\", \"s\");\n" if $sql;
                    #print "$drop_str\n";
                }
            }
        }
        for (reverse sort {$a <=> $b} keys %spoil)
        {
            for (@{$spoil{$_}})
            {
                push @{$drops{$npc_id}{spoil}}, $_;
            }
        }

        my %dropx;
        my %dropy;
        if ($_ =~ m{\tadditional_make_list={(.*?)}\t})
        {
            my $drop = parse_simple_drop($1);
            if (scalar @{$drop})
            {
                for my $item (@{$drop})
                {
                    my ($item_code_name, $from, $to, $chance) = @{$item};
                    my $drop_str = item_name($item_code_name).":".from_to($from, $to).chance($chance);
                    #print "$drop_str\n";
                    push @{$dropx{$chance}}, $drop_str;
                    print SQL "INSERT INTO Item_Drops (Item_ID, NPC_ID, Cnt_From, Cnt_To, Chance, Type) VALUES ($item_ids{$item_code_name}, $npc_id, $from, $to, \"$chance\", \"d\");\n" if $sql;
                }
            }            
        }
        if ($_ =~ m{\tadditional_make_multi_list={(.*?)}\t})
        {
            my $drop = parse_multi_drop($1);
            if (scalar @{$drop})
            {
                for my $group (@{$drop})
                {
                    my $group_chance = pop @{$group};
                    next if $group_chance == 0;
                    for my $item (@{$group})
                    {
                        my ($item_code_name, $from, $to, $chance) = ($item->[0], $item->[1], $item->[2], $item->[3] * ($group_chance/100));
                        my $drop_str = item_name($item_code_name).":".from_to($from, $to).chance($chance);
                        print SQL "INSERT INTO Item_Drops (Item_ID, NPC_ID, Cnt_From, Cnt_To, Chance, Type) VALUES ($item_ids{$item_code_name}, $npc_id, $from, $to, \"$chance\", \"d\");\n" if $sql;
                        if ($item_code_name eq 'adena')
                        {
                            push @{$drops{$npc_id}{drop}}, $drop_str;
                        }
                        else
                        {
                            push @{$dropx{$chance}}, $drop_str;
                        }
                        #print "$drop_str\n";
                    }
                }
            }
        }
        #ex_item_drop_list (herby)
        if ($_ =~ m{\tex_item_drop_list={(.*?)}\t})
        {
            my $drop = parse_multi_drop($1);
            if (scalar @{$drop})
            {
                for my $group (@{$drop})
                {
                    my $group_chance = pop @{$group};
                    next if $group_chance == 0;
                    for my $item (@{$group})
                    {
                        my ($item_code_name, $from, $to, $chance) = ($item->[0], $item->[1], $item->[2], $item->[3] * ($group_chance/100));
                        my $drop_str = item_name($item_code_name).":".from_to($from, $to).chance($chance);
                        if ($item_code_name =~ m{herb})
                        {
                            push @{$dropy{$chance}}, $drop_str;
                            print SQL "INSERT INTO Item_Drops (Item_ID, NPC_ID, Cnt_From, Cnt_To, Chance, Type) VALUES ($item_ids{$item_code_name}, $npc_id, $from, $to, \"$chance\", \"z\");\n" if $sql;
                        }
                        else
                        {
                            push @{$dropx{$chance}}, $drop_str;
                            print SQL "INSERT INTO Item_Drops (Item_ID, NPC_ID, Cnt_From, Cnt_To, Chance, Type) VALUES ($item_ids{$item_code_name}, $npc_id, $from, $to, \"$chance\", \"d\");\n" if $sql;
                        }
                    }
                }
            }
        }
        for (reverse sort {$a <=> $b} keys %dropx)
        {
            for (@{$dropx{$_}})
            {
                push @{$drops{$npc_id}{drop}}, $_;
            }
        }
        for (reverse sort {$a <=> $b} keys %dropy)
        {
            for (@{$dropy{$_}})
            {
                push @{$drops{$npc_id}{herbs}}, $_;
            }
        }        

        #info
        if ($_ =~ m{npc_begin\t([a-z_]+)\t(\d+)\t\[([^]]+)\]\t(.*)\tnpc_end})
        {
            my %params;
            ($params{npc_type}, $params{npc_id}, $params{npc_code_name}) = ($1, $2, $3);
            my @params = split "\t", $4;
            for (@params)
            {
                my ($name, $value) = split "=", $_, 2;
                if (defined $name)
                {
                    $params{$name} = $value;
                }
            }          
            if ($sql)
            {
                if (defined $npc_names{$params{npc_id}}{name})
                {
                    print SQL "INSERT INTO NPCs (NPC_ID, Name, Title, Level, NPC_Type) VALUES ($params{npc_id}, \"$npc_names{$params{npc_id}}{name}\", \"$npc_names{$params{npc_id}}{title}\", $params{level}, \"$params{npc_type}\");\n";
                }
            }
            else
            {
                my $exp = round(($params{level} * $params{level} * $params{acquire_exp_rate}) * 7);
                my $hp  = round(($params{con} * $params{org_hp}) / 27.3);
                my @skills = split ";", $params{skill_list};
                for (@skills)
                {
                    $_ =~ s{[\{\}@]}{}g;
                    if($mob_hp_inc{$_})
                    {
                        $hp  = $hp  + $hp  * ($mob_hp_inc{$_}/100);
                    }
                }
                if ($params{npc_type} ne 'pet')
                {
                    push @{$info{$npc_id}}, "Level: $params{level}" if $params{level};
                }
                $level{$npc_id} = $params{level} if $params{level};
                push @{$info{$npc_id}}, "Type: $npc_type";
                if (defined $fighters{$npc_type})
                {
                    push @{$info{$npc_id}}, "Exp: $exp, Exp/HP: ".round($exp*10/$hp)/10 if $exp;
                    push @{$info{$npc_id}}, "SP: $params{acquire_sp}, SP/HP: ".round($params{acquire_sp}*10/$hp)/10 if $params{acquire_sp};
                    push @{$info{$npc_id}}, "RP: $params{acquire_rp}" if $params{acquire_rp};
                    push @{$info{$npc_id}}, "HP: $hp" if $hp;
                    
                    my $defend = $params{base_attribute_defend};
                    $defend =~ s/^{|}$//g;
                    my @defend = split ";", $defend;
                    push @{$info{$npc_id}}, "Defence attributes:";
                    push @{$info{$npc_id}}, "Fire: $defend[0], Water: $defend[1]";
                    push @{$info{$npc_id}}, "Wind: $defend[2], Earth: $defend[3]";
                    push @{$info{$npc_id}}, "Holy: $defend[4], Unholy: $defend[5]";
                    push @{$info{$npc_id}}, "Special?: $defend[6]" if $defend[6];
                    
                    my $attack = $params{base_attribute_attack};
                    $attack =~ s/^{|}$//g;
                    my @attack = split ";", $attack;
                    if ($attack[0] ne 'none')
                    {
                        push @{$info{$npc_id}}, "Attack attribute: ".ucfirst($attack[0])." $attack[1]";
                    }
                }
            }
        }
    }
}
close NPCDATA;

exit if $sql;

######################################################################################################

open NEWSKILL, ">new-asm-dec-dex-skillname-e.dat";
open NEWSKILLGRP, ">new-asm-dec-dex-skillgrp.dat";

print STDERR "processing asm-dec-dex-skillname-e.dat\n";
open OLDSKILL, "asm-dec-dex-skillname-e.dat";
while (<OLDSKILL>)
{
    chop;
    print NEWSKILL "$_\n"; 
}
close OLDSKILL;

print STDERR "processing asm-dec-dex-skillgrp.dat\n";
open OLDSKILLGRP, "asm-dec-dex-skillgrp.dat";
while (<OLDSKILLGRP>)
{
    chop;
    print NEWSKILLGRP "$_\n"; 
}
close OLDSKILLGRP;

sub max($$) { $_[$_[0] < $_[1]] }

print STDERR "generating new-asm-dec-dex-skillname-e.dat, new-asm-dec-dex-skillgrp.dat\n";
for my $npc_id (sort keys %npc_names)
{
    if (defined $drops{$npc_id}{drop})
    {
        my $max = 0;
        for (@{$drops{$npc_id}{drop}})
        {
            $max = max(length $_, $max);
        }
        print NEWSKILL "50000\t$npc_id\tu,Drop - Nexus x7 ".("_"x($max-15))."\\0\tu,".join('\\\\n', @{$drops{$npc_id}{drop}})."\\0\ta,none\\0\ta,none\\0\n";
        print NEWSKILLGRP "50000\t$npc_id\t2\t0\t-1\t0\t4294967295\t0.00000000\t0\t\t\ticon.etc_adena_i00\t\t0\t0\t0\t-1\t-1\t-1\n";
    }
    if (defined $drops{$npc_id}{spoil})
    {
        my $max = 0;
        for (@{$drops{$npc_id}{spoil}})
        {
            $max = max(length $_, $max);
        }
        print NEWSKILL "50001\t$npc_id\tu,Spoil - Nexus x7 ".("_"x($max-16))."\\0\tu,".join('\\\\n', @{$drops{$npc_id}{spoil}})."\\0\ta,none\\0\ta,none\\0\n";
        print NEWSKILLGRP "50001\t$npc_id\t2\t0\t-1\t0\t4294967295\t0.00000000\t0\t\t\ticon.skill0254\t\t0\t0\t0\t-1\t-1\t-1\n";
    }
    if (defined $drops{$npc_id}{herbs})
    {
        my $max = 0;
        for (@{$drops{$npc_id}{herbs}})
        {
            $max = max(length $_, $max);
        }
        print NEWSKILL "50002\t$npc_id\tu,Herbs - Nexus x7 ".("_"x($max-16))."\\0\tu,".join('\\\\n', @{$drops{$npc_id}{herbs}})."\\0\ta,none\\0\ta,none\\0\n";
        print NEWSKILLGRP "50002\t$npc_id\t2\t0\t-1\t0\t4294967295\t0.00000000\t0\t\t\ticon.etc_recovery_set_i00\t\t0\t0\t0\t-1\t-1\t-1\n";
    }
    unshift @{$info{$npc_id}}, "Id: $npc_id";
    my $max = 0;
    for ( @{$info{$npc_id}})
    {
        $max = max(length $_, $max);
    }
    print NEWSKILL "50003\t$npc_id\tu,Npc Info - Nexus x7 ".("_"x($max-19))."\\0\tu,".join('\\\\n', @{$info{$npc_id}})."\\0\ta,none\\0\ta,none\\0\n";
    print NEWSKILLGRP "50003\t$npc_id\t2\t0\t-1\t0\t4294967295\t0.00000000\t0\t\t\ticon.etc_letter_white_i00\t\t0\t0\t0\t-1\t-1\t-1\n";
}

close NEWSKILL;
close NEWSKILLGRP;

print STDERR "processing asm-dec-dex-npcgrp.dat (generating new-asm-dec-dex-npcgrp.dat)\n";
open NEWNPCGRP, ">new-asm-dec-dex-npcgrp.dat";
open NPCGRP, "asm-dec-dex-npcgrp.dat";
while (<NPCGRP>)
{
    chop;
    
    if ($_ =~ m{^(\d+)})
    {
        my @data = split "\t", $_; 
        my $cnt = $data[14];        
        if ($cnt == 1 && $data[15] == 0)
        { #bug
             $cnt = 0;
        }
        if ($cnt <= 32 && defined $drops{$1}{drop})
        {
            $data[14+$cnt+1] = 50000;
            $data[14+$cnt+2] = $1;
            $cnt += 2;
        }
        if ($cnt <= 32 && defined $drops{$1}{spoil})
        {
            $data[14+$cnt+1] = 50001;
            $data[14+$cnt+2] = $1;
            $cnt += 2;
        }
        if ($cnt <= 32 && defined $drops{$1}{herbs})
        {
            $data[14+$cnt+1] = 50002;
            $data[14+$cnt+2] = $1;
            $cnt += 2;
        }
        if($cnt <=  32)
        {
            $data[14+$cnt+1] = 50003;
            $data[14+$cnt+2] = $1;
            $cnt += 2;
            $data[14] = $cnt;
        }
        print STDERR "fail $1\n" if ($cnt > 34);
        print NEWNPCGRP join("\t", @data);
        print NEWNPCGRP "\n";
    
    }
    else
    {
        print NEWNPCGRP $_."\n";
    } 
}
close NPCGRP;
close NEWNPCGRP;

print STDERR "asm-dec-npcname-e.dat (generating new-asm-dec-npcname-e.dat, new-level-asm-dec-npcname-e.dat)\n";
open NPCNAME, "asm-dec-npcname-e.dat";
open NPCNAMENEW, ">new-asm-dec-npcname-e.dat";
open NPCNAMENEWL, ">new-level-asm-dec-npcname-e.dat";
%npc_name_cnt = ();
while (<NPCNAME>)
{
    chop;
    if ($_ =~ m{^\d+})
    {
        my @npc = split "\t", $_;
        my $npc_name = $npc[1];
        if (defined $npc_name_cnt{$npc_name})
        {
            my $cnt = $npc_name_cnt{$npc_name}+1;
            $npc[1] =~ s{\\0$}{ $cnt\\0};
        }
        $npc_name_cnt{$npc_name}++;
        my @npcl = @npc;
        if (defined $agro{$npc[0]})
        {
            $npc[1] =~ s{\\0$}{!\\0};
            $npcl[1] =~ s{\\0$}{!\\0};
        }
        if (defined $type{$npc[0]} && defined $fighters{$type{$npc[0]}}) 
        {
            if ($npcl[2] eq 'a,')
            {
                 $npcl[2] = "a,$level{$npc[0]} lvl\\0";
            }
            else
            {
                $npcl[2] =~ s{\\0$}{ $level{$npc[0]} lvl\\0};
            }
        }
        print NPCNAMENEW join("\t", @npc)."\n";
        print NPCNAMENEWL join("\t", @npcl)."\n";
    }
    else
    {
        print NPCNAMENEW "$_\n";
        print NPCNAMENEWL "$_\n";
    }
}
close NPCNAME;
close NPCNAMENEW;
close NPCNAMENEWL;

my %pfiles =
(
    'new-asm-dec-dex-skillname-e.dat' => {ddf => 'DAT_defs/CT2_3en/skillname-e.ddf', asm => 'asm-skillname-e.dat', enc => 'patch/skillname-e.dat'},
    'new-asm-dec-dex-skillgrp.dat' => {ddf => 'DAT_defs/CT2_3en/skillgrp.ddf', asm => 'asm-skillgrp.dat', enc => 'patch/skillgrp.dat'},
    'new-asm-dec-dex-npcgrp.dat' => {ddf => 'new-npcgrp.ddf', asm => 'asm-npcgrp.dat', enc => 'patch/npcgrp.dat'},
    'new-asm-dec-dex-npcgrp.dat' => {ddf => 'new-npcgrp.ddf', asm => 'asm-npcgrp.dat', enc => 'patch/npcgrp.dat'},
    'new-asm-dec-npcname-e.dat' => {ddf => 'DAT_defs/CT2_3en/npcname-e.ddf', asm => 'asm-npcname-e.dat', enc => 'patch/npcname-e.dat'},
    'new-level-asm-dec-npcname-e.dat' => {ddf => 'DAT_defs/CT2_3en/npcname-e.ddf', asm => 'asm-level-npcname-e.dat', enc => 'patch/level-npcname-e.dat'},
);

for my $file (keys %pfiles)
{
    my $ddf = $pfiles{$file}{ddf};
    my $asm = $pfiles{$file}{asm};
    my $enc = $pfiles{$file}{enc};
    print STDERR "l2asm.exe -d $ddf $file $asm\n";
    system ("l2asm.exe -d $ddf $file $asm");
    print STDERR "l2encdec.exe -h 413 $asm $enc\n";
    system ("l2encdec.exe -h 413 $asm $enc");
}