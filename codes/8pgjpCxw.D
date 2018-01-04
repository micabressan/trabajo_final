Podaj swoję hasło: 
Litwo! Ojczyzno moja! Ty jesteś jak zdrowie. Ile cię trzeba było ogrodniczki. Tylko co Francuz wymyśli, to mówiąc, że przymiotów jego trwogi wszczęła rzecz swoję tokowa i na szalach żebyśmy nasz ciężar poznali musim kogoś czekało. Stryj nieraz na filarach, podłoga wysłana kamieniem, Ściany bez żadnych ozdób, ale nie stało wody pełne naczynie blaszane ale nie widział, bo tak zawsze Wam tam ma albo o jakie pół godziny tak było rzęd ruszyć lub papugą w skroń ucałowawszy, uprzejmie pozdrowił. A na sąd Pańskiej cioci. Choć Sędzia sam nie dozwalał, by znaczyć w skroń ucałowawszy, 
MD5:
        811fa949e144304cb01c9185c63f75dc
SHA256:
        0183d739f6f6691cf250e33d2d52f17ccb76cbb00e44a5c23ee586d84d366b27
Whirlpool:
        ffaadc114e158042d8bc99bea9ebe0fe442951bec789857bd8f557d44c498d022a939d523a30cced369b3bd221e7780b976d516a08a6a6f623d741d82e8c08c1

Process returned 0 (0x0)   execution time : 54.597 s
Press ENTER to continue.



import tango.io.Stdout;
import tango.io.Console;

import tango.util.digest.Md5;
import tango.util.digest.Sha256;
import tango.util.digest.Whirlpool;

void main(string[] args)
{
        stdout("Podaj swoję hasło: ").nl;
        char[] haslo;
        Cin.readln( haslo );

        auto md5 = new Md5();
        md5.update(cast(ubyte[]) haslo);
        auto sha256 = new Sha256();
        sha256.update( cast(ubyte[]) haslo );
        auto whirlpool = new Whirlpool();
        whirlpool.update( cast( ubyte[]) haslo );

        stdout.formatln( "MD5:\n\t{}", md5.hexDigest() );
        stdout.formatln( "SHA256:\n\t{}", sha256.hexDigest() );
        stdout.formatln( "Whirlpool:\n\t{}", whirlpool.hexDigest() );

}