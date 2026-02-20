#!/bin/bash

###
# Инициализируем кластер mongo
###

docker compose exec -T config_server_replica1 mongosh --port 27015 --quiet <<'EOF'
rs.initiate({
    _id : "config_server_rs",
    configsvr: true,
    members: [
    { _id: 0, host: "config_server_replica1:27015" },
    { _id: 1, host: "config_server_replica2:27016" },
    { _id: 2, host: "config_server_replica3:27017" }
  ]
})
EOF

docker compose exec -T shard1_replica1 mongosh --port 27018 --quiet <<'EOF'
rs.initiate({
  _id: "shard1_rs",
  members: [
    { _id: 0, host: "shard1_replica1:27018" },
    { _id: 1, host: "shard1_replica2:27019" },
    { _id: 2, host: "shard1_replica3:27020" }
  ]
})
EOF

docker compose exec -T shard2_replica1 mongosh --port 27021 --quiet <<'EOF'
rs.initiate({
  _id: "shard2_rs",
  members: [
    { _id: 0, host: "shard2_replica1:27021" },
    { _id: 1, host: "shard2_replica2:27022" },
    { _id: 2, host: "shard2_replica3:27023" }
  ]
})
EOF

echo "Waiting 15 sec.."
sleep 15

docker compose exec -T mongos_router mongosh --port 27024 --quiet <<'EOF'
sh.addShard("shard1_rs/shard1_replica1:27018,shard1_replica2:27019,shard1_replica3:27020")
sh.addShard("shard2_rs/shard2_replica1:27021,shard2_replica2:27022,shard2_replica3:27023")

sh.status()
sh.enableSharding("somedb")
sh.shardCollection("somedb.helloDoc", { "name": "hashed" })
EOF