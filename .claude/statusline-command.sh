#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

parts=""

[ -n "$model" ] && parts="[$model]"

[ -n "$ctx" ] && parts="$parts ctx:$(printf '%.0f' "$ctx")%"

[ -n "$five" ] && parts="$parts 5h:$(printf '%.0f' "$five")%"
[ -n "$week" ] && parts="$parts 7d:$(printf '%.0f' "$week")%"

echo "$parts"
