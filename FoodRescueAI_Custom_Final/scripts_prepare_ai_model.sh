#!/usr/bin/env bash
set -euo pipefail
MODEL_ZIP_URL="https://raw.githubusercontent.com/Kayuemkhan/Freshness-Detector/master/Freshness-Detector.zip"
mkdir -p assets/models /tmp/freshness_detector
curl -L --fail --retry 3 "$MODEL_ZIP_URL" -o /tmp/freshness_detector/model.zip
unzip -o /tmp/freshness_detector/model.zip -d /tmp/freshness_detector/unpacked >/dev/null
MODEL_PATH="$(find /tmp/freshness_detector/unpacked -type f -iname '*.tflite' | head -n 1 || true)"
if [ -z "$MODEL_PATH" ]; then
  echo "No .tflite model was found in the GitHub model archive."
  exit 1
fi
cp "$MODEL_PATH" assets/models/freshness_model.tflite
cp assets/freshness_labels.txt assets/models/freshness_labels.txt
ls -lh assets/models/freshness_model.tflite
