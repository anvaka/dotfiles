# My dotfiles

This is just a collection of my settings. I'm using OSX as my primary dev environment.
Vim is configured for use in iTerm.

# MacVim trouble with Lua?

``` js
brew uninstall macvim
brew remove macvim
brew cleanup
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit
```

## PS: vim --version

```
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Mar 30 2014 19:42:26)
MacOS X (unix) version
Included patches: 1-52
Compiled by Homebrew
Huge version with MacVim GUI.  Features included (+) or not (-):
+acl             +file_in_path    +mouse_sgr       +tag_binary
+arabic          +find_in_path    -mouse_sysmouse  +tag_old_static
+autocmd         +float           +mouse_urxvt     -tag_any_white
+balloon_eval    +folding         +mouse_xterm     +tcl
+browse          -footer          +multi_byte      +terminfo
++builtin_terms  +fork()          +multi_lang      +termresponse
+byte_offset     +fullscreen      -mzscheme        +textobjects
+cindent         -gettext         +netbeans_intg   +title
+clientserver    -hangul_input    +odbeditor       +toolbar
+clipboard       +iconv           +path_extra      +transparency
+cmdline_compl   +insert_expand   +perl            +user_commands
+cmdline_hist    +jumplist        +persistent_undo +vertsplit
+cmdline_info    +keymap          +postscript      +virtualedit
+comments        +langmap         +printer         +visual
+conceal         +libcall         +profile         +visualextra
+cryptv          +linebreak       +python          +viminfo
+cscope          +lispindent      -python3         +vreplace
+cursorbind      +listcmds        +quickfix        +wildignore
+cursorshape     +localmap        +reltime         +wildmenu
+dialog_con_gui  +lua             +rightleft       +windows
+diff            +menu            +ruby            +writebackup
+digraphs        +mksession       +scrollbind      -X11
+dnd             +modify_fname    +signs           -xfontset
-ebcdic          +mouse           +smartindent     +xim
+emacs_tags      +mouseshape      -sniff           -xsmp
+eval            +mouse_dec       +startuptime     -xterm_clipboard
+ex_extra        -mouse_gpm       +statusline      -xterm_save
+extra_search    -mouse_jsbterm   -sun_workshop    -xpm
+farsi           +mouse_netterm   +syntax          
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  system gvimrc file: "$VIM/gvimrc"
    user gvimrc file: "$HOME/.gvimrc"
2nd user gvimrc file: "~/.vim/gvimrc"
    system menu file: "$VIMRUNTIME/menu.vim"
  fall-back for $VIM: "/Applications/MacVim.app/Contents/Resources/vim"
Compilation: clang -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_MACVIM -Wall -Wno-unknown-pragmas -pipe  -DMACOS_X_UNIX -no-cpp-precomp  -g -O2 -arch x86_64 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1     -I/System/Library/Frameworks/Tcl.framework/Headers  -D_REENTRANT=1  -D_THREAD_SAFE=1  -D_DARWIN_C_SOURCE=1  
Linking: clang   -L.   -L.   -L/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/config -F/Library/Frameworks -arch x86_64 -L/usr/local/lib -o Vim -framework Cocoa -framework Carbon       -lncurses -liconv -framework Cocoa  -pagezero_size 10000 -image_base 100000000 -L/usr/local/lib -lluajit-5.1 -fstack-protector -L/usr/local/lib  -L/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE -lperl -lm -lutil -lc -framework Python  -F/System/Library/Frameworks -framework Tcl -framework CoreFoundation -framework Ruby   
```
