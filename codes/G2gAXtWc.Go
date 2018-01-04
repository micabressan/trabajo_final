package util

import "time"

type ImmediateTicker struct {
	ticker   *time.Ticker
	C        <-chan time.Time // The channel on which the ticks are delivered.
	cancelCh <-chan struct{}
}

func NewImmidiateTicker(d time.Duration) *ImmediateTicker {
	it := ImmediateTicker{
		ticker:   time.NewTicker(d),
		C:        make(chan time.Time, 1),
		cancelCh: make(chan struct{}),
	}
	go func() {
		it.C <- time.Now()
		for {
			select {
			case time := <-it.ticker.C:
				it.C <- time
			case <-it.cancelCh:
				return
			}

		}
	}()
	return &it
}

func (t *ImmediateTicker) Stop() {
	t.ticker.Stop()
	t.cancelCh <- struct{}{}
}