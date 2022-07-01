#!/usr/bin/env ruby
require 'dotenv/load'
require "thor"
require "./github_service"

class App < Thor
  desc "remove_user", "Removes the user from all my repos"
  def remove_user(username)
    service = GithubService.new
    service.get_repos.each do |repo|
      begin
        service.remove_user(repo, username)
      rescue Octokit::Forbidden
        puts "Couldn't remove from #{repo.full_name}"
      end
    end
  end
end

App.start(ARGV)
