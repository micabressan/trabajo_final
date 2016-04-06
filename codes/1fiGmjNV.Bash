[0;32m===> Starting relx build process ...
[0m[0;36m===> state(command_line):
          log: (3:debug),
          config file: 
          goals: 
          output_dir: /home/mrjaros/code/orbit4/_rel
          lib_dirs: 
          providers: 
               tar,
               relup,
               release,
               resolve_release,
               overlay,
               rel_discover,
               app_discover,
          provider config values: 
               {overlay_vars,[]},
               {system_libs,undefined},
               {default_libs,true},
[0m
[0;36m===> Running provider app_discover
[0m[0;32m===> Resolving OTP Applications from directories:
          /home/mrjaros/utils/bin/erlang/r17b04/bin
          /home/mrjaros/code/orbit4/ebin
          /home/mrjaros/code/orbit4/deps
          /home/mrjaros/utils/bin/erlang/r17b04/lib
          /home/mrjaros/code/orbit4/_rel[0m
[0;36m===> Resolved the following OTP Applications from the system: 
          orbit4-1: /home/mrjaros/code/orbit4
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    lager,
                    hackney,
                    cowboy,
                    riakc,
                    jiffy,
                    ej,
                    qdate,
                    xmerl,
                    parsexml,
                    uuid,
                    gproc,
                    safetyvalve,
                    folsom,
                    folsomite,
                    lists2,
                    locks,
               Library Dependencies:

          uuid-1.4.0: /home/mrjaros/code/orbit4/deps/uuid
               Symlink: false
               Active Dependencies:
                    kernel,
                    quickrand,
                    stdlib,
               Library Dependencies:

          meck-0.8.2: /home/mrjaros/code/orbit4/deps/meck
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          ej-0.0.3: /home/mrjaros/code/orbit4/deps/ej
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          lists2-1.0: /home/mrjaros/code/orbit4/deps/lists2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          folsomite-1.0.0-svs.1: /home/mrjaros/code/orbit4/deps/folsomite
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    folsom,
                    zeta,
               Library Dependencies:

          idna-1.0.1: /home/mrjaros/code/orbit4/deps/idna
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          folsom-0.8.2-svs: /home/mrjaros/code/orbit4/deps/folsom
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    bear,
               Library Dependencies:

          ssl_verify_hostname-1.0.0: /home/mrjaros/code/orbit4/deps/ssl_verify_hostname
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    ssl,
               Library Dependencies:

          riakc-2.1.1-2-g6e813b7: /home/mrjaros/code/orbit4/deps/riak-erlang-client
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    riak_pb,
               Library Dependencies:

          locks-1: /home/mrjaros/code/orbit4/deps/locks
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          examples-1: /home/mrjaros/code/orbit4/deps/locks/examples
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    locks,
               Library Dependencies:

          safetyvalve-2.5.0: /home/mrjaros/code/orbit4/deps/safetyvalve
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    lager,
               Library Dependencies:

          bear-0.1.0: /home/mrjaros/code/orbit4/deps/bear
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          lager-2.1.0: /home/mrjaros/code/orbit4/deps/lager
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    goldrush,
               Library Dependencies:

          plain_fsm-1.1: /home/mrjaros/code/orbit4/deps/plain_fsm
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    syntax_tools,
               Library Dependencies:

          goldrush-0.1.6: /home/mrjaros/code/orbit4/deps/goldrush
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    syntax_tools,
                    compiler,
               Library Dependencies:

          gen_leader-1.0: /home/mrjaros/code/orbit4/deps/gen_leader
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          proper-1.1: /home/mrjaros/code/orbit4/deps/proper
               Symlink: false
               Active Dependencies:
                    compiler,
                    kernel,
                    stdlib,
               Library Dependencies:

          zeta-0.0.2-45-gb54d161: /home/mrjaros/code/orbit4/deps/zeta
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    protobuffs,
               Library Dependencies:

          erlang_localtime-1.0: /home/mrjaros/code/orbit4/deps/erlang_localtime
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          quickrand-1.5.0: /home/mrjaros/code/orbit4/deps/quickrand
               Symlink: false
               Active Dependencies:
                    crypto,
                    stdlib,
                    kernel,
               Library Dependencies:

          riak_pb-2.1.0.2: /home/mrjaros/code/orbit4/deps/riak_pb
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    protobuffs,
               Library Dependencies:

          protobuffs-0.8.1p5: /home/mrjaros/code/orbit4/deps/protobuffs
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          parsexml-1: /home/mrjaros/code/orbit4/deps/parsexml
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          sync-0.1.3: /home/mrjaros/code/orbit4/deps/sync
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          hamcrest-0.1.0: /home/mrjaros/code/orbit4/deps/hamcrest
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          erlware_commons-0.11.1: /home/mrjaros/code/orbit4/deps/erlware_commons
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          gproc-git: /home/mrjaros/code/orbit4/deps/gproc
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          jiffy-0.13.3: /home/mrjaros/code/orbit4/deps/jiffy
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          proper-1.1: /home/mrjaros/code/orbit4/deps/jiffy/deps/proper
               Symlink: false
               Active Dependencies:
                    compiler,
                    kernel,
                    stdlib,
               Library Dependencies:

          cowlib-1.0.0: /home/mrjaros/code/orbit4/deps/cowlib
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    crypto,
               Library Dependencies:

          hackney-1.0.5: /home/mrjaros/code/orbit4/deps/hackney
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    crypto,
                    asn1,
                    public_key,
                    ssl,
                    idna,
               Library Dependencies:
                    ssl_verify_hostname,

          ranch-1.0.0: /home/mrjaros/code/orbit4/deps/ranch
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          edown-git: /home/mrjaros/code/orbit4/deps/edown
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    edoc,
               Library Dependencies:

          cowboy-2.0.0-pre.1: /home/mrjaros/code/orbit4/deps/cowboy
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    ranch,
                    cowlib,
                    crypto,
               Library Dependencies:

          qdate-0.4.0-pre: /home/mrjaros/code/orbit4/deps/qdate
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    erlware_commons,
                    erlang_localtime,
               Library Dependencies:

          erl_docgen-0.3.7: /home/mrjaros/utils/bin/erlang/r17b04/lib/erl_docgen-0.3.7
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          diameter-1.8: /home/mrjaros/utils/bin/erlang/r17b04/lib/diameter-1.8
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          syntax_tools-1.6.17: /home/mrjaros/utils/bin/erlang/r17b04/lib/syntax_tools-1.6.17
               Symlink: false
               Active Dependencies:
                    stdlib,
               Library Dependencies:

          ssh-3.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/ssh-3.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    crypto,
                    public_key,
               Library Dependencies:

          orber-3.7.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/orber-3.7.1
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
                    mnesia,
               Library Dependencies:

          typer-0.9.8: /home/mrjaros/utils/bin/erlang/r17b04/lib/typer-0.9.8
               Symlink: false
               Active Dependencies:
                    compiler,
                    dialyzer,
                    hipe,
                    kernel,
                    stdlib,
               Library Dependencies:

          percept-0.8.10: /home/mrjaros/utils/bin/erlang/r17b04/lib/percept-0.8.10
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          stdlib-2.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/stdlib-2.3
               Symlink: false
               Active Dependencies:
                    kernel,
               Library Dependencies:

          inets-5.10.4: /home/mrjaros/utils/bin/erlang/r17b04/lib/inets-5.10.4
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          wx-1.3.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/wx-1.3.2
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          ose-1.0.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/ose-1.0.2
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          erl_interface-3.7.20: /home/mrjaros/utils/bin/erlang/r17b04/lib/erl_interface-3.7.20
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          cosTime-1.1.14: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosTime-1.1.14
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          crypto-3.4.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/crypto-3.4.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          reltool-0.6.6: /home/mrjaros/utils/bin/erlang/r17b04/lib/reltool-0.6.6
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          webtool-0.8.10: /home/mrjaros/utils/bin/erlang/r17b04/lib/webtool-0.8.10
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          cosEvent-2.1.15: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosEvent-2.1.15
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          cosNotification-1.1.21: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosNotification-1.1.21
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          ic-4.3.6: /home/mrjaros/utils/bin/erlang/r17b04/lib/ic-4.3.6
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          runtime_tools-1.8.15: /home/mrjaros/utils/bin/erlang/r17b04/lib/runtime_tools-1.8.15
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          erts-6.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/erts-6.3
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          otp_mibs-1.0.10: /home/mrjaros/utils/bin/erlang/r17b04/lib/otp_mibs-1.0.10
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    snmp,
               Library Dependencies:

          dialyzer-2.7.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/dialyzer-2.7.3
               Symlink: false
               Active Dependencies:
                    compiler,
                    gs,
                    hipe,
                    kernel,
                    stdlib,
                    wx,
               Library Dependencies:

          observer-2.0.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/observer-2.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          kernel-3.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/kernel-3.1
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          xmerl-1.3.7: /home/mrjaros/utils/bin/erlang/r17b04/lib/xmerl-1.3.7
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          hipe-3.11.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/hipe-3.11.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          cosProperty-1.1.17: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosProperty-1.1.17
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          compiler-5.0.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/compiler-5.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          public_key-0.22.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/public_key-0.22.1
               Symlink: false
               Active Dependencies:
                    asn1,
                    crypto,
                    kernel,
                    stdlib,
               Library Dependencies:

          cosFileTransfer-1.1.16: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosFileTransfer-1.1.16
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          cosEventDomain-1.1.14: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosEventDomain-1.1.14
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          test_server-3.7.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/test_server-3.7.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          os_mon-2.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/os_mon-2.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    sasl,
               Library Dependencies:

          sasl-2.4.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/sasl-2.4.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          tools-2.7.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/tools-2.7.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          cosTransactions-1.2.14: /home/mrjaros/utils/bin/erlang/r17b04/lib/cosTransactions-1.2.14
               Symlink: false
               Active Dependencies:
                    orber,
                    stdlib,
                    kernel,
               Library Dependencies:

          debugger-4.0.2: /home/mrjaros/utils/bin/erlang/r17b04/lib/debugger-4.0.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          megaco-3.17.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/megaco-3.17.3
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          gs-1.5.16: /home/mrjaros/utils/bin/erlang/r17b04/lib/gs-1.5.16
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          eunit-2.2.9: /home/mrjaros/utils/bin/erlang/r17b04/lib/eunit-2.2.9
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          parsetools-2.0.12: /home/mrjaros/utils/bin/erlang/r17b04/lib/parsetools-2.0.12
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          mnesia-4.12.4: /home/mrjaros/utils/bin/erlang/r17b04/lib/mnesia-4.12.4
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          eldap-1.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/eldap-1.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          asn1-3.0.3: /home/mrjaros/utils/bin/erlang/r17b04/lib/asn1-3.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          odbc-2.10.22: /home/mrjaros/utils/bin/erlang/r17b04/lib/odbc-2.10.22
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          snmp-5.1.1: /home/mrjaros/utils/bin/erlang/r17b04/lib/snmp-5.1.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          et-1.5: /home/mrjaros/utils/bin/erlang/r17b04/lib/et-1.5
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          edoc-0.7.16: /home/mrjaros/utils/bin/erlang/r17b04/lib/edoc-0.7.16
               Symlink: false
               Active Dependencies:
                    compiler,
                    kernel,
                    stdlib,
                    syntax_tools,
               Library Dependencies:

          common_test-1.9: /home/mrjaros/utils/bin/erlang/r17b04/lib/common_test-1.9
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          ssl-5.3.8: /home/mrjaros/utils/bin/erlang/r17b04/lib/ssl-5.3.8
               Symlink: false
               Active Dependencies:
                    crypto,
                    public_key,
                    kernel,
                    stdlib,
               Library Dependencies:

          ej-0.0.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/ej-0.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          syntax_tools-1.6.17: /home/mrjaros/code/orbit4/_rel/orbit4/lib/syntax_tools-1.6.17
               Symlink: false
               Active Dependencies:
                    stdlib,
               Library Dependencies:

          qdate-0.4.0-pre: /home/mrjaros/code/orbit4/_rel/orbit4/lib/qdate-0.4.0-pre
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    erlware_commons,
                    erlang_localtime,
               Library Dependencies:

          quickrand-1.5.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/quickrand-1.5.0
               Symlink: false
               Active Dependencies:
                    crypto,
                    stdlib,
                    kernel,
               Library Dependencies:

          uuid-1.4.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/uuid-1.4.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    quickrand,
                    stdlib,
               Library Dependencies:

          ssl_verify_hostname-1.0.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/ssl_verify_hostname-1.0.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    ssl,
               Library Dependencies:

          stdlib-2.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/stdlib-2.3
               Symlink: false
               Active Dependencies:
                    kernel,
               Library Dependencies:

          idna-1.0.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/idna-1.0.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          zeta-0.0.2-45-gb54d161: /home/mrjaros/code/orbit4/_rel/orbit4/lib/zeta-0.0.2-45-gb54d161
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    protobuffs,
               Library Dependencies:

          erlware_commons-0.11.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/erlware_commons-0.11.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          wx-1.3.2: /home/mrjaros/code/orbit4/_rel/orbit4/lib/wx-1.3.2
               Symlink: false
               Active Dependencies:
                    stdlib,
                    kernel,
               Library Dependencies:

          lager-2.1.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/lager-2.1.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    goldrush,
               Library Dependencies:

          parsexml-1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/parsexml-1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          crypto-3.4.2: /home/mrjaros/code/orbit4/_rel/orbit4/lib/crypto-3.4.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          protobuffs-0.8.1p5: /home/mrjaros/code/orbit4/_rel/orbit4/lib/protobuffs-0.8.1p5
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          runtime_tools-1.8.15: /home/mrjaros/code/orbit4/_rel/orbit4/lib/runtime_tools-1.8.15
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          safetyvalve-2.5.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/safetyvalve-2.5.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    lager,
               Library Dependencies:

          bear-0.1.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/bear-0.1.0
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          observer-2.0.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/observer-2.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          kernel-3.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/kernel-3.1
               Symlink: false
               Active Dependencies:
               Library Dependencies:

          xmerl-1.3.7: /home/mrjaros/code/orbit4/_rel/orbit4/lib/xmerl-1.3.7
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          compiler-5.0.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/compiler-5.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          public_key-0.22.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/public_key-0.22.1
               Symlink: false
               Active Dependencies:
                    asn1,
                    crypto,
                    kernel,
                    stdlib,
               Library Dependencies:

          gproc-git: /home/mrjaros/code/orbit4/_rel/orbit4/lib/gproc-git
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          sasl-2.4.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/sasl-2.4.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          erlang_localtime-1.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/erlang_localtime-1.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          goldrush-0.1.6: /home/mrjaros/code/orbit4/_rel/orbit4/lib/goldrush-0.1.6
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    syntax_tools,
                    compiler,
               Library Dependencies:

          riakc-2.1.1-2-g6e813b7: /home/mrjaros/code/orbit4/_rel/orbit4/lib/riakc-2.1.1-2-g6e813b7
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    riak_pb,
               Library Dependencies:

          cowboy-2.0.0-pre.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/cowboy-2.0.0-pre.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    ranch,
                    cowlib,
                    crypto,
               Library Dependencies:

          orbit4-1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/orbit4-1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    lager,
                    hackney,
                    cowboy,
                    riakc,
                    jiffy,
                    ej,
                    qdate,
                    xmerl,
                    parsexml,
                    uuid,
                    gproc,
                    safetyvalve,
                    folsom,
                    folsomite,
                    lists2,
                    locks,
               Library Dependencies:

          jiffy-0.13.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/jiffy-0.13.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          debugger-4.0.2: /home/mrjaros/code/orbit4/_rel/orbit4/lib/debugger-4.0.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          folsom-0.8.2-svs: /home/mrjaros/code/orbit4/_rel/orbit4/lib/folsom-0.8.2-svs
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    bear,
               Library Dependencies:

          eunit-2.2.9: /home/mrjaros/code/orbit4/_rel/orbit4/lib/eunit-2.2.9
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          ranch-1.0.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/ranch-1.0.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          hackney-1.0.5: /home/mrjaros/code/orbit4/_rel/orbit4/lib/hackney-1.0.5
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    crypto,
                    asn1,
                    public_key,
                    ssl,
                    idna,
               Library Dependencies:
                    ssl_verify_hostname,

          locks-1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/locks-1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          riak_pb-2.1.0.2: /home/mrjaros/code/orbit4/_rel/orbit4/lib/riak_pb-2.1.0.2
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    protobuffs,
               Library Dependencies:

          folsomite-1.0.0-svs.1: /home/mrjaros/code/orbit4/_rel/orbit4/lib/folsomite-1.0.0-svs.1
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    folsom,
                    zeta,
               Library Dependencies:

          asn1-3.0.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/asn1-3.0.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          cowlib-1.0.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/cowlib-1.0.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
                    crypto,
               Library Dependencies:

          lists2-1.0: /home/mrjaros/code/orbit4/_rel/orbit4/lib/lists2-1.0
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          sync-0.1.3: /home/mrjaros/code/orbit4/_rel/orbit4/lib/sync-0.1.3
               Symlink: false
               Active Dependencies:
                    kernel,
                    stdlib,
               Library Dependencies:

          ssl-5.3.8: /home/mrjaros/code/orbit4/_rel/orbit4/lib/ssl-5.3.8
               Symlink: false
               Active Dependencies:
                    crypto,
                    public_key,
                    kernel,
                    stdlib,
               Library Dependencies:

[0m
[0;36m===> Provider successfully run: app_discover
[0m[0;36m===> Running provider resolve_release
[0m[0;36m===> Solving Release orbit4-0.1
[0m[0;32m===> Resolved orbit4-0.1
[0m[0;36m===> release: orbit4-0.1
           erts-6.3, realized = true
     goals: 
          sync,
          compiler,
          syntax_tools,
          eunit,
          observer,
          wx,
          runtime_tools,
          debugger,
          sasl,
          orbit4,
     applications: 
          {bear,"0.1.0"},
          {kernel,"3.1"},
          {stdlib,"2.3"},
          {erlware_commons,"0.11.1"},
          {erlang_localtime,"1.0"},
          {protobuffs,"0.8.1p5"},
          {ranch,"1.0.0"},
          {crypto,"3.4.2"},
          {asn1,"3.0.3"},
          {idna,"1.0.1"},
          {syntax_tools,"1.6.17"},
          {compiler,"5.0.3"},
          {jiffy,"0.13.3"},
          {ej,"0.0.3"},
          {xmerl,"1.3.7"},
          {parsexml,"1"},
          {gproc,"git"},
          {folsom,"0.8.2-svs"},
          {lists2,"1.0"},
          {locks,"1"},
          {zeta,"0.0.2-45-gb54d161"},
          {goldrush,"0.1.6"},
          {quickrand,"1.5.0"},
          {riak_pb,"2.1.0.2"},
          {cowlib,"1.0.0"},
          {public_key,"0.22.1"},
          {qdate,"0.4.0-pre"},
          {ssl,"5.3.8"},
          {lager,"2.1.0"},
          {cowboy,"2.0.0-pre.1"},
          {riakc,"2.1.1-2-g6e813b7"},
          {uuid,"1.4.0"},
          {folsomite,"1.0.0-svs.1"},
          {ssl_verify_hostname,"1.0.0",load},
          {safetyvalve,"2.5.0"},
          {hackney,"1.0.5"},
          {orbit4,"1"},
          {sasl,"2.4.1"},
          {debugger,"4.0.2"},
          {runtime_tools,"1.8.15"},
          {wx,"1.3.2"},
          {observer,"2.0.3"},
          {eunit,"2.2.9"},
          {sync,"0.1.3"},
[0m
[0;36m===> Provider successfully run: resolve_release
[0m[0;36m===> Running provider overlay
[0m[0;36m===> Provider successfully run: overlay
[0m[0;36m===> Running provider release
[0m[0;32m===> Including Erts from /home/mrjaros/utils/bin/erlang/r17b04
[0m[0;32m===> release successfully created!
[0m[0;36m===> Provider successfully run: release
[0m