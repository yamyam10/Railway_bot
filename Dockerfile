# ベースイメージとしてUbuntuを使用
FROM ubuntu:20.04

# 必要な依存関係をインストール
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    python3 \
    python3-pip \
    ffmpeg \
    libsndfile1

# VOICEVOXエンジンをダウンロードしてインストール
RUN wget https://github.com/VOICEVOX/voicevox_engine/releases/download/v0.10.1/voicevox_engine-0.10.1-linux-x86_64.tar.bz2
RUN tar -xvjf voicevox_engine-0.10.1-linux-x86_64.tar.bz2

# VOICEVOXエンジンの依存関係をインストール
RUN cd voicevox_engine && pip3 install -r requirements.txt

# サーバーを起動
CMD ["python3", "voicevox_engine/app.py"]
