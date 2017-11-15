# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500
warn("Small PR") if git.lines_of_code < 15

fail("Please provide a summary in the Pull Request description) if github.pr_body.length < 5
warn("Please re-submit this PR to master, we may have already fixed your issue.") if github.branch_for_base != "master"

message "Welcome, Balavor." if github.pr_author == "Balavor"
