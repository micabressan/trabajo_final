use Tk;
# Main Window
my $mw = new MainWindow;
#GUI Building Area
$mw->Label(-text => 'Hello, world!')->pack;
my $ent = $mw -> Entry() -> pack();
my $ent2 = $mw -> Entry() -> pack();
my $but = $mw -> Button(-text => "Hack, Anti, Hack", 
                -command =>\&push_button);
$but -> pack();
MainLoop;
#This is executed when the button is pressed 
sub push_button {
        $ent -> insert('end',$ent2->get);
       # my $file_val = $ent2->get;
        
       # print "Sending file $file_val to printer in font\n";
}   

sub kala ($file) {
	my $file_val = $ent2->get;
	return $file_val
	}