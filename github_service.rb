require "octokit"

class GithubService
  def get_repos
    user = client.user(ENV['GITHUB_OWNER'])
    repos = client.repos(user, query: {type: 'owner'})
    repos
  end

  def remove_user(repo, username)
    puts "Checking on #{repo.full_name}"
    if client.collaborator?(repo.full_name, username)
      puts "Removing #{username} from #{repo.full_name}"
      client.remove_collaborator(repo.full_name, username)
    end
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end
end