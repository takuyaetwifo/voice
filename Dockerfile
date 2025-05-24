FROM ubuntu:22.04

WORKDIR /app

# 必要パッケージのインストール
RUN apt-get update && apt-get install -y \
    curl unzip p7zip-full python3 python3-pip libsndfile1 \
    && apt-get clean

# VOICEVOXエンジン (CPU Linux x64 v0.23.0) の分割ファイルをダウンロードして結合＆展開
RUN curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.001 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.002 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.003 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.004 && \
    ls -lh voicevox_engine-linux-cpu-x64-0.23.0.7z.* && \
    7z x voicevox_engine-linux-cpu-x64-0.23.0.7z.001 -o/opt/voicevox_engine

RUN 7z x voicevox_engine-linux-cpu-x64-0.23.0.7z.001 -o/opt/voicevox_engine && \
    ls -lR /opt/voicevox_engine

# 必要なら pip で Flask などもインストールできる
# RUN pip install flask

EXPOSE 50021

# 起動スクリプト
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
