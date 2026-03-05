## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем кластер mongo

```shell
./scripts/mongo-set-init.sh
```

Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```


## Как узнать число записей на шардах:

```shell
./scripts/mongo-count.sh
```