" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-14

if exists("loaded_plugin_now_insert_mode_fix")
  finish
endif
let loaded_plugin_now_insert_mode_fix = 1

let s:cpo_save = &cpo
set cpo&vim

nnoremap <expr> i <SID>begin_insert_mode('i')
nnoremap <expr> gi <SID>begin_insert_mode('gi')
inoremap <silent> <Esc> <C-O>:call <SID>end_insert_mode_before()<CR><Esc>:call <SID>end_insert_mode_after()<CR>
imap <C-c> <Esc>

function s:begin_insert_mode(command)
  let s:insert_mode_type = 'i'
  return a:command
endfunction

function s:end_insert_mode_before()
  let s:shift_cursor = 0
  if exists('s:insert_mode_type')
    let s:shift_cursor = (s:insert_mode_type == 'i' && col('.') != 1)
    unlet s:insert_mode_type
  endif
endfunction

function s:end_insert_mode_after()
  if exists('s:shift_cursor') && s:shift_cursor
    call cursor(0, col('.') + 1)
  endif
  unlet! s:shift_cursor
endfunction

let &cpo = s:cpo_save
