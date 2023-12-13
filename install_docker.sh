#!/bin/bash

# Dockerの古いバージョンがあれば削除
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# 必要なパッケージのインストール
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Dockerの公式GPGキーの追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Dockerリポジトリの設定
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker Engineのインストール
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Dockerサービスの開始と有効化
sudo systemctl start docker
sudo systemctl enable docker

# Docker動作の確認
sudo docker run hello-world

# ユーザーをdockerグループに追加
sudo usermod -aG docker ${USER}
