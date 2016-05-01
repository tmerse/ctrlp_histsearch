" Author: Tobias Mersmann.

if exists('g:loaded_ctrlp_shell_history') && g:loaded_ctrlp_shell_history
  finish
endif
let g:loaded_ctrlp_shell_history = 1

if !exists("g:ctrlp#shell_history#path")
  let g:ctrlp#shell_history#path = $HOME . '/.bash_history'
endif

if !exists("g:ctrlp#shell_history#size")
  let g:ctrlp#shell_history#size = -2000
endif

function! ctrlp#shell_history#replace(str)
  return substitute(a:str, '^: .*:.;', '', 'g')
endfunction

function! ctrlp#shell_history#sortUnique(list, ...)
  let list = copy(a:list)
  if ( exists( 'a:1' ) )
    call sort(list, a:1 )
  else
    call sort(list)
  endif
  if len(list) <= 1 | return list | endif
  let result = [ list[0] ]
  let last = list[0]
  let i = 1
  while i < len(list)
    if last != list[i]
      call add(result, list[i])
    endif
    let last = list[i]
    let i += 1
  endwhile
  return result
endfunction

" configuration
let s:shell_history_var = {
\  'init':   'ctrlp#shell_history#init()',
\  'exit':   'ctrlp#shell_history#exit()',
\  'accept': 'ctrlp#shell_history#accept',
\  'lname':  'myshell_history',
\  'sname':  'shell_history',
\  'type':   'line',
\  'sort':   1,
\  'nolim':  1,
\}

" what does this do?
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:shell_history_var)
else
  let g:ctrlp_ext_vars = [s:shell_history_var]
endif

function! ctrlp#shell_history#init()
  let lines = readfile(g:ctrlp#shell_history#path, '', g:ctrlp#shell_history#size)
  call map(lines, string(function("ctrlp#shell_history#replace")) . '(v:val)')
  let lines_sorted_unique = ctrlp#shell_history#sortUnique(lines)
  return lines_sorted_unique
endfunc

function! ctrlp#shell_history#accept(mode, str)
  call ctrlp#exit()
  call append(line('.'), a:str)
endfunction

function! ctrlp#shell_history#exit()
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#shell_history#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
