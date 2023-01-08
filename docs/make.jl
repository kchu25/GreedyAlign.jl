using GreedyAlign
using Documenter

DocMeta.setdocmeta!(GreedyAlign, :DocTestSetup, :(using GreedyAlign); recursive=true)

makedocs(;
    modules=[GreedyAlign],
    authors="Shane Kuei-Hsien Chu (skchu@wustl.edu)",
    repo="https://github.com/kchu25/GreedyAlign.jl/blob/{commit}{path}#{line}",
    sitename="GreedyAlign.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://kchu25.github.io/GreedyAlign.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kchu25/GreedyAlign.jl",
    devbranch="main",
)
