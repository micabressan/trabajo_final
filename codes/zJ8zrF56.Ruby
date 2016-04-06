#!/usr/bin/env ruby
require 'rubydns'
require 'rubydns/system'

INTERFACES = [
    [:udp, "0.0.0.0", 53],
        [:tcp, "0.0.0.0", 53]
        ]
        Name = Resolv::DNS::Name
        IN = Resolv::DNS::Resource::IN


        UPSTREAM = RubyDNS::Resolver.new([[:udp, "8.8.8.8", 53], [:tcp, "8.8.8.8", 53]])


        RubyDNS::run_server(:listen => INTERFACES) do
            fallback_resolver_supervisor =
              RubyDNS::Resolver.supervise(RubyDNS::System.nameservers)
            match(//, IN::A) do |transaction|
                answer = '192.168.1.22'

                transaction.respond!(answer)
            end

            #passthrough
            otherwise do |transaction|
                logger.debug 'In otherwise'
                transaction.passthrough!(fallback_resolver_supervisor.actors.first)
            end
            end