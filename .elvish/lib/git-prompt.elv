use re

symbol = [
    &dirty="▲"
    &good="✓"
    &ahead="↑"
    &behind="↓"
    &diverged="↕"
]

# Ouput branch name and status
fn status-and-branch {
    raw-status = [(git status --branch --porcelain 2> /dev/null)]

    # Match branch like '## master...origin/master'
    branch-match = (re:find '## (.*?)\.\.\..*' $raw-status[0])
    branch = $branch-match[groups][1][text]

    status = ""

    if (> (count $raw-status) 1) {
        status = (edit:styled $symbol[dirty] yellow)
    } else {
        status = (edit:styled $symbol[good] green)
    }

    put $branch $status
}

fn prompt {
    put {
        try {
            branch status = (status-and-branch)
            put $branch " "  $status
        } except err {
            nop
        }
    }
}
