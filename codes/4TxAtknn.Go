package main

import (
	"encoding/json"
	"net/http"
	"time"
	"os"
	"strings"
	"io/ioutil"

	"github.com/gocraft/web"
	"github.com/satori/go.uuid"
)

var logContextDaemon LoggerContext
var daemonLocalStatus *StatusModule

type statusJobs struct {
	Jobs []Job `json:"jobs"`
}

// Context ...
type Context struct {
	ScriptsDir string
}

// SetDefaults initializes Context variables
func (c *Context) SetDefaults(w web.ResponseWriter, r *web.Request, next web.NextMiddlewareFunc) {
	next(w, r)
}

// RunHandler handles /run requests
func (c *Context) RunHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive RUN[%v] request from: %v", "Daemon", r.RemoteAddr)
	r.ParseForm()

	name := r.PathParams["script"]
	uuid := uuid.NewV4().String()
	timeout := 10
	params := r.Form
	ip := strings.Split(r.RemoteAddr, ":")[0]

	status, _ := daemonLocalStatus.GetState()
	if status == DaemonWorking {
		w.WriteHeader(http.StatusServiceUnavailable)
		return
	}

	w.WriteHeader(http.StatusOK)
	Submit(name, uuid, ip, params, time.Duration(timeout))
}

// LogHandler handles /log requests
func (c *Context) LogHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive LOG[%v] request from: %v", "Daemon", r.RemoteAddr)
	r.ParseForm()
	name := r.PathParams["script"]
	ids := r.Form["uuid"]
	var list [][]string
	var js []byte
	var err error

	if len(ids) > 0 {
		id := ids[0]
		buffer, readErr := Report(name, id)
		if readErr != nil {
			LogErr(logContextDaemon, "Error while reading report")
			return
		}
		js, err = json.Marshal(string(buffer))
	} else {
		list, err = ReportList(name)
		if err != nil {
			LogErr(logContextDaemon, "Unable to find log for this script")
			return
		}
		js, err = json.Marshal(list)
	}

	if err != nil {
		w.WriteHeader(http.StatusServiceUnavailable)
		LogErr(logContextDaemon, "json creation failed")
		return
	}

	w.Write(js)
}

// StatusHandler handles /state requests
func (c *Context) StatusHandler(w web.ResponseWriter, r *web.Request) {
	//general state requests

	if r.RequestURI == "/state" {
		LogInf(logContextDaemon, "Receive STATE[%v] request from: %v", "Daemon", r.RemoteAddr)
		js, err := json.Marshal(daemonLocalStatus)

		if err != nil {
			w.WriteHeader(http.StatusServiceUnavailable)
			LogErr(logContextDaemon, "json creation failed")
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.Write(js)
	} else {
		// script-name specific requests
		r.ParseForm()

		LogInf(logContextDaemon, "Receive STATE[%v] request from: %v", r.PathParams["script"], r.RemoteAddr)

		response := statusJobs{
			Jobs: daemonLocalStatus.GetJobs(r.PathParams["script"])}
		js, err := json.Marshal(response)
		if err != nil {
			w.WriteHeader(http.StatusServiceUnavailable)
			LogErr(logContextDaemon, "json creation failed")
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.Write(js)
	}
}

// HomeHandler ...
func (c *Context) HomeHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive HOME[%v] request from: %v", "Daemon", r.RemoteAddr)

	indexFile, err := os.Open("static/run.html")
    if err != nil {
        LogErr(logContextDaemon, "cannot open html home file")
        return
    }
    index, err := ioutil.ReadAll(indexFile)
    if err != nil {
        LogErr(logContextDaemon, "cannot read from html home file")
        return
    }
    w.Write(index)
}

//ListHandler ...
func (c *Context) ListHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive LIST[%v] request from: %v", "Daemon", r.RemoteAddr)
	scripts := List()
	js, err := json.Marshal(scripts)

	if err != nil {
		w.WriteHeader(http.StatusServiceUnavailable)
		LogErr(logContextDaemon, "json creation failed")
		return
	}

	w.Write(js)
}

// SetListHandler ...
func (c *Context) SetListHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive SETS[%v] request from: %v", "Daemon", r.RemoteAddr)
	r.ParseForm()
	list := r.Form["set"]
	var js []byte
	var err error

	if len(list) <= 0 {
		sets := SetsList()
		js, err = json.Marshal(sets)
	} else {
		set := GetSet(list[0])
		js, err = json.Marshal(set)
	}

	if err != nil {
		w.WriteHeader(http.StatusServiceUnavailable)
		LogErr(logContextDaemon, "json creation failed")
		return
	}

	w.Write(js)
}

func (c *Context) RunSetHandler(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive RUNSET[%v] request from: %v", "Daemon", r.RemoteAddr)
	set := r.PathParams["set"]
	scr_list := GetSet(set)
	repmap := make(map[string]string)

	for _, scr := range scr_list {
		status, _ := daemonLocalStatus.GetState()
		for status != DaemonIdle {
			status , _ = daemonLocalStatus.GetState()
		}

		name := strings.Split(scr, " ")[0]
		uuid := uuid.NewV4().String()
		repmap[uuid] = scr
		timeout := 10
		ip := strings.Split(r.RemoteAddr, ":")[0]
		args := strings.Split(scr, " ")[1:]
		url := "?"
		for _, arg := range args {
			url += arg + "&"
		}
		req, _ := http.NewRequest("GET", url, nil)
		req.ParseForm()
		params := req.Form

		Submit(name, uuid, ip, params, time.Duration(timeout))
	}
	status, _ := daemonLocalStatus.GetState()
	for status != DaemonIdle {
		status , _ = daemonLocalStatus.GetState()
	}
	time.Sleep(500 * time.Millisecond)
	CreateSetReport(repmap, set)
}

func (c *Context) Websocket(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive WEBSOCKET[%v] request from: %v", "Daemon", r.RemoteAddr)

	err := NewClient(w, r)
  	if err != nil {
    	LogErr(logContextDaemon, "%s", err)
    	return
  	}
	LogInf(logContextDaemon,"Websocket connected with %s", r.RemoteAddr)
}

func (c *Context) CloseWebsocket(w web.ResponseWriter, r *web.Request) {
	LogInf(logContextDaemon, "Receive CLOSEWEBSOCKET[%v] request from: %v", "Daemon", r.RemoteAddr)
	addr := strings.Split(r.RemoteAddr, ":") [0]
	err := RemoveClient(addr)
	if err != nil {
		LogErr(logContextDaemon, "%s", err)
	}
}

// DaemonInit ...
func DaemonInit(sm *StatusModule, cm *ConfigModule) {
	daemonLocalStatus = sm

	// init logger
	logContextDaemon = LoggerContext{
		level: cm.GetLogLevel("daemon", 3),
		name:  "DAEMON"}
	LogInf(logContextDaemon, "START")

	// init http handlers
	router := web.New(Context{})
	router.Middleware((*Context).SetDefaults)
	router.Middleware(web.StaticMiddleware("static"))
	router.Get("/run/:script", (*Context).RunHandler)
	router.Get("/log/:script", (*Context).LogHandler)
	router.Get("/state", (*Context).StatusHandler)
	router.Get("/state/:script", (*Context).StatusHandler)
	router.Get("/", (*Context).HomeHandler)
	router.Get("/service/list", (*Context).ListHandler)
	router.Get("/service/sets", (*Context).SetListHandler)
	router.Get("/runset/:set", (*Context).RunSetHandler)
	router.Get("/websocket", (*Context).Websocket)
	router.Get("/closews", (*Context).CloseWebsocket)

	// start http server
	address := cm.Get("daemon", "address", "0.0.0.0")
	port := cm.Get("daemon", "port", "8080")
	LogInf(logContextDaemon, "Listening on %s:%s", address, port)
	LogFatal(logContextDaemon, http.ListenAndServe(address+":"+port, router))
}