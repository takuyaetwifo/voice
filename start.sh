#!/bin/bash

# CORS全許可＆任意のオリジンを許可
/opt/voicevox_engine/run \
  --host 0.0.0.0 \
  --cors_policy_mode all \
  --allow_origin '*'  # 必要なら「https://yourfrontend.com」などに限定
