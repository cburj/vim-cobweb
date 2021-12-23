" -----------------------------------------------------------------------------------
" VIM Cobweb:   VIM Utilities for HTML Development
" Maintainer:   Charlie Burgess [http://cburg.co.uk]
" Version:      0.0.1
" Project Repo: http://github.com/cburj/vim-cobweb/
" Description:  Cobweb is a plugin designed for basic
"               HTML Development - including code snippets,
"               tag completion and more.


" KEYBINDS:
nnoremap web  :call COBWEB_Menu() <CR>


""
" Main Menu (GUI) for Cobweb
function! COBWEB_Menu()
  call popup_menu( ['</HTML Boilerplate>', '</Toggle Comment>'], #{ title: "Cobweb Snippets", callback: 'COBWEB_HandleMenu', highlight: 'wildmenu', border: [], close: 'click', padding: [ 1,5,1,5 ] } )
endfunction


""
" Handler for the Snippets menu
function! COBWEB_HandleMenu( id, result )
  if a:result == 1
    call COBWEB_BoilerPlate()
  elseif a:result == 2
    call COBWEB_CommentLine()
  else
    "Do nothing
  endif  
endfunction


""
" HTML Boilerplate take from Emmet
"
function! COBWEB_BoilerPlate()
  execute "normal! i<!DOCTYPE html>\r
        \<html lang='en'>\r
        \<head>\r
        \<meta charset='utf-8'>\r
        \<meta name='viewport' content='width=device-width, initial-scale=1.0'>\r
        \<title>Document</title>\r
        \</head>\r
        \<body>\r
        \</body>\r
        \</html>"
endfunction


""
" Automatically adds in the relevant header
" tags based on the size input specified.
function! COBWEB_HeaderTag( HeaderSize )

  " Check the input is between 1 and 6
  if( a:HeaderSize=~# '^[1-6]$' )
    let line = line(".")
    let column = col(".")
    let newCol = column + 4
    execute "normal! i<h" . a:HeaderSize . "></h" . a:HeaderSize . ">"
    execute "normal! " . newCol . "|"
  endif

endfunction


""
" WIP - Comment out current line.
"
function! COBWEB_CommentLine()
  let line = getline( "." )
  "Check if we are adding or removing comments from the line.
  if( line =~ "<!-" )
    "We need to remove the comments
    exe 'silent %s/<!--//g'
    exe 'silent %s/-->//g'
  else
    "we need to add comments
  endif
endfunction
