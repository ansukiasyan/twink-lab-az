#!/bin/bash

Loc_Random="xxxxxxxxxx"
Loc_StorAcc=$Loc_Random"zzcommon1"

Loc_Script_Base=$Loc_Random"_base.sh"
Loc_Script_Base_Link="https://"$Loc_StorAcc".blob.core.windows.net/scripts/"$Loc_Script_Base
Loc_Script_Ovpn=$Loc_Random"_ovpn.sh"
Loc_Script_Ovpn_Link="https://"$Loc_StorAcc".blob.core.windows.net/scripts/"$Loc_Script_Ovpn

cd /
wget $Loc_Script_Base_Link
wget $Loc_Script_Ovpn_Link

setenforce 0

awk '{ sub("\r$", ""); print }' /$Loc_Script_Base > /$Loc_Script_Base.new
awk '{ sub("\r$", ""); print }' /$Loc_Script_Ovpn > /$Loc_Script_Ovpn.new

mv -f /$Loc_Script_Base.new /$Loc_Script_Base
mv -f /$Loc_Script_Ovpn.new /$Loc_Script_Ovpn

cd /
sh $Loc_Script_Base

cd /
sh $Loc_Script_Ovpn

