# This script can be used if you have a speaker in your show and dont want to play loud music all the time. you can have a button the audience can press and trigger this script
# You can change the volume by just changing 70 to some thing else like "fpp -v 35" puts the volume at 35%
# By: Emil Johansen
#####################################################
# ONLY CHANGE THE NUMBERS AND BETWEEN THE ###
#volume at beginning and end:
e=30

#volume at peak:
v=70

#Time the audio is at peak
# 5s = Wait 5 seconds
# 5m = Whait 5 minutes
# 5h = Whait 5 hours
t=3m

# Speed: (not defined in sec)(do not set to low else it will begin to lag)
s=5
#######################################################

i=$e
until [ $i -gt $((v-s)) ]
do
  echo i: $i
  ((i=i+$s))
fpp -v $i
done
sleep $t
while [ $i -ge $((e+s)) ]
do
  echo Number: $i
  let "i-=$s" 
fpp -v $i
done
FADE OUT
