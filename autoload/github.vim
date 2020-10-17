if exists("g:github_loaded")
  finish
endif
let g:github_loaded = 1


function! github#list_pr()
  let output = system("gh pr list")
  if output
    call s:clean_buffer("__Github_prlist__")
    split __Github_prlist__
    normal! ggdG
    setlocal filetype=github
    setlocal buftype=nofile
    call append(0, split(output, '\v\n'))
  else
    echoerr "Error raised, please run `gh pr list`"
  endif
endfunction


function! github#create_pr()
  call s:clean_buffer("__Github_prcreate__")
  split __Github_prcreate__
  setlocal filetype=github
  setlocal noswapfile
  setlocal buftype=nofile
  command! -buffer GithubCreatePR call s:create_pr()
  nnoremap <buffer> pr :GithubCreatePR<cr>
endfunction


function! github#checkout_pr()
  let branch = split(getline('.'))[0]
  execute("! gh pr checkout " . branch)
endfunction


function! s:clean_buffer(name)
  let last_bufwinnr = bufwinnr(a:name)
  if last_bufwinnr != -1
    execute "bdelete " . bufnr(a:name)
  endif
endfunction


function! s:create_pr()
  let title = join(getline(1), "\r")
  let body = join(getline(3, '$'), "\r")
  execute("bdelete")
  execute("! gh pr create --title " . title . " --body " . body)
endfunction
