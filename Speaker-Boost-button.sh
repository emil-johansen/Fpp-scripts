# You can change the volume by just changing 70 to some thing else like "fpp -v 35" puts the volume at 35%
# Examples on time config :
# sleep 5s = Wait 5s
# sleep 5m = Whait 5m
# sleep 5h = Whait 5h
# The script:
#############################
#volume at beginning and end:
e=30
#volume at peak:
v=70
# Speed: (not defined in sec)(do not set to low else it will begin to lag)
s=5
#############################

i=$e
until [ $i -gt $((v-s)) ]
do
  echo i: $i
  ((i=i+$s))
fpp -v $i
done
sleep 5
while [ $i -ge $((e+s)) ]
do
  echo Number: $i
  let "i-=$s" 
fpp -v $i
done
FADE OUT
