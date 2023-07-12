#!/usr/bin/env bash


# TODO: configurable sleep amount in params
# TODO: pipes that don't exist anymore remove from in_pipes
# TODO: every so often (few thousand iterations or so), reload the in_pipes from
# a file (so between this and above, can quickly add and remove in_pipes to help
# for performance reasons


out_channel=$1
shift
in_pipes=$@

while :; do
  for pipe in $in_pipes; do
    cat 3<> $pipe <$pipe 3<&- >>$out_channel
  done
  sleep .1
done
