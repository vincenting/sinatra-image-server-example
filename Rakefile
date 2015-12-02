require 'rake'
require 'rake/testtask'

desc 'Run all tests'
Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

begin
  require 'cane/rake_task'

  desc 'Run cane to check quality metrics'
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 10
    cane.add_threshold 'coverage/.last_run.json', :>=, 95
    cane.style_exclude = %w(spec/**/*.rb)
  end

  task :default => :quality
rescue LoadError
  warn 'cane not available, quality task not provided.'
end
