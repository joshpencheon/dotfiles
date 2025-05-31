# Basic bash completion for ollama.
_complete_ollama() {
    local cur prev words cword
    _init_completion -n : || return

    if [[ ${cword} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "serve create show run stop push pull list ps cp rm help" -- "${cur}"))
    elif [[ ${cword} -eq 2 ]]; then
        case "${prev}" in
            (run|show|cp|rm|push|list)
                WORDLIST=$((ollama list 2>/dev/null || echo "") | tail -n +2 | cut -d " " -f 1)
                ;;
            (stop)
                WORDLIST=$((ollama ps 2>/dev/null || echo "") | tail -n +2 | cut -d " " -f 1)
                ;;
        esac

        COMPREPLY=($(compgen -W "${WORDLIST}" -- "${cur}"))
        __ltrim_colon_completions "$cur"
    fi
}
complete -F _complete_ollama ollama
