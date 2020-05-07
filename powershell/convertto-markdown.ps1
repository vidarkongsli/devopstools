param(
    [array]$workitems
)

$workitems `
    | Group-Object -Property { $_.fields.'System.WorkItemType' } `
    | ForEach-Object {
        ".h2 $($_.Name)"
        $_.Group | ForEach-Object {
            "* [$($_.fields.'System.Title')]($($_._links.html.href)) ($($_.fields.'System.State'))"
        }
        ""
    }