hook global WinCreate .* %{
    hook window InsertCompletionShow .* %{
        map window insert <tab> <c-n>
        map window insert <backtab> <c-p>
    }

    hook window InsertCompletionHide .* %{
        unmap window insert <tab> <c-n>
        unmap window insert <backtab> <c-p>
    }
}
