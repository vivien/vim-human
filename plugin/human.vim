" Vim plugin to enhance the writing of human readable formats, such as Markdown.
" Last Change:	2012 Jul 1
" Maintainer:	Vivien Didelot <vivien@didelot.org>
" License:		This file is distributed under the Beerware license.

if exists("g:loaded_human")
	finish
endif
let g:loaded_human = 1

augroup human
	autocmd!

	autocmd BufNewFile,BufRead *.{md,markdown} setfiletype markdown
	autocmd FileType markdown call s:HumanSpellChecking()
	autocmd FileType markdown call s:HumanFormatting()

	autocmd BufNewFile,BufRead *.txt call s:HumanSpellChecking()
	autocmd BufNewFile,BufRead *.txt call s:HumanFormatting()
	autocmd FileType help setlocal nospell

	autocmd FileType gitcommit call s:HumanSpellChecking()
augroup END

function s:HumanSpellChecking()
	setlocal nolist
	setlocal spell
	if &keywordprg == "man"
		setlocal keywordprg=sdcv
	endif
	setlocal dictionary=/usr/share/dict/words
	setlocal complete=.,w,k
	setlocal infercase
endfunction

function s:HumanFormatting()
	setlocal textwidth=0
	setlocal wrap
	setlocal autoindent
	setlocal formatoptions=tnbl1
endfunction

if !exists(":HumanSpellChecking")
	command -nargs=0	HumanSpellChecking	:call s:HumanSpellChecking()
endif
if !exists(":HumanFormatting")
	command -nargs=0	HumanFormatting		:call s:HumanFormatting()
endif
