1.]
type Event struct {
        User string
        Time int64
}

type EventStatus struct {
        Event
        Status int
        StatusMsg string
}

type EventInfo struct {
        Event
        Info map[string]string
}

2.]
const (
        Status = iota
        Info
)

type Event struct {
        User string
        Time int64
        EventType int
        Arguments interface{}
}