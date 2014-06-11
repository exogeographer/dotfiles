set nocompatible

" turn on line numbers.
set nu
set t_Co=256

" turn off annoying terminal beeps
set visualbell

" set tab as 4 spaces.
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

" show a few types of white space.
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<
set list

colorscheme jellybeans
if has('gui_running')
  colorscheme railscasts
endif

" allow backspacing
set backspace=indent,eol,start

" highlight searchterms
set hlsearch

" fold settings
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" show when we go over 80 characters
highlight overLength ctermbg=red ctermfg=white guibg=#CD4F39
match overLength /\%81v.\+/

" turn off gui scrollbars for better mac fullscreen
set guioptions-=l
set guioptions-=r
set go-=L

" set zsh as default
set shell=/bin/zsh

" pet peaves are long strings wrapping and hovering at bottom
set nowrap
set scrolloff=8

" set font size
set guifont=Bitstream\ Vera\ Sans\ Mono:h15

" turn on ruler and cursorline
set cursorline
set ruler

" turn on syntax highlighting for mac
filetype plugin indent on
syntax on
set term=builtin_ansi

" set LineNr highlighting (put here b/c doesn't work higher)
highlight LineNr term=bold ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#666666 guibg=#111111
hi cursorline ctermbg=darkgray guibg=#252525

" Make VertSplit characters less annoying
hi VertSplit ctermfg=black ctermbg=black guifg=#111111 guibg=#111111

" turn on status bars permanently and set to dark gray.
hi statuslinenc ctermbg=black guibg=#252525 guifg=#eeeeee
hi statusline ctermbg=black ctermfg=blue
set laststatus=2

" set background of highlighted text mint green.
hi visual guibg=#2e9afe

" keep background and whitespace dark
hi normal guibg=#111111
hi nontext guibg=#111111 guifg=#353535

" syntax tweaks
let python_highlight_all=1
hi comment ctermfg=darkgreen
hi function ctermfg=green
hi conditional ctermfg=red
hi statement ctermfg=blue
hi repeat ctermfg=yellow
hi operator ctermfg=magenta
hi pythonInclude ctermfg=darkmagenta

" function that enables hex editing with F8
noremap <F8> :call HexMe()<CR>

let $in_hex=0
function HexMe()
  set binary
  set noeol
  if $in_hex>0
    :%!xxd -r
    let $in_hex=0
  else
    :%!xxd
    let $in_hex=1
  endif
endfunction

" Enable context specific tab completion:
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
