package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strconv"
	"time"
	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)


type Chaincode struct {
}

type keyex struct {
	Id	string `json:"id"` 
	Appid	string `json:"appid"`    
	Endid	string `json:"endid"`
	Timestamp string `json:"timestamp"`
	Gparam	string `json:"gparam"`
	Pparam	string `json:"pparam"`
	Aparam	string `json:"aparam"`
	Bparam	string `json:"bparam"`
}


func main() {
	err := shim.Start(new(Chaincode))
	if err != nil {
		fmt.Printf("Error starting chaincode: %s", err)
	}
}


func (t *Chaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {

	id := "1"
	appid := "a"
	endid := "b"
	txntmsp, err := stub.GetTxTimestamp()
	if err !=nil {
		fmt.Errorf("Failed to timestamp")
	}
	time1 := time.Unix(txntmsp.Seconds, 0).String() //time1 := time.Unix(txntmsp.Seconds, int64(txntmsp.Nanos)).String()
	timestamp := time1
	gparam  := "1"
	pparam := "2"
	aparam := "3"
	bparam := "4"

	keyex := &keyex{id, appid, endid, timestamp, gparam, pparam, aparam, bparam}
	keyexJSONasBytes, err := json.Marshal(keyex)
	if err != nil {
		return shim.Error(err.Error())
	}
	err = stub.PutState(id, keyexJSONasBytes)
	if err != nil {
		return shim.Error(err.Error())
	}
	
	fmt.Sprintf("record successful!")
	return shim.Success(nil)

}

func (t *Chaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	function, args := stub.GetFunctionAndParameters()
	fmt.Println("invoke is running " + function)

	// Handle different functions
	if function == "recordkeyex" { 
		return t.recordkeyex(stub, args)
	//} else if function == "querykeyex" { 
		//return t.querykeyex(stub, args)
	} else if function == "queryallkeyex" {
		return t.queryallkeyex(stub)
	}
	fmt.Println("invoke did not find func: " + function) //error
	return shim.Error("Received unknown function invocation")
}


func (t *Chaincode) recordkeyex(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var err error	

	if len(args) != 6 {
		return shim.Error("Incorrect number of arguments. Expecting 6")
	}

	fmt.Println("- start record keyex")
	
	if len(args[0]) <= 0 {
		return shim.Error("1st argument must be a non-empty string")
	}
	if len(args[1]) <= 0 {
		return shim.Error("2nd argument must be a non-empty string")
	}
	if len(args[2]) <= 0 {
		return shim.Error("3rd argument must be a non-empty string")
	}
	if len(args[3]) <= 0 {
		return shim.Error("4th argument must be a non-empty string")
	}
	if len(args[4]) <= 0 {
		return shim.Error("5th argument must be a non-empty string")
	}
	if len(args[5]) <= 0 {
		return shim.Error("6th argument must be a non-empty string")
	}

	var startKey string
	var endKey string
	keysIter, err := stub.GetStateByRange(startKey, endKey)
	if err != nil { 
		return shim.Error(fmt.Sprintf("keys operation failed, error accessing ledger %s", err))
	}
	defer keysIter.Close()

	var keys []string
	for keysIter.HasNext() {
		response, iterErr := keysIter.Next()
		if iterErr != nil {
			return shim.Error(fmt.Sprintf("keys operation failed. Error accessing state: %s", err))
		}
		keys = append(keys, response.Key)
	}
	id := keys[len(keys)-1]
	fmt.Sprintf("Last id was %s", id)
	id_int, err := strconv.Atoi(id)
	if err != nil {
		return shim.Error(fmt.Sprintf("failed to convert id to numeric %s", err))
	}
	
	id_int = id_int+1
	id = strconv.Itoa(id_int)
	appid := args[0]
	endid := args[1]
	txntmsp, err := stub.GetTxTimestamp()
	if err !=nil {
		fmt.Errorf("Failed to timestamp")
	}
	time1 := time.Unix(txntmsp.Seconds, 0).String() //time1 := time.Unix(txntmsp.Seconds, int64(txntmsp.Nanos)).String()
	timestamp := time1
	gparam  := args[2]
	pparam := args[3]
	aparam := args[4]
	bparam := args[5]

	keyex := &keyex{id, appid, endid, timestamp, gparam, pparam, aparam, bparam}
	keyexJSONasBytes, err := json.Marshal(keyex)
	if err != nil {
		return shim.Error(err.Error())
	}
	err = stub.PutState(id, keyexJSONasBytes)
	if err != nil {
		return shim.Error(err.Error())
	}
	
	fmt.Sprintf("record successful!")
	return shim.Success(nil)
}

func (t *Chaincode) queryallkeyex(stub shim.ChaincodeStubInterface) pb.Response {

	var startKeyQ string
	var endKeyQ string
	resultsIterator, err := stub.GetStateByRange(startKeyQ, endKeyQ)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()
	
	var buffer bytes.Buffer

	buffer.WriteString("[")


	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- queryallkeyex:\n%s\n", buffer.String())

	return shim.Success(buffer.Bytes())
}