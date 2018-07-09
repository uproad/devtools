
require 'octokit'

client = Octokit::Client.new(:access_token => ENV['GITHUB_API_KEY'])

user = 'uproad'
repo = 'hubout'
path = "#{user}/#{repo}"

issue_no = ARGV[0].to_i
close_flg = ARGV[1]

issue = client.issue(path,issue_no)

p issue.title

pr_body = ""
pr_body += "close ##{issue_no}\n\n" if close_flg
pr_body += "refs ##{issue_no}\n"
pr_body += "#{issue.title}\n"

client.create_pull_request(
  path,
  "master",
  "feature/issues/##{issue_no}",
  "refs ##{issue_no} [feature] #{issue.title}",
  pr_body)
