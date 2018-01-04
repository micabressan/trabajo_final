lazy val foo = Project(
  "foo",
  file("foo"),
  settings = Defaults.defaultSettings ++ AkkaKernelPlugin.settings ++ Seq(
    AkkaKernelPlugin.distMainClass in AkkaKernelPlugin.Dist := "foo.kernel.Main"
  )
)