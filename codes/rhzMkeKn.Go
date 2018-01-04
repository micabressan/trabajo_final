package main

import (
        "io"
        "fmt"
        "log"
        "net"
        "github.com/vmihailenco/msgpack"
        "reflect"
)

func reader(r io.Reader) {
        buf := make([]byte, 1024)
        for {
                n, err := r.Read(buf[:])
                if err != nil {
                        log.Fatal("Dial error", err)
                        return
                }
                fmt.Println("Client got:", string(buf[0:n]))
                var item map[string]interface{}
                err = msgpack.Unmarshal(buf, &item)
                if err != nil {
                        // panic(err)
                        log.Fatal("Dial error", err)
                }
                fmt.Println("Unpack got:", item)
                fmt.Println("type is :", reflect.TypeOf(item))
        }
}

func main() {
        b, err := net.Dial("unix", "/var/run/salt/master/master_event_pub.ipc")
        if err != nil {
                log.Fatal("Dial error", err)
        }
        defer b.Close()

        for {
                // go reader(c)
                // go reader(a)
                reader(b)

        }
}

/*
Client got: ��body�salt/auth

��id�salt-syndic-01�_stamp�2017-12-23T12:45:31.779092�resultãpub��-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Q9pMDWtN76WIaFmzB+s
FKgdcz4AZ9+C/N9BPXVjvcgddHDjPjuxj8yYUSKSkFdnmDfqu8tea67FSt60DgMF
hrFqZYy6rmQKn4LIuJbPBeS+H5dxZTbfv7H7X2+w/AnAat2go42WqMftL0b79zbs
a9dg3xUaobORJRVFU3OCBT5+ANFLzYQCqlr/c1lvpQMvpmYkCfiJl4xXJiA2p5yB
grZ6vKTP/JU8W+ATYeu9S3VC21SAyjrVGQ9/n1JdbzblqJPAeZUIgf3AwXidJoEI
WjBvPARLA+UvJ9nsfCNEGyq0ZUeE6NyQhaV5bVMhOXFL8JeBy16ur4qbA7NyvxuZ
pQIDAQAB
-----END PUBLIC KEY-----�act�accept�head�
Unpack got: map[body:salt/auth

��id�salt-syndic-01�_stamp�2017-12-23T12:45:31.779092�resultãpub��-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Q9pMDWtN76WIaFmzB+s
FKgdcz4AZ9+C/N9BPXVjvcgddHDjPjuxj8yYUSKSkFdnmDfqu8tea67FSt60DgMF
hrFqZYy6rmQKn4LIuJbPBeS+H5dxZTbfv7H7X2+w/AnAat2go42WqMftL0b79zbs
a9dg3xUaobORJRVFU3OCBT5+ANFLzYQCqlr/c1lvpQMvpmYkCfiJl4xXJiA2p5yB
grZ6vKTP/JU8W+ATYeu9S3VC21SAyjrVGQ9/n1JdbzblqJPAeZUIgf3AwXidJoEI
WjBvPARLA+UvJ9nsfCNEGyq0ZUeE6NyQhaV5bVMhOXFL8JeBy16ur4qbA7NyvxuZ
pQIDAQAB
-----END PUBLIC KEY-----�act�accept head:map[]]
type is : map[string]interface {}
*/

/*
normally it should be something like this :
tag = salt/auth; data = {'id': 'salt-syndic-01', '_stamp': '2017-12-23T12:47:17.035188', 'result': True, 'pub': '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Q9pMDWtN76WIaFmzB+s\nFKgdcz4AZ9+C/N9BPXVjvcgddHDjPjuxj8yYUSKSkFdnmDfqu8tea67FSt60DgMF\nhrFqZYy6rmQKn4LIuJbPBeS+H5dxZTbfv7H7X2+w/AnAat2go42WqMftL0b79zbs\na9dg3xUaobORJRVFU3OCBT5+ANFLzYQCqlr/c1lvpQMvpmYkCfiJl4xXJiA2p5yB\ngrZ6vKTP/JU8W+ATYeu9S3VC21SAyjrVGQ9/n1JdbzblqJPAeZUIgf3AwXidJoEI\nWjBvPARLA+UvJ9nsfCNEGyq0ZUeE6NyQhaV5bVMhOXFL8JeBy16ur4qbA7NyvxuZ\npQIDAQAB\n-----END PUBLIC KEY-----', 'act': 'accept'}
*/