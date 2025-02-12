#!/usr/bin/env ruby

require 'test_helper'

class TestThreadSafety < Test::Unit::TestCase
  def setup
    clone_working_repo
  end

  def test_git_init_bare
    dirs = []
    threads = []

    5.times do
      dirs << Dir.mktmpdir
    end

    dirs.each do |dir|
      threads << Thread.new do
        Git.init(dir, :bare => true)
      end
    end

    threads.each(&:join)

    dirs.each do |dir|
      Git.bare(dir).ls_files
    end
  end
end
