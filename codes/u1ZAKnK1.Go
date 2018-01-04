package main

import (
	"fmt"
	"path/filepath"

	//pb "github.com/decred/dcrwallet/rpc/walletrpc"
	//"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	//"github.com/decred/dcrwallet/wallet"
	"github.com/decred/dcrd/dcrutil"
	"github.com/decred/dcrd/hdkeychain"
)
var certificateFile = filepath.Join(dcrutil.AppDataDir("dcrwallet", false), "rpc.cert")
func main() {
	creds, err := credentials.NewClientTLSFromFile(certificateFile, "127.0.0.1")
	if err != nil {
		fmt.Println(err)
		return
	}
	conn, err := grpc.Dial("127.0.0.1:9111", grpc.WithTransportCredentials(creds))
	if err != nil {
		fmt.Println(err)
		return
	}
	defer conn.Close()
	// balanceRequest := &pb.BalanceRequest
	// 	AccountNumber:         0,
	// 	RequiredConfirmations: 1,
	// }
	// balanceResponse, err := c.Balance(context.Background(), balanceRequest)
	// if err != nil {
	// 	fmt.Println(err)
	// 	return
	// }

	// fmt.Println("Spendable balance: ", dcrutil.Amount(balanceResponse.Spendable))
	createWallet(conn)
}

func createWallet(connection *grpc.ClientConn){
	
	seed, err := hdkeychain.GenerateSeed(hdkeychain.RecommendedSeedLen)
	if err != nil{
		fmt.Println(err)
		return
	}
	fmt.Println("Seed: ", seed)
	// walletLoader := pb.NewWalletLoaderServiceClient(connection)
	// createWallet := &pb.CreateWalletRequest{
	// 	PublicPassphrase: publicPassPhrase,
	// 	PrivatePassphrase: privatePassphrase,
	// 	Seed: seed
	// }
	// createWalletResponse, err := walletLoader.CreateWallet(context.Background(), createWallet)
	// if err != nil{
	// 	fmt.Println(err)
	// 	return
	// }

}

//Should we go ahead with that?