y@WINTERMUTE C:\code\tech1
> python configure.py && make -sj9
           t1 hg version: 8459+ (d1c93cbc6122+)
      t1utils hg version: 1936+ (2dd70af512b6+)
   t1grabbers hg version: 3728 (400895f0c113)
        t1rpc hg version: 198 (5f9ef39e2840)
     t1script hg version: 1025+ (62faf0e8ceb2+)
abort: repository ../tech1pos not found!
        t1lpr hg version: 365 (b88197187575)
abort: repository ../tech1dome not found!
   t1research hg version: 1720+ (93faa0bdd375+)
abort: repository ../tech1fac not found!
abort: repository ../tech1installer not found!
Traceback (most recent call last):
  File "configure.py", line 1029, in <module>
    m.write_auto()
  File "C:\code\tech1utils\ab\ab_makefile.py", line 479, in write_auto
    self.write(vc71(), 1)
  File "C:\code\tech1utils\ab\ab_makefile.py", line 462, in write
    success_list = self.write_makefile(platform, f, make_program=0)
  File "C:\code\tech1utils\ab\ab_makefile.py", line 395, in write_makefile
    success_list_debug += self.exe_to_rules(exe_debug, make_program, outfile, debug=1)
  File "C:\code\tech1utils\ab\ab_makefile.py", line 334, in exe_to_rules
    exe.work(debug)
  File "C:\code\tech1utils\ab\ab.py", line 579, in work
    Target.work(self, debug)
  File "C:\code\tech1utils\ab\ab.py", line 520, in work
    while self.work_iteration(debug):
  File "C:\code\tech1utils\ab\ab.py", line 514, in work_iteration
    eval(func + "(f, gr, self, debug)")
  File "<string>", line 1, in <module>
  File "C:\code\tech1utils\ab\ab.py", line 434, in task_pch_h
    dest = eval("%s_pch(target, src, pch_group, obj_group, debug)" % target.platform.compiler)
  File "<string>", line 1, in <module>
  File "C:\code\tech1utils\ab\ab_vc71.py", line 163, in pch
    cpp.expand_uses(target, debug)
  File "C:\code\tech1utils\ab\ab.py", line 343, in expand_uses
    eval(fcall)
  File "<string>", line 1, in <module>
NameError: name 'use_vaapi' is not defined