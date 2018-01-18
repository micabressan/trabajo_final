#!/usr/bin/ruby

# # 下記のような手順で環境を準備する
# 
# apt-get install -y ruby2.3-dev libnfnetlink-dev libnetfilter-queue-dev iptables
# gem install nfqueue
# 
# # フィルターにNFQUEUEを追加する。キュー番号を0とする。
# iptables -A OUTPUT -p tcp -m state --state NEW -j NFQUEUE --queue-num 0 --queue-bypass
# 
# # iptablesの設定を永続化する場合は下記をインストールする
# apt-get install iptables-persistent


require 'nfqueue'

# 0番のキューにパケットが到着した時
Netfilter::Queue.create(0) do |packet|

  # パケットの内容を取得
  data = packet.data.bytes

  # 内容を解析してポート番号を取り出す
  tcpport = data[20]*256 + data[21]

  # もしポート番号が80なら
  if tcpport == 80

    # パケットを転送
    Netfilter::Packet::ACCEPT

  # でなければ
  else

    # パケットを捨てる
    Netfilter::Packet::DROP

  end
end