FROM ubuntu:22.04

WORKDIR /app

# 必要パッケージのインストール
RUN apt-get update && apt-get install -y \
    curl unzip p7zip-full python3 python3-pip libsndfile1 \
    && apt-get clean

# VOICEVOXエンジンの分割ファイルをダウンロード
RUN curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.001 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.002 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.003 && \
    curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.23.0/voicevox_engine-linux-cpu-x64-0.23.0.7z.004

# ファイルサイズを確認（デバッグ時のみ）
RUN ls -lh voicevox_engine-linux-cpu-x64-0.23.0.7z.*

# 7z展開（上書きオプション付き＆パス競合対策）
RUN 7z x -aoa voicevox_engine-linux-cpu-x64-0.23.0.7z.001 -o/opt/voicevox_engine

# 展開結果を必ず確認（デバッグ時のみ）
RUN ls -lR /opt/voicevox_engine

# 必要なら pip で Flask などもインストール
# RUN pip install flask

EXPOSE 50021

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
