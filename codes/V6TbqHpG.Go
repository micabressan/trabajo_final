type Base struct {
    Success bool
    Error bool
}

type Response struct {
    Base
    Variable string
    Variable2 string
}

func (p *Base) getObj(url string) {
    resp,err := http.Get(url);
    if err == nil {
        b, err := ioutil.ReadAll(resp.Body);
        if err == nil {
            err := json.Unmarshal(b, &p);
            fmt.Printf("==== json: %s\n", b);
            if err != nil {
                p.Success = false;
                p.Error = err.String();
            }
        } else {
            p.Success = false;
            p.Error = err.String();
        }
    } else {
        p.Success = false;
        p.Error = err.String();
    }
}