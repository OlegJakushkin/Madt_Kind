# MADT_Exonum

1. Скачайте и запустите MADT:

```
cd ~
git clone --recursive https://github.com/dltcspbu/madt/
mkdir ~/madt/labs && export MADT_LABS_DIR=$HOME/madt/labs
mkdir ~/madt/sockets && export MADT_LABS_SOCKETS_DIR=$HOME/madt/sockets

cd madt
sudo pip3 install -r ./requirements.txt
sudo make && sudo make install

sudo -HE env PYTHONPATH=$HOME/madt:$PYTHONPATH SSH_PWD=demo python3 madt_ui/main.py 80
```

2. Перейдите в директорию `./tutorials`, склонируйте данный проект, соберите образ и запустите lab.py:

```
#open new terminal window
cd ~/madt/tutorials
git clone https://github.com/IvPod/Madt_Kind.git
docker build -t madt/kind .
python3 ./lab.py
```

3. Перейдите на 127.0.0.1:80, для login используйте: `demo:demo`
4. WIP


## Тестирование вне Madt

1. Создадим сеть:

```
docker network create --subnet=15.0.0.0/29 PRIVATENET
```

2. Создадим 2 контейнера:

```
docker run -it --net=PRIVATENET --privileged -p 8008:8008 -p 9080:9080 --name MADT_kind_Node0 -d madt/kind
docker run -it --net=PRIVATENET --privileged -p 8009:8009 --name MADT_kind_Node1 -d madt/kind
```

3. Для каждого контейнера, пульнуть образ kindest/node:v1.18.2 из DockerHub'a используя скрипт

```
docker exec MADT_kind_Node0 scripts/pull_image.sh
docker exec MADT_kind_Node1 scripts/pull_image.sh
```

4. Создать кластер в каждом контейнере: 

```
kind create cluster --image kindest/node:v1.18.2 --config=/configs/config_cluster1.yaml --name kind-1
kind create cluster --image kindest/node:v1.18.2 --config=/configs/config_cluster2.yaml --name kind-2
```

5. Дождитесь окончания сборки кластера. После успешного окнчания, скопируйте конфиг файлы каждого контейнера используя следующий скрипт:

```
bash copy_config
```

6. Перейдите в директорию `./scripts` и установите в каждый из кластеров свои сервисы используя следующие скрипты:

```
cd scripts
bash cluster1.sh
bash cluster2.sh
```

7. Настройте ingress gateway для приложения и проверьте работоспособность с помощью следующего скрипта:

```
bash finalize.sh
```
