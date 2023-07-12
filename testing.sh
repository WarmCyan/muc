#!/usr/bin/env bash


mkfifo thing1
mkfifo thing2


while :; do
  for pipe in {thing1,thing2}; do
    # https://unix.stackexchange.com/questions/522877/how-to-cat-named-pipe-without-waiting
     
    # for whatever reason won't put a newline between multiple messages from the same pipe?
    # line=$(cat 3<> $pipe <$pipe 3<&-)
    # if [ ! "$line" = "" ]; then
    #   echo $line
    # fi
    
    # seems to be the cleanest
    cat 3<> $pipe <$pipe 3<&- >>channel.txt
    
    # works, but obviously will scale linearly with the number of pipes
    # timeout .1 cat $pipe
  done
  #sleep .1
done
