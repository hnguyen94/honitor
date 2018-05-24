require 'parallel'

class Hydra
  class << self
    def execute
      Parallel.map(instances, in_processes: 2) do |instance|
        Honitor.new(instance: instance)
      end
    end

    def instances
      filenames = Dir.entries('configs').reject { |f| File.directory? f }
      filenames.map { |filename| File.basename(filename, '.yml') }
    end
  end
end
