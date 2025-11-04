namespace :simplecov do
  desc 'Generate merged coverage report'
  task :report do
    require 'simplecov'
    SimpleCov.collate Dir['coverage/.resultset*.json']
  end
end
