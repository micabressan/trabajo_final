:~/Ethereum/git/go-ethereum$ git pull
remote: Counting objects: 874, done.
remote: Compressing objects: 100% (43/43), done.
remote: Total 874 (delta 380), reused 361 (delta 361), pack-reused 470
Receiving objects: 100% (874/874), 597.54 KiB | 348 KiB/s, done.
Resolving deltas: 100% (613/613), completed with 168 local objects.
From https://github.com/ethereum/go-ethereum
 + fc79d32...a0303ff master     -> origin/master  (forced update)
   ab85a35..d51d002  develop    -> origin/develop
 * [new branch]      gh-pages   -> origin/gh-pages
 + dfec445...decbfd2 gpu_miner  -> origin/gpu_miner  (forced update)
   0cdc764..0397c66  release/1.0.0 -> origin/release/1.0.0
 * [new branch]      release/1.0.1 -> origin/release/1.0.1
 * [new branch]      release/1.1.0 -> origin/release/1.1.0
 * [new tag]         v1.0.2     -> v1.0.2
From https://github.com/ethereum/go-ethereum
 * [new tag]         v1.0.1     -> v1.0.1
 * [new tag]         v1.0.1.1   -> v1.0.1.1
Auto-merging xeth/xeth.go
Auto-merging tests/files/BlockchainTests/bcValidBlockTest.json
CONFLICT (content): Merge conflict in tests/files/BlockchainTests/bcValidBlockTest.json
Auto-merging tests/block_test_util.go
Auto-merging rpc/comms/ipc_unix.go
CONFLICT (modify/delete): rpc/comms/http_net.go deleted in a0303ff4bdc17fba10baea4ce9ff250e5923efa2 and modified in HEAD. Version HEAD of rpc/comms/http_net.go left in tree.
Auto-merging rpc/comms/http.go
Auto-merging rpc/api/utils.go
Auto-merging rpc/api/eth_args.go
Auto-merging rpc/api/eth.go
Auto-merging rpc/api/args_test.go
Auto-merging params/protocol_params.go
CONFLICT (content): Merge conflict in params/protocol_params.go
Auto-merging p2p/server.go
Auto-merging p2p/metrics.go
Auto-merging p2p/discover/udp.go
Auto-merging p2p/dial.go
Auto-merging miner/worker.go
Auto-merging miner/remote_agent.go
Auto-merging miner/agent.go
Auto-merging metrics/disk_linux.go
Auto-merging ethdb/database_test.go
Auto-merging ethdb/database.go
Auto-merging eth/fetcher/fetcher_test.go
Auto-merging eth/backend.go
CONFLICT (content): Merge conflict in eth/backend.go
Auto-merging crypto/secp256k1/secp256.go
Auto-merging crypto/key_store_passphrase.go
Auto-merging crypto/curve.go
Auto-merging core/types/transaction.go
Auto-merging core/types/block.go
Auto-merging core/transaction_util.go
Auto-merging core/transaction_pool_test.go
Auto-merging core/transaction_pool.go
Auto-merging core/state/statedb.go
Auto-merging core/state/state_object.go
Auto-merging core/chain_util.go
CONFLICT (content): Merge conflict in core/chain_util.go
Auto-merging core/chain_manager_test.go
Auto-merging core/chain_manager.go
CONFLICT (content): Merge conflict in core/chain_manager.go
Auto-merging core/chain_makers.go
Auto-merging core/canary.go
Auto-merging core/blocks.go
Auto-merging core/block_processor.go
Auto-merging core/bench_test.go
Auto-merging cmd/utils/flags.go
CONFLICT (content): Merge conflict in cmd/utils/flags.go
Auto-merging cmd/utils/cmd.go
Auto-merging cmd/geth/main.go
CONFLICT (content): Merge conflict in cmd/geth/main.go
Auto-merging cmd/geth/js.go
Auto-merging cmd/evm/main.go
Auto-merging cmd/ethtest/main.go
CONFLICT (content): Merge conflict in cmd/ethtest/main.go
Auto-merging accounts/accounts_test.go
Auto-merging accounts/account_manager.go
Automatic merge failed; fix conflicts and then commit the result.