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
type Event struct {
        User string
        Time int64
        EventType int
        Arguments interface{}
}