if exists("g:github_plugin_loaded")
  finish
endif
let g:github_plugin_loaded = 1

command! CreatePR call github#create_pr()
command! ListPR call github#list_pr()
command! CheckoutPR call github#checkout_pr()
