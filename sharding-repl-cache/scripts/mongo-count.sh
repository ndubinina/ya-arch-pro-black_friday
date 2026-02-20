#!/bin/bash

###
# Вывод числа записей
###

docker compose exec -T shard1_replica1 mongosh --port 27018 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard1_replica2 mongosh --port 27019 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard1_replica3 mongosh --port 27020 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard2_replica1 mongosh --port 27021 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard2_replica2 mongosh --port 27022 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard2_replica3 mongosh --port 27023 --quiet <<'EOF'
use somedb
db.helloDoc.countDocuments()
EOF