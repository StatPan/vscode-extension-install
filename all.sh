#!/bin/bash

# 루트 디렉토리 기준 scripts 디렉토리 경로
scripts_dir="./scripts"

# 확장 프로그램 ID를 저장할 배열
all_extensions=()

# 스크립트 디렉토리가 존재하는지 확인
if [[ ! -d "$scripts_dir" ]]; then
  echo "Error: Scripts directory not found at '$scripts_dir'"
  exit 1
fi

# 스크립트 디렉토리의 모든 .sh 파일을 순회
find "$scripts_dir" -maxdepth 1 -name "*.sh" -type f -print0 | while IFS= read -r -d $'\0' script_file; do
  # 현재 파일이 all.sh 면 skip
  if [[ "$script_file" == *"/all.sh" ]]; then
    continue
  fi

  echo "Processing script: $script_file"

  # 스크립트 파일을 source 하여 변수를 로드합니다.
  source "$script_file"
  
  # source로 실행 했기때문에, extension 배열이 생성되어 있습니다.
  # extension 배열이 비어있는지 확인하고, 비어있지 않으면 all_extensions에 추가합니다.
  if [[ -n "${extensions[*]}" ]]; then
      all_extensions+=("${extensions[@]}")
  fi

  # 다음 스크립트 실행을 위해 배열 초기화
  unset extensions
done

# 중복된 확장 프로그램 제거
declare -A unique_extensions
for ext in "${all_extensions[@]}"; do
  unique_extensions["$ext"]=1
done
all_extensions=("${!unique_extensions[@]}")

# 모든 확장 프로그램 설치
for ext in "${all_extensions[@]}"; do
  echo "Installing extension: $ext"
  code --install-extension "$ext" || { echo "Failed to install extension: $ext"; exit 1; } # 에러 발생시 스크립트 종료
done

echo "All extensions installation completed."
