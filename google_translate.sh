#!/bin/bash

if [ -z "$1" ]; then
  echo "Exiting"
fi

text="$1"
l_source="auto"

if [[ "$text" =~ ^[а-яА-ЯёЁ].* ]]; then
  l_target="en"
else
  l_target="ru"
fi

result=$(curl --connect-timeout 1 -s -i --user-agent "" -d "sl=$l_source" -d "tl=$l_target" --data-urlencode "text=$text" https://translate.google.com)
encoding=$(awk '/Content-Type: .* charset=/ {sub(/^.*charset=["'\'']?/,""); sub(/[ "'\''].*$/,""); print}' <<<"$result")
#result=$(iconv -f $encoding <<<"$result" |  awk 'BEGIN {RS="</div>"};/<span[^>]* id=["'\'']?result_box["'\'']?/' | html2text -utf8 | sed 's/<[^>]*>//g')
result=$(iconv -f $encoding <<<"$result" |  awk 'BEGIN {RS="</div>"};/<span[^>]* id=["'\'']?result_box["'\'']?/' | html2text | sed 's/<[^>]*>//g')
echo $result | xclip -in -sel clip     #копируем перевод в буфер
result=`echo "naughty.notify({title=\"Перевод: \", text=\" $result\", timeout = 20})"`
echo $result | awesome-client -

exit
