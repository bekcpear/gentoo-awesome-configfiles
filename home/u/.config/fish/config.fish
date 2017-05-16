function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert
    # Without an argument, fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings insert
end

function fst; set_color -o fa0; end
function snd; set_color -o 36f; end
function trd; set_color -o f06; end
function dim; set_color    666; end
function off; set_color normal; end

function fish_mode_prompt
end

function fish_default_mode_prompt
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    echo -n '|'
    switch $fish_bind_mode
      case default
        set_color red # --bold --background white
        echo 'n'
      case insert
#set_color white                                                                                                                                    
        dim
        echo 'i'
      case replace-one
        set_color green
        echo 'r'
      case visual
        set_color magenta
        echo 'v'
    end
    set_color normal
    echo -n ' '
  end
end

##Theme-batman
#fish_greeting.fish
#function fish_greeting
#  echo (dim)(uname -mnprs)(off)
#end

#fish_prompt.fish
function fish_prompt
  test $status -ne 0;
    and set -l colors 700 900 d00
    or set -l colors 555 888 ccc

  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(fst)"~"(off)"|g; \
               s|/|"(snd)"/"(off)"|g;  \
               s|"$base"|"(fst)$base(off)" |g"

  echo -n (echo " $pwd" | sed -e $expr)(off)

  for color in $colors
    echo -n (set_color $color)">"
  end

  echo -n " "
  off
end

#fish_right_prompt.fish
function git::is_stashed
  command git rev-parse --verify --quiet refs/stash >/dev/null
end

function git::get_ahead_count
  echo (command git log ^/dev/null | grep '^commit' | wc -l | tr -d " ")
end

function git::branch_name
  command git symbolic-ref --short HEAD
end

function git::is_touched
  test -n (echo (command git status --porcelain))
end

function fish_right_prompt
  set -l code $status
  test $code -ne 0; and echo (dim)"("(trd)"$code"(dim)") "(off)

  if test -n "$SSH_CONNECTION"
     printf (trd)":"(dim)"$HOSTNAME "(off)
   end

  if git rev-parse 2> /dev/null
    git::is_stashed; and echo (trd)"^"(off)
    printf (snd)"("(begin
      if git::is_touched
        echo (trd)"*"(off)
      else
        echo ""
      end
    end)(fst)(git::branch_name)(snd)(begin
      set -l count (git::get_ahead_count)
        if test $count -eq 0
          echo ""
        else
          echo (trd)"+"(fst)$count
        end
    end)(snd)") "(off)
  end
  printf (dim)(date +%H:%M:%S)" "
  fish_default_mode_prompt
  off
end

#fish_title.fish
function fish_title
  echo "$PWD | $_" | sed "s|$HOME|~|g"
end

alias ls 'ls --color=never'
