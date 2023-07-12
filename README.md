# MUC - MOAR unix chat

I was inspired by 
[Simple Unix Chat](https://the-dam.org/docs/explanations/suc.html)!
Really neat idea, but I noticed there were some potential issues as far as race
conditions (if two people output to the same channel at the same time) and just
in general I wanted to put some more default tooling in.

This is a repository for me to play around with those ideas.

Since there's no easy way for multiple users to directly simulatenously write to
the same file without potentially stepping on eachother, or using something like
flock, instead this system operates under the assumption that every user in a
channel will have their own FIFO pipe that they write _to_, and then the "server
loop" is on each iteration checking every pipe in turn and combining any inputs
into the single output file. This doesn't guarantee perfect ordering of the
messages, but should at least solve the problem of interleaving.

## Testing the scripts so far

To see it in action, first set up some pipes:

```bash
mkfifo thing1
mkfifo thing2
```

Then start a channel daemon going:

```bash
./channel_daemon.sh test_out.txt thing1 thing2
```

To monitor/receive from the channel, in a separate terminal:

```bash
tail -f test_out.txt
```

To send to the channel, in a separate terminal, either write text to the pipe
with something like:

```bash
(echo "hello world!" > thing1 &)
```

Or run the `transmit.sh` script to see multiple messages being sent to the two
pipes at once.
