# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500
warn("Small PR") if git.lines_of_code < 15

warn("Please provide a summary in the Pull Request description") if github.pr_body.length < 5
warn("This PR must be resubmited to master") if github.branch_for_base != "master"

message("Welcome, Balavor.") if github.pr_author == "Balavor"

warn("Dangerfile is changed") if git.modified_files.include? "Dangerfile"

#if git.modified_files.include? "Demo/Tests/ReferenceImages/*.jpg"
#  config_files = git.modified_files.select { |path| path.include? "Demo/Tests/ReferenceImages/" }
#  warn("This PR has ovveriden reference images #{ github.html_link(config_files) }")
#end

#if git.modified_files.include? "Demo/Tests/DiffImages/*.jpg"
#  config_files = git.modified_files.select { |path| path.include? "Demo/Tests/" }
#  fail "Tests are failed. Here're difference images  #{ github.html_link(config_files)}"
#end

#message "This PR changes #{ github.html_link(config_files)

#junit.parse "fastlane/test_output/report.junit"
#junit.headers = %i(file name)
#junit.report

#Instead junit.report - fail("Tests failed") unless junit.failures.empty?