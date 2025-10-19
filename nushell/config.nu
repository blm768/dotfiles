$env.config.edit_mode = "vi";
$env.config.history.file_format = "sqlite";
$env.config.history.isolation = true;
$env.config.show_banner = false;

$env.config.keybindings ++= [
    # "Borrowed" from https://github.com/MatrixManAtYrService/configs/blob/main/home-manager/config/nushell/config.nu
    {
        name: fuzzy_history
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: [
            {
                send: ExecuteHostCommand
                cmd: "commandline edit --replace (
                    history
                    | get command
                    | reverse
                    | uniq
                    | str join (char -i 0)
                    | fzf --scheme=history --read0 --layout=reverse --height=40% -q (commandline)
                    | decode utf-8
                    | str trim
                )"
            }
        ]
    }
    {
        name: fuzzy_filefind
        modifier: control
        keycode: char_t
        mode: [emacs, vi_normal, vi_insert]
        event: [
            {
                send: ExecuteHostCommand
                cmd: "commandline edit --replace (
                    if ((commandline | str trim | str length) == 0) {
                        # if empty, search and use result
                        (fzf --height=40% --layout=reverse | decode utf-8 | str trim)
                    } else if (commandline | str ends-with ' ') {
                        # if trailing space, search and append result
                        [
                        (commandline)
                        (fzf --height=40% --layout=reverse | decode utf-8 | str trim)
                        ] | str join
                    } else {
                        # otherwise search for last token
                        [
                        (commandline | split words | reverse | skip 1 | reverse | str join ' ')
                        (fzf
                            --height=40%
                            --layout=reverse
                            -q (commandline | split words | last)
                            | decode utf-8 | str trim)
                        ] | str join ' '
                    }
                )"
            }
        ]
    }
]

alias g = git
