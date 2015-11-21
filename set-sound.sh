#!/bin/bash 

# put the first sink input to the analog device (cause sink inputs are set to the SX device by default)

# list sink input:
# pactl list sink-inputs

ANALOG=0
SX200=1

# en cas de basculement en numérique, décommenter cett eligne
#pactl set-card-profile $SX200 output:iec958-stereo+input:analog-stereo


echo -n "Wait sink input"
while [ 1 ]; do
  num_sink=$(pactl list sink-inputs | grep Sink.Input | wc -l)
  if [[ "$num_sink" -ge "2" ]]; then
    echo
    first_input=$(pactl list sink-inputs | grep Sink.Input | head -n 1 | cut -f3 -d' '| tr '#' ' ')
    second_input=$(pactl list sink-inputs | grep Sink.Input | tail -n 1 | cut -f3 -d' '| tr '#' ' ')
    echo "Moving input: $first_input to device $ANALOG";
    pactl move-sink-input $first_input $ANALOG
    pactl set-sink-input-volume $first_input 65536
    echo "Moving input: $second_input to device $SX200";
    pactl move-sink-input $second_input $SX200
    pactl set-sink-input-volume $second_input 65536
	
    break
  else
    echo -n "."
    sleep 5
  fi
done

# redirection de la bonne entrée son
pactl set-source-port 3 analog-input-linein
id_card=$(pactl list source-outputs|grep qemu -C 20|grep "Source Output"|head -n1|cut -d "#" -f2)
pactl move-source-output $id_card alsa_input.pci-0000_04_00.0.analog-stereo
