Fuzzy-search `~/.bash_history, ~/.zsh_history` inside vim via [ctrlp](https://github.com/cdtrlpvim/ctrlp.vim).

# Usage

Run `:CtrlPShellHistory` and a buffer with entries of you term-history will show up.
Pressing return will paste the current line below the cursor.

# Configuration

Inside `.vimrc` / `init.vim`:

~~~ {.vimscript}
" by default, this is set to $HOME . '/.bash_hitory'
let g:ctrlp#shell_history#path = $HOME . '/.zsh_history'

" negative value will take last n entries into consideration (bottom up).
" use a positive value, for top-down.
" default: -2000
let g:ctrlp#shell_history#size = -3000
~~~

# TODO:

- Better matching/smallest match first (typing `cp` should show `cp foo bar` first instead of `cat paw` ).
- Instead of appending the selection below the cursor, the user should be able to provide a function that acts on the return value after ctrlp closed.
