Function Set-EvilGitConfig
{
	if (-Not(Test-Path ".git")) {
		throw "Not a git directory"
	}

	git config user.name "Oliver Smith"
	git config user.email "oliver.smith@superevilmegacorp.com"
	git config pull.rebase true
	git config http.maxRequestBuffer 500M
	git fetch -a origin +refs/svn/map:refs/notes/commits
}
