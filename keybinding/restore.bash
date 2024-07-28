while read line; do
  schema="${line%% *}"
  rest="${line#* }"
  key="${rest%% *}"
  value="${rest#* }"
  echo gsettings set "$schema" "$key" "$value"
  gsettings set "$schema" "$key" "$value"
done < all_settings.txt
