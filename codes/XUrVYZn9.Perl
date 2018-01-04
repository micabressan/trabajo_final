#!/usr/bin/perl
use warnings;
use YAML;

my %hardCoded = (
	"Shipyard" => [ "Energy Tube",
                  "Steel",
                  "Aluminium",
                  "Display",
                  "Metal Plate",
                  "Power Unit",
                  "Antigrav Unit",
                  "Fusion Core",
                  "Wire",
                  "Solar Cell",
                  "Solar Panel",
                  "Plastic" ],
	"Equipment Dock" => [ "Fuel",
                  "Rocket",
                  "Tools",
                  "Laser Compressor",
                  "Display",
                  "Laser Head",
                  "Power Unit",
                  "Antigrav Unit",
                  "Fusion Core",
                  "Wire",
                  "Drill",
                  "Warhead",
                  "Plastic"],
	"Repair Dock" => [ "Energy Tube",
                  "Fuel",
                  "Steel",
                  "Fusion Core",
                  "Display",
                  "Metal Plate",
                  "Power Unit",
                  "Antigrav Unit",
                  "Nanobot",
                  "Processor",
                  "Solar Cell",
                  "Solar Panel",
                  "Plastic"],
	"Military Outpost" => [ "War Robot",
                  "Body Armor",
                  "Vehicle",
                  "Gun",
                  "Ammunition",
                  "Ammunition S",
                  "Ammunition M",
                  "Ammunition L",
                  "Medical Supplies",
                  "Explosive Charge",
                  "Food Bar",
                  "Targeting System"],
	"Research Station" => [ "Turbine",
                  "High Capacity Lens",
                  "Neutron Accelerator",
                  "Electron Accelerator",
                  "Proton Accelerator",
                  "Fusion Generator",
                  "Anti-Grav Generator",
                  "Force Generator",
                  "Teleporter",
                  "Drill",
                  "Satellite"],
	"Biotope" => [
				"Food",
				"Food Bar",
				"Fungus",
				"Wood",
				"Glass",
				"Sheep",
				"Cattle",
				"Wheat",
				"Corn",
				"Rice",
				"Vegetable",
				"Water",
				"Coal",
				],
	"Casino" => [
				"Beer",
				"Wine",
				"Liquor",
				"Food",
				"Luxury Food",
				"Water",
				"Medical Supplies",
				],
	"Habitat" => [
				"Beer",
				"Wine",
				"Liquor",
				"Food",
				"Tea",
				"Luxury Food",
				"Spices",
				"Vegetable",
				"Fruit",
				"Cocoa",
				"Coffee",
				"Wood",
				"Meat",
				"Water",
				],
	"Turret Factory: Mining Laser" => [
				"Laser Compressor",
				"Laser Modulator",
				"High Capacity Lens",
				"Conductor",
				"Steel",
				],
	"Turret Factory: Lightning Gun" => [
				"Military Tesla Coil",
				"High Capacity Lens",
				"Electromagnetic Charge",
				"Conductor",
				"Copper",
				"Energy Cell",
				"Servo",
				],
	"Turret Factory: Plasma Gun" => [
				"Plasma Cell",
				"Energy Tube",
				"Conductor",
				"Energy Container",
				"Steel",
				"Crystal",
				],
	"Turret Factory: Salvaging Laser" => [
				"Laser Compressor",
				"Laser Modulator",
				"High Capacity Lens",
				"Conductor",
				"Steel",
				],
	"Turret Factory: Cannon" => [
				"Servo",
				"Warhead",
				"High Pressure Tube",
				"Explosive Charge",
				"Steel",
				"Wire",
				],
	"Turret Factory: Chain Gun" => [
				"Servo",
				"Steel Tube",
				"Ammunition S",
				"Steel",
				"Aluminium",
				"Lead",
				],
	"Turret Factory: Force Gun" => [
				"Force Generator",
				"Energy Inverter",
				"Energy Tube",
				"Conductor",
				"Steel",
				"Zinc",
				],
	"Turret Factory: Rocket Launcher" => [
				"Servo",
				"Rocket",
				"High Pressure Tube",
				"Fuel",
				"Targeting Card",
				"Steel",
				"Wire",
				],
	"Turret Factory: Bolter" => [
				"Servo",
				"High Pressure Tube",
				"Ammunition M",
				"Explosive Charge",
				"Steel",
				"Aluminium",
				],
	"Turret Factory: Laser" => [
				"Laser Head",
				"Laser Compressor",
				"High Capacity Lens",
				"Laser Modulator",
				"Steel",
				"Crystal",
				],
	"Turret Factory: Rail Gun" => [
				"Servo",
				"Electromagnetic Charge",
				"Electro Magnet",
				"Gauss Rail",
				"High Pressure Tube",
				"Steel",
				"Copper",
				],
	"Turret Factory: Repair Beam" => [
				"Nanobot",
				"Transformator",
				"Laser Modulator",
				"Conductor",
				"Gold",
				"Steel",
				],
	"Turret Factory: Tesla Gun" => [
				"Industrial Tesla Coil",
				"Electromagnetic Charge",
				"Energy Inverter",
				"Conductor",
				"Copper",
				"Energy Cell",
				]

);




open(my $DB, "<", "productionsindex.lua") or die "Cannot open DB";


while ( <$DB> )
{

	if ( $_ =~ /factory="(.+)", ingredients=\{(.*)\}, results=\{(.*)\}, garbages=\{(.*)\}\}\)/ ) { 
		#$factoryString = $1;
		$ingString = $2;
		#$resultString = $3;
		#$garbageString = $4;
		
		if ( $ingString eq "" ) { next; } 
		my (@goods,@ings);
		
		@goods = SepString($3);
		@ings = SepString($2);
		push(@goods,SepString($4));
		my $factoryName = GetName($1,$goods[0]);
		my $htmlName = GetHTMLName($1,$goods[0]);
		

		
		foreach $good (@goods) {			
			
			foreach $ing (@ings) {
				my @fact;
				if ( ref $goodsList{$good}{"MadeBy"}{$factoryName} ) {
					@fact = @{$goodsList{$good}{"MadeBy"}{$factoryName}}
				}
				push(@fact,$ing);
				$goodsList{$good}{"MadeBy"}{$factoryName} = \@fact;
			}
			#$goodsList{$good}{"MadeBy"}{$factoryName} = \@ings; 
		}
		foreach $good (@ings) {
			my @usedBy; 
			
			if ( ref $goodsList{$good}{"UsedBy"} ) {
				@usedBy = @{$goodsList{$good}{"UsedBy"}};
			}
			
			if ( !grep( /^$htmlName$/, @usedBy ) ) {
				push(@usedBy,$htmlName);
			}
			$goodsList{$good}{"UsedBy"} = \@usedBy;
		}
		
		
		
		#print( $1 . " *** " . $2 . " *** " . $3 . " *** " . $4 . "\n" );
		#return
	}
}
close($DB);




foreach $place ( keys %hardCoded ) {
	print "Adding $place\n";
	foreach $good (@{$hardCoded{$place}}) {
		my @usedBy;
		if ( ref $goodsList{$good}{"UsedBy"} ) {
			@usedBy = @{$goodsList{$good}{"UsedBy"}};
		}
		push(@usedBy,"<b>" . $place . "</b>");
		$goodsList{$good}{"UsedBy"} = \@usedBy;
	}
}

open(my $ITEMS, "<", "C:/Program Files (x86)/Steam/SteamApps/common/Avorion/data/scripts/lib/goodsindex.lua") or die ("could not open goodsindex");
while ( <$ITEMS> ) {
	if ( /goods\["(.+?)"\] = .+description="(.*?)".+price=(.+?),.*size=(.+?),.*level=(.+?),/ ) {
		my ($name,$desc,$price,$size,$level) = ($1, $2, $3, $4, $5);
		if ( exists $goodsList{$name} ) {
			$goodsList{$name}{"description"} = $desc;
			$goodsList{$name}{"price"} = $price;
			$goodsList{$name}{"size"} = $size;
			$goodsList{$name}{"level"} = $level;
		}
	}
}
close $ITEMS;



my @sortedGoods = sort { getDensity($a) <=> getDensity($b) } keys(%goodsList);

open(my $OUT, ">", "sortgoods.html") or die "Cannot open output";

print $OUT "<style> .good {border-style:solid; padding-left:20px;overflow:hidden;}\n";
print $OUT ".info {max-width:250px; margin:0; padding 1em; float:left;}\n";
print $OUT ".production {margin-left:260; padding: 1em;overflow:hidden}\n";
print $OUT "</style>\n";

foreach $good (@sortedGoods) {
	print $OUT "<div class=\"good\">\n";
	
	
	
	my $desc = $goodsList{$good}{"description"};
	my $price = $goodsList{$good}{"price"};
	my $size = $goodsList{$good}{"size"};
	my $level = $goodsList{$good}{"level"};
	print $OUT "<div class=\"info\">\n";
	print $OUT "<h3 id=\"$good\">$good</h3>\n";
	
	if ( $desc ) { print $OUT "<p>$desc</p>\n"; }
	else { print "$good has no desc\n"; }
	if ( $level ) { print $OUT "<p><b>Production Tier:</b> $level</p>\n"; }
	if ( $price ) { print $OUT "<p><b>Price:</b> $price</p>\n"; }
	if ( $size ) { print $OUT "<p><b>Volume:</b> $size</p>\n"; }
	if ( $size && $price ) { 
		my $per = sprintf("%.1f",$price / $size);
		print $OUT "<p><b>P/V:</b> $per</p>\n";
	}
	print $OUT "</div>\n";
	print $OUT "<div class=\"production\">\n";
	
	if ( exists $goodsList{$good}{"MadeBy"} ) {
		print $OUT "<h4>Made By:</h4>\n<ul>";
		foreach $factory (sort keys %{$goodsList{$good}{"MadeBy"}}) {
			print $OUT "<li>$factory (";
			my ( @ingList, $ing );
			foreach $ing (@{$goodsList{$good}{"MadeBy"}{$factory}}) {
				push(@ingList,"<a href=\"#$ing\">$ing</a>" )
			}
			print $OUT join(", ",@ingList);
			print $OUT ")</li>\n";
		}
		print $OUT "</ul>\n";
	}
	if ( exists $goodsList{$good}{"UsedBy"} ) { 
		print $OUT "<h4>Used By:</h4>\n<ul>";
		foreach $factory ( @{$goodsList{$good}{"UsedBy"}} ) {
			print $OUT "<li>$factory</li>\n";
		}
		print $OUT "</ul>\n";
	}
	
	
	print $OUT "</div></div>\n";
	
}
#print Dump(%hardCoded);
close($OUT);



sub getDensity {
	(my $good) = @_;
	my $price = $goodsList{$good}{"price"};
	my $size = $goodsList{$good}{"size"};

	if ( !$price|| !$size ) { return 0; }
	return $price / $size;

}

sub SepString {
	(my $string) = @_;
	my @retArray;
	while( $string =~ /name=['"](.+?)['"]/g ) {
		push(@retArray,$1);
	}
	return @retArray;
}

sub GetName {
	(my $string, my $goodName) = @_;
	
	
	
	
	$string =~ s/ \$\{size\}//;
	$string =~ s/\$\{good\}/$goodName/;
	
	
	if ( exists $goodsList{$goodName}{"MadeBy"}{$string} ) {
		my $newName = $string . " 2";
		my $num = 2;
		while ( exists $goodsList{$goodName}{"MadeBy"}{$newName} ) {
			$num++;
			$newName = $string . " " . $num;
		}
		$string = $newName;
	}
	return $string;
}

sub GetHTMLName {
	(my $string, my $goodName) = @_;
	$string =~ s/ \$\{size\}//;
	$string = "<a href=\"#$goodName\">" . $string;
	#$htmlString = "<a href=\"#$goodName\">$goodName";
	
	$string =~ s/\$\{good\}/$goodName/;
	$string = $string . "</a>";
	return $string;

}
	
# table.insert(productions, {factory="${good} Manufacturer ${size}", ingredients={{name="Steel", amount=1, optional=0}, {name="Silicium", amount=1, optional=0}, {name="Gold", amount=1, optional=0}, {name="Energy Cell", amount=1, optional=1}}, results={{name="Semi Conductor", amount=15}}, garbages={}})