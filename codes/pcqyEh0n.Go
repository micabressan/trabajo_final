	debugLogFile, err := bunnystub.NewIOWriter("./logs/debug.log", bunnystub.TimeRotate,
		bunnystub.WithVolumeSize("1KB"),
		bunnystub.WithConcurrency(100, true),
		bunnystub.WithTimePattern(`cfg:"log-time-rotate; */1 * * * * *; ; log time rotate pattern(s m h D M W)"`))
	if err != nil {
		panic(err)
	}

然后我在 main 中做如下测试：

func main() {
	for {
		time.Sleep(1 * time.Second)
		logger.Debugf(context.Background(), "Hello %v", 123)
	}
}