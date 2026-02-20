#!/bin/bash

###
# Инициализируем бд
###

docker compose exec -T mongos_router mongosh --port 27024 --quiet <<'EOF'
db = db.getSiblingDB("somedb");
for(var i = 0; i < 1000; i++) {
    db.helloDoc.insertOne({age:i, name:"ly"+i});
}
print("DONE");
EOF