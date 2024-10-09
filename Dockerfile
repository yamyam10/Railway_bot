FROM python:3.11

# 作業ディレクトリを設定
WORKDIR /bot

# 必要なファイルをコピー
COPY requirements.txt /bot/
RUN pip install -r requirements.txt

# VOICEVOXエンジンをインストール
RUN apt-get update && apt-get install -y \
    curl \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# supervisordをインストールして複数プロセスを管理
RUN apt-get update && apt-get install -y supervisor

# Supervisordの設定を追加
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 全ファイルをコンテナにコピー
COPY . /bot

# SupervisordでPythonボットとVOICEVOXエンジンを同時に起動
CMD ["/usr/bin/supervisord"]
