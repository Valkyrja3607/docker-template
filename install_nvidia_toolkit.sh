#!/bin/bash

# NVIDIA GPGキーの追加
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -

# リポジトリの追加
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# パッケージリストの更新とNVIDIA Docker Toolkitのインストール
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# Dockerデーモンの再起動
sudo systemctl restart docker
