param(
    [array]$workitems
)

$workitems `
    | Group-Object -Property { $_.fields.'System.WorkItemType' } `
    | ForEach-Object {
        "## $($_.Name)"
        $_.Group | ForEach-Object {
            "* [$($_.fields.'System.Title')]($($_._links.html.href)) ($($_.fields.'System.State'))"
        }
        ""
    }