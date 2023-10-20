#!/bin/bash

read -p 'Input your username: ' username

folderPath="/home/$username/files"
folderPath2="/home/$username/extra_files"
filesUrl="https://drive.google.com/uc?export=download&id=1ArfGDRdicy68nirqN0Yf4PzwEPJSkVOO"

mkdir -p "$folderPath"

filesZip="$folderPath/files2.zip"
wget -O "$filesZip" "$filesUrl"
unzip -q "$filesZip" -d "$folderPath"

mapfile -t baseline_exe < "$folderPath/files/exe_files.txt"
mapfile -t baseline_audio < "$folderPath/files/audio_files.txt"
mapfile -t baseline_video < "$folderPath/files/video_files.txt"
mapfile -t baseline_script < "$folderPath/files/script_files.txt"
mapfile -t baseline_txt < "$folderPath/files/txt_files.txt"

extra_exe=$(find / \( -type f -name "*.exe" -o -name "*.pdf" -o -name "*.doc" -o -name "*.docx" \) -not -path "/usr/src/*" | grep -Fxvf <(echo "${baseline_exe[@]}") | grep -vE "/(files|home/$username/extra_files)/")
extra_audio=$(find / \( -type f -name "*.mp3" -o -name "*.ogg" -o -name "*.mkv" -o -name "*.wav" -o -name "*.flac" \) -not -path "/usr/src/*" | grep -Fxvf <(echo "${baseline_audio[@]}") | grep -vE "/(files|home/$username/extra_files)/")
extra_video=$(find / \( -type f -name "*.mov" -o -name "*.mp4" -o -name "*.wmv" -o -name "*.webm" \) -not -path "/usr/src/*" | grep -Fxvf <(echo "${baseline_video[@]}") | grep -vE "/(files|home/$username/extra_files)/")
extra_script=$(find / -type f -name "*.sh" -not -path "/usr/src/*" | grep -Fxvf <(echo "${baseline_script[@]}") | grep -vE "/(files|home/$username/extra_files)/")
extra_txt=$(find / \( -type f -name "*.txt" -o -name "*.pdf" -o -name "*.doc" -o -name "*.docx" \) -not -path "/usr/src/*" | grep -Fxvf <(echo "${baseline_txt[@]}") | grep -vE "/(files|home/$username/extra_files)/")

mkdir -p "$folderPath2"

echo "${extra_exe[@]}" > "$folderPath2/exe_files.txt"
echo "${extra_audio[@]}" > "$folderPath2/audio_files.txt"
echo "${extra_video[@]}" > "$folderPath2/video_files.txt"
echo "${extra_script[@]}" > "$folderPath2/script_files.txt"
echo "${extra_txt[@]}" > "$folderPath2/txt_files.txt"