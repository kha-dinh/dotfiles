if exists("b:current_syntax") | finish | endif
syn case match

" ---------- Core ----------
" Titles & continuation
syntax match xitTitle /[^ \t\[].*$/
syntax match xitCont  /    .*$/

" Tags (simple)
syntax match xitTagName /#[A-Za-z0-9_-]\+/ contained
syntax match xitTagValue /=\S\+/ contained
syntax match xitTag /#[A-Za-z0-9_-]\+\(=\S\+\)\?/ contains=xitTagName,xitTagValue


" Due date: '-> ' then anything to EOL
syntax match xitDue /-> .*$/

" ---------- Status-specific ----------
" Boxes
syntax match xitBoxOpen        /\[\ \]/
syntax match xitBoxChecked     /\[x\]/
syntax match xitBoxOngoing     /\[@\]/
syntax match xitBoxObsolete    /\[~\]/
syntax match xitBoxInQuestion  /\[\?\]/

syntax match xitLineOpen       /\[\ \].*$/ contains=xitBoxOpen,xitPriority,xitDue,xitTag,xitTagName,xitTagValue
syntax match xitLineChecked    /\[x\].*$/ contains=xitBoxChecked,xitPriority,xitDue,xitTag,xitTagName,xitTagValue
syntax match xitLineOngoing    /\[@\].*$/ contains=xitBoxOngoing,xitPriority,xitDue,xitTag,xitTagName,xitTagValue
syntax match xitLineObsolete   /\[\~\].*$/ contains=xitBoxObsolete,xitPriority,xitDue,xitTag,xitTagValue
syntax match xitLineQuestion   /\[?\].*$/ contains=xitBoxInQuestion,xitPriority,xitDue,xitTag,xitTagName,xitTagValue


" Priority: any combo of '.' and '!'
syntax match xitPriority /\v\s+[.!]+/


" ---------- Highlights ----------
hi def link xitTitle           Title
hi def link xitCont            Comment
hi def link xitTagName         Type
hi def link xitTagValue        Constant
hi def link xitTag             PreProc
hi def link xitPriority        WarningMsg
hi def link xitDue             Number

" Status colors (tweak to taste)
hi def link xitBoxOpen         Identifier
hi def link xitLineOpen        Normal

hi def link xitBoxChecked      String
hi def link xitLineChecked     Comment

hi def link xitBoxOngoing      Identifier
hi def link xitLineOngoing     Identifier

hi def link xitBoxObsolete     Comment
hi def link xitLineObsolete    Comment

hi def link xitBoxInQuestion   DiagnosticWarn
hi def link xitLineQuestion    DiagnosticWarn

let b:current_syntax = "xit"
