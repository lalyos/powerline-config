# My personal powerline config

I had a lots of trouble on my mac, when i upraded powerline. After a lot of
debugging i was able to have my settings back:
![my preferred powerline setup](powerline-sample.png)

My preferred segments, for **shell**

- workdir (abreviated) 
- VCS branch, if any

for **tmux** reduced right side:

- date
- time
- battery percent
- no icons

## tl;dr

The biggest issue was, that powerline didn't work at all:

```
-bash: : command not found
```

it is a sympthom of powerline not beeing able to locate the `powerline`
binary. To check if your powerline can locate it:

```
$ powerline-config shell command

powerline
```

for me the problem was that the `VIRTUAL_ENV` env var wasn't absolute path,
So i fixed it in my `.profile`

``` diff
--- export VIRTUAL_ENV="~/.virtualenv"
++++ export VIRTUAL_ENV="$HOME/.virtualenv"
```
