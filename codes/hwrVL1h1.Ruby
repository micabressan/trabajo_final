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

            action "filter" do
                validate :max_runtime, String
                result = []
                files = Dir["/var/status/*.status"]
                files.each { |f|
                    p = JavaProps.new(f)
                    if File.exists?("/proc/"+p.properties["pid"]+"/exe")
                        actual = File.readlink("/proc/"+p.properties["pid"]+"/exe")
                        if actual == p.properties["binary"]
                            now = Time.now.to_i
                            started = p.properties["time"].to_i
                            if now - started > :max_runtime
                                result.push(p.properties)
                            end
                        end
                    end
                }
                reply[:matches] = result
                reply[:hostname] = Socket.gethostbyname(Socket.gethostname).first
                reply[:time] = Time.now.to_s
            end
        end
    end


end