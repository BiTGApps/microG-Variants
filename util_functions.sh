# This file is part of The BiTGApps Project

# Define Current Version
version="v1.9"
versionCode="19"

# Define Installation Size
CAPACITY="NULL"

print_title() {
  local LEN ONE TWO BAR
  ONE=$(echo -n $1 | wc -c)
  TWO=$(echo -n $2 | wc -c)
  LEN=$TWO
  [ $ONE -gt $TWO ] && LEN=$ONE
  LEN=$((LEN + 2))
  BAR=$(printf "%${LEN}s" | tr ' ' '*')
  ui_print "$BAR"
  ui_print " $1 "
  [ "$2" ] && ui_print " $2 "
  ui_print "$BAR"
}

list_files() {
cat <<EOF
AppleNLPBackend
DejaVuNLPBackend
FossDroid
FoxDroid
LocalGSMNLPBackend
LocalWiFiNLPBackend
MozillaUnifiedNLPBackend
NominatimNLPBackend
DroidGuard
Extension
FakeStore
MicroGGMSCore
MicroGGSFProxy
Phonesky
EOF
}

ch_con() { chcon -h u:object_r:${1}_file:s0 "$2"; }
