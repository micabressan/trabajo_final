package shmabbix
type Granularity string
const (
    RsGranNone   Granularity = "none"
    RsGranDay    Granularity = "day"
    RsGranHour   Granularity = "hour"
)
type ShmabbixIf interface {
    Set( param string, value interface{} ) (error)
}
type Shmabbix struct {
    service string
    gran Granularity
    isEvent bool `json:"is_event"`
}
func (self *Shmabbix) Set( param string, value interface{} ) (err error) {
    ...
}