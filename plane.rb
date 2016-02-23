class Plane
  def initialize
    @engines = Array.new(4) { Engine.new }
  end

  def start_engines
    @engines.each do |engine|
      engine.start
    end
  end
end

class Engine
  def start
    @running = true
  end

  def running?
    !!@running
  end
end
