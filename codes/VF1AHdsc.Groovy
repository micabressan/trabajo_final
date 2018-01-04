Dec-08 12:07:31.248 [main] DEBUG nextflow.cli.Launcher - $> /usr/local/bin/nextflow run ../main.nf -resume -name Test RNA Run: 1512731087 -profile docker --max_memory 7.GB --max_cpus 2 --max_time 48h --gtf ./test_data/ngi-rna_test_set/genes.gtf --bed12 ./test_data/ngi-rna_test_set/genes.bed --hisat2_index ./test_data/ngi-rna_test_set/r64/ --aligner hisat2 --singleEnd --reads ./test_data/ngi-rna_test_set/*.fastq.gz
Dec-08 12:07:31.385 [main] INFO  nextflow.cli.CmdRun - N E X T F L O W  ~  version 0.25.7
Dec-08 12:07:31.413 [main] INFO  nextflow.cli.CmdRun - Launching `../main.nf` [Test RNA Run: 1512731087] - revision: 133563c128
Dec-08 12:07:31.427 [main] DEBUG nextflow.config.ConfigBuilder - Found config base: /Users/philewels/GitHub/NGI-RNAseq/nextflow.config
Dec-08 12:07:31.429 [main] DEBUG nextflow.config.ConfigBuilder - Parsing config file: /Users/philewels/GitHub/NGI-RNAseq/nextflow.config
Dec-08 12:07:31.794 [main] DEBUG nextflow.config.ConfigBuilder - Setting config profile: 'docker'
Dec-08 12:07:31.953 [main] ERROR nextflow.cli.Launcher - Unable to parse config file: '/Users/philewels/GitHub/NGI-RNAseq/nextflow.config' 

  Compile failed for sources FixedSetSources[name='/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c']. Cause: org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
  /groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 91: unable to resolve class MemoryUnit 
   @ line 91, column 22.
         if(obj.compareTo(params.max_memory as MemoryUnit) == 1)
                          ^
  
  /groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 96: unable to resolve class TimeUnit 
   @ line 96, column 22.
         if(obj.compareTo(params.max_time as TimeUnit) == 1)
                          ^
  
  2 errors

ch.grengine.except.CompileException: Compile failed for sources FixedSetSources[name='/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c']. Cause: org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 91: unable to resolve class MemoryUnit 
 @ line 91, column 22.
       if(obj.compareTo(params.max_memory as MemoryUnit) == 1)
                        ^

/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 96: unable to resolve class TimeUnit 
 @ line 96, column 22.
       if(obj.compareTo(params.max_time as TimeUnit) == 1)
                        ^

2 errors

	at ch.grengine.code.groovy.DefaultGroovyCompiler.compile(DefaultGroovyCompiler.java:182)
	at ch.grengine.load.DefaultTopCodeCache.getUpToDateCode(DefaultTopCodeCache.java:77)
	at ch.grengine.load.LayeredClassLoader.loadMainClass(LayeredClassLoader.java:165)
	at ch.grengine.engine.LayeredEngine.loadMainClass(LayeredEngine.java:188)
	at ch.grengine.Grengine.loadMainClass(Grengine.java:652)
	at ch.grengine.BaseGrengine.load(BaseGrengine.java:356)
	at ch.grengine.BaseGrengine.load(BaseGrengine.java:264)
	at ch.grengine.BaseGrengine$load.call(Unknown Source)
	at nextflow.config.ComposedConfigSlurper.loadScript(ComposedConfigSlurper.groovy:178)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.groovy.runtime.callsite.PogoMetaMethodSite$PogoCachedMethodSiteNoUnwrapNoCoerce.invoke(PogoMetaMethodSite.java:210)
	at org.codehaus.groovy.runtime.callsite.PogoMetaMethodSite.callCurrent(PogoMetaMethodSite.java:59)
	at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCallCurrent(CallSiteArray.java:52)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:154)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:166)
	at nextflow.config.ComposedConfigSlurper.parse(ComposedConfigSlurper.groovy:253)
	at nextflow.config.ComposedConfigSlurper$parse$5.call(Unknown Source)
	at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCall(CallSiteArray.java:48)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:113)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:125)
	at nextflow.config.ConfigBuilder$_buildConfig0_closure7.doCall(ConfigBuilder.groovy:274)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.groovy.reflection.CachedMethod.invoke(CachedMethod.java:93)
	at groovy.lang.MetaMethod.doMethodInvoke(MetaMethod.java:325)
	at org.codehaus.groovy.runtime.metaclass.ClosureMetaClass.invokeMethod(ClosureMetaClass.java:294)
	at groovy.lang.MetaClassImpl.invokeMethod(MetaClassImpl.java:1022)
	at groovy.lang.Closure.call(Closure.java:414)
	at groovy.lang.Closure.call(Closure.java:430)
	at org.codehaus.groovy.runtime.DefaultGroovyMethods.each(DefaultGroovyMethods.java:2040)
	at org.codehaus.groovy.runtime.DefaultGroovyMethods.each(DefaultGroovyMethods.java:2025)
	at org.codehaus.groovy.runtime.DefaultGroovyMethods.each(DefaultGroovyMethods.java:2066)
	at org.codehaus.groovy.runtime.dgm$162.invoke(Unknown Source)
	at org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite$PojoMetaMethodSiteNoUnwrapNoCoerce.invoke(PojoMetaMethodSite.java:274)
	at org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite.call(PojoMetaMethodSite.java:56)
	at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCall(CallSiteArray.java:48)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:113)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:125)
	at nextflow.config.ConfigBuilder.buildConfig0(ConfigBuilder.groovy:267)
	at nextflow.config.ConfigBuilder$buildConfig0$2.callCurrent(Unknown Source)
	at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCallCurrent(CallSiteArray.java:52)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:154)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:174)
	at nextflow.config.ConfigBuilder.buildConfig(ConfigBuilder.groovy:234)
	at nextflow.config.ConfigBuilder$buildConfig$1.callCurrent(Unknown Source)
	at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCallCurrent(CallSiteArray.java:52)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:154)
	at org.codehaus.groovy.runtime.callsite.AbstractCallSite.callCurrent(AbstractCallSite.java:166)
	at nextflow.config.ConfigBuilder.build(ConfigBuilder.groovy:490)
	at nextflow.cli.CmdRun.run(CmdRun.groovy:203)
	at nextflow.cli.Launcher.run(Launcher.groovy:410)
	at nextflow.cli.Launcher.main(Launcher.groovy:564)
Caused by: org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 91: unable to resolve class MemoryUnit 
 @ line 91, column 22.
       if(obj.compareTo(params.max_memory as MemoryUnit) == 1)
                        ^

/groovy/script/ScriptDF5F87B03A3555376BEDA7CE7D5F7998/_nf_config_9c78e99c: 96: unable to resolve class TimeUnit 
 @ line 96, column 22.
       if(obj.compareTo(params.max_time as TimeUnit) == 1)
                        ^

2 errors

	at org.codehaus.groovy.control.ErrorCollector.failIfErrors(ErrorCollector.java:310)
	at org.codehaus.groovy.control.CompilationUnit.applyToSourceUnits(CompilationUnit.java:958)
	at org.codehaus.groovy.control.CompilationUnit.doPhaseOperation(CompilationUnit.java:605)
	at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:554)
	at ch.grengine.code.groovy.DefaultGroovyCompiler.compile(DefaultGroovyCompiler.java:145)
	... 56 common frames omitted