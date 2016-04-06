[chrissly@ChrLaptop Serene-Conky]$ ./start.sh 
[chrissly@ChrLaptop Serene-Conky]$ conky: Syntax error (co_main:2: unexpected symbol near '#') while reading config file. 
conky: Assuming it's in old syntax and attempting conversion.
conky: llua_load: main.lua:172: invalid escape sequence near '"/sbin/route -n | grep -c '^0\.'
conky: Syntax error (co_weather:2: unexpected symbol near '#') while reading config file. 
conky: Assuming it's in old syntax and attempting conversion.
conky: Invalid value 'undecorate' for setting 'own_window_hints'. Valid values are: 'undecorated', 'below', 'above', 'sticky', 'skip_taskbar', 'skip_pager'.
conky: Syntax error (co_fact:2: unexpected symbol near '#') while reading config file. 
conky: Assuming it's in old syntax and attempting conversion.
conky: desktop window (1200026) is subwindow of root window (2b7)
conky: window type - desktop
conky: drawing to created window (0x3400002)
conky: drawing to double buffer
conky: llua_load: weather.lua:1: module 'cairo' not found:
	no field package.preload['cairo']
	no file '/usr/share/lua/5.3/cairo.lua'
	no file '/usr/share/lua/5.3/cairo/init.lua'
	no file '/usr/lib/lua/5.3/cairo.lua'
	no file '/usr/lib/lua/5.3/cairo/init.lua'
	no file './cairo.lua'
	no file './cairo/init.lua'
	no file '/usr/lib/conky/libcairo.so'
	no file '/usr/lib/lua/5.3/cairo.so'
	no file '/usr/lib/lua/5.3/loadall.so'
	no file './cairo.so'
conky: Syntax error (co_quote:2: unexpected symbol near '#') while reading config file. 
conky: Assuming it's in old syntax and attempting conversion.
conky: llua_load: fact.lua:1: module 'cairo' not found:
	no field package.preload['cairo']
	no file '/usr/share/lua/5.3/cairo.lua'
	no file '/usr/share/lua/5.3/cairo/init.lua'
	no file '/usr/lib/lua/5.3/cairo.lua'
	no file '/usr/lib/lua/5.3/cairo/init.lua'
	no file './cairo.lua'
	no file './cairo/init.lua'
	no file '/usr/lib/conky/libcairo.so'
	no file '/usr/lib/lua/5.3/cairo.so'
	no file '/usr/lib/lua/5.3/loadall.so'
	no file './cairo.so'
conky: llua_load: quote.lua:1: module 'cairo' not found:
	no field package.preload['cairo']
	no file '/usr/share/lua/5.3/cairo.lua'
	no file '/usr/share/lua/5.3/cairo/init.lua'
	no file '/usr/lib/lua/5.3/cairo.lua'
	no file '/usr/lib/lua/5.3/cairo/init.lua'
	no file './cairo.lua'
	no file './cairo/init.lua'
	no file '/usr/lib/conky/libcairo.so'
	no file '/usr/lib/lua/5.3/cairo.so'
	no file '/usr/lib/lua/5.3/loadall.so'
	no file './cairo.so'
conky: Invalid value 'undecorate' for setting 'own_window_hints'. Valid values are: 'undecorated', 'below', 'above', 'sticky', 'skip_taskbar', 'skip_pager'.
conky: Invalid value 'undecorate' for setting 'own_window_hints'. Valid values are: 'undecorated', 'below', 'above', 'sticky', 'skip_taskbar', 'skip_pager'.
conky: Invalid value 'undecorate' for setting 'own_window_hints'. Valid values are: 'undecorated', 'below', 'above', 'sticky', 'skip_taskbar', 'skip_pager'.
conky: llua_do_call: function conky_main execution failed: attempt to call a nil valueconky: desktop window (1200026) is subwindow of root window (2b7)
conky: desktop window (1200026) is subwindow of root window (2b7)

conky: window type - desktop
conky: drawing to created window (0x3600002)
conky: window type - desktop
conky: drawing to created window (0x3800002)
conky: drawing to double buffer
conky: conky: drawing to double buffer
llua_do_call: function conky_setup execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: desktop window (1200026) is subwindow of root window (2b7)
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: window type - desktop
conky: drawing to created window (0x3a00002)
conky: llua_do_call: function conky_setup execution failed: attempt to call a nil value
conky: drawing to double buffer
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_setup execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_setup execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
Traceback (most recent call last):
  File "Scripts/weather.py", line 6, in <module>
    import forecastio
ImportError: No module named forecastio
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
Traceback (most recent call last):
  File "Scripts/quote.py", line 45, in <module>
    config = readConfiguration()
  File "Scripts/quote.py", line 14, in readConfiguration
    config = yaml.load(config_file)
  File "/usr/lib/python2.7/site-packages/yaml/__init__.py", line 71, in load
    return loader.get_single_data()
  File "/usr/lib/python2.7/site-packages/yaml/constructor.py", line 37, in get_single_data
    node = self.get_single_node()
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 36, in get_single_node
    document = self.compose_document()
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 55, in compose_document
    node = self.compose_node(None, None)
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 84, in compose_node
    node = self.compose_mapping_node(anchor)
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 127, in compose_mapping_node
    while not self.check_event(MappingEndEvent):
  File "/usr/lib/python2.7/site-packages/yaml/parser.py", line 98, in check_event
    self.current_event = self.state()
  File "/usr/lib/python2.7/site-packages/yaml/parser.py", line 439, in parse_block_mapping_key
    "expected <block end>, but found %r" % token.id, token.start_mark)
yaml.parser.ParserError: while parsing a block mapping
  in "config.yml", line 1, column 1
expected <block end>, but found '<block mapping start>'
  in "config.yml", line 3, column 5
Traceback (most recent call last):
  File "Scripts/fact.py", line 45, in <module>
    config = readConfiguration()
  File "Scripts/fact.py", line 15, in readConfiguration
    config = yaml.load(config_file)
  File "/usr/lib/python2.7/site-packages/yaml/__init__.py", line 71, in load
    return loader.get_single_data()
  File "/usr/lib/python2.7/site-packages/yaml/constructor.py", line 37, in get_single_data
    node = self.get_single_node()
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 36, in get_single_node
    document = self.compose_document()
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 55, in compose_document
    node = self.compose_node(None, None)
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 84, in compose_node
    node = self.compose_mapping_node(anchor)
  File "/usr/lib/python2.7/site-packages/yaml/composer.py", line 127, in compose_mapping_node
    while not self.check_event(MappingEndEvent):
  File "/usr/lib/python2.7/site-packages/yaml/parser.py", line 98, in check_event
    self.current_event = self.state()
  File "/usr/lib/python2.7/site-packages/yaml/parser.py", line 439, in parse_block_mapping_key
    "expected <block end>, but found %r" % token.id, token.start_mark)
yaml.parser.ParserError: while parsing a block mapping
  in "config.yml", line 1, column 1
expected <block end>, but found '<block mapping start>'
  in "config.yml", line 3, column 5
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value
conky: llua_do_call: function conky_main execution failed: attempt to call a nil value