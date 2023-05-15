if !has('win32')
    let g:codi#interpreters = {
            \ 'python': {
                \ 'bin': 'python3',
                \ 'prompt': '^\(>>>\|\.\.\.\) ',
                \ },
            \ }
endif
