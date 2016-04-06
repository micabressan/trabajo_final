package airparse

import ("net/http";"io";"errors")

var err = errors.New("airparse side error")

type RepoFile struct {

    Id string
    FileName string
    Url string
    DataGZ http.Response
    DataXML http.Response
    Type string // deb or rpm

}

func (repofile *RepoFile) download(){

    repofile.DataGZ, err=http.Get(repofile.Url)

}