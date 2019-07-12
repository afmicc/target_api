require 'rubocop/rake_task'
require 'reek/rake/task'

desc 'Run Code Analysis'
task code_analysis: %i[rubocop reek rails_best_practices]

desc 'Run RuboCop'
task :rubocop do
  puts '=> Running RuboCop'
  RuboCop::RakeTask.new || true
end

desc 'Run Rails Best Practices'
task :rails_best_practices do
  require 'rails_best_practices'
  puts '=> Running RailsBestPractices'
  app_root = Rake.application.original_dir
  analyzer = RailsBestPractices::Analyzer.new(app_root, format: 'text')
  analyzer.analyze
  analyzer.output
end

desc 'Run Reek'
task :reek do
  puts '=> Running Reek'
  Reek::Rake::Task.new
end
