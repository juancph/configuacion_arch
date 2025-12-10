" ===== Configuración básica =====

" Activar números de línea
set number

set relativenumber

" Activar sintaxis
syntax on

" Resaltar búsqueda
set hlsearch

" Autocompletado incremental
set incsearch

" Mostrar coincidencias mientras escribes
set showmatch

" Usar tabs y espacios
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Activar portapapeles del sistema
set clipboard=unnamedplus

" Colores (usa tema predeterminado de terminal)
set termguicolors

" Salir del terminal y volver al modo normal con Esc
tnoremap <Esc> <C-\><C-n>


" Guardar automáticamente al salir de Insert
autocmd InsertLeave * silent! write

" Guardar automáticamente al cambiar de ventana o perder el foco
autocmd FocusLost * silent! write

" Permitir que muchos comandos guarden solo si se han hecho cambios
set autowrite
set autowriteall


set updatetime=1000
autocmd CursorHold * silent! write



" ==============================
"   PALETA DE COLORES PERSONALIZADA
" ==============================

" Fondo transparente
hi Normal        guibg=NONE ctermbg=NONE guifg=#e4e6eb
hi NormalNC      guibg=NONE ctermbg=NONE guifg=#e4e6eb

" Números de línea
hi LineNr        guibg=NONE ctermbg=NONE guifg=#6b7280
hi CursorLineNr  guibg=NONE ctermbg=NONE guifg=#88c0d0

" CursorLine
hi CursorLine    guibg=#2f323a

" Selección visual
hi Visual        guibg=#6b7280 guifg=#e4e6eb

" Comentarios
hi Comment       guifg=#6b7280 gui=italic

" Strings
hi String        guifg=#9ecab0

" Keywords
hi Keyword       guifg=#8f7f9f gui=bold

" Constantes / números
hi Constant      guifg=#88c0d0

" Funciones
hi Function      guifg=#8b93a8 gui=bold

" Tipos (class, struct...)
hi Type          guifg=#b48ead gui=bold

" Errores y advertencias
hi Error         guifg=#bf616a gui=bold
hi WarningMsg    guifg=#b7a86b

" Menús (autocompletado)
hi Pmenu         guibg=#2f323a guifg=#e4e6eb
hi PmenuSel      guibg=#6b7280 guifg=#e4e6eb

" Búsqueda
hi Search        guibg=#6b7280 guifg=#e4e6eb
hi IncSearch     guibg=#88c0d0 guifg=#1e1e1e

" Separadores
hi VertSplit     guibg=NONE ctermbg=NONE guifg=#2f323a
