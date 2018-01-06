require "socket"
MCollective::Util.loadclass("MCollective::Util::JavaProps")

module MCollective
    module Agent

        class Status<RPC::Agent
            metadata    :name        => "Status agent",
                        :description => "Queries process status based on /var/status/*.status",
                        :author      => "Omry Yadan <omry@yadan.net>",
                        :license     => "BSD",
                        :version     => "1.0",
                        :url         => "?",
                        :timeout     => 2

            action "query" do
                result = []
                files = Dir["/var/status/*.status"]
                files.each { |f|
                    p = JavaProps.new(f)
                    proc_file = "/proc/"+p.properties["pid"]+"/exe"
                    if File.exists?(proc_file)
                        actual = File.readlink(proc_file)
                        if actual == p.properties["binary"]
                            result.push(p.properties)
                        end
                    end
                }

                if request[:elapsed] != nil
                    m = /(<|>)([1-9][0-9]*)/.match(request[:elapsed])
                    t = m[2].to_i
                    now = Time.now.to_i
                    result.delete_if{|p|
                        started = p["time"].to_i
                        elapsed = now - started
                        if m[1] == ">"
                            elapsed < t
                        elsif m[1] == "<"
                            elapsed > t
                        end
                    }
                end

                if request[:binary] != nil
                    logger.info("--aaaa")
                    result.delete_if{|p|
                        p["binary"] != request[:binary]
                    }
                end

                reply[:matches] = result
                reply[:hostname] = Socket.gethostbyname(Socket.gethostname).first
                reply[:time] = Time.now.to_s
            end
                                                                                                                                                                                                                           5,16          Top
                    }
                end

                reply[:matches] = result
                reply[:hostname] = Socket.gethostbyname(Socket.gethostname).first
                reply[:time] = Time.now.to_s
            end
        end
    end
end