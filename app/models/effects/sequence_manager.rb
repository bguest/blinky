module SequenceManager extend self

  attr_reader :sign, :instructions, :dead_thread
  attr_accessor :period

  # Runs effects in a loop in a seperate thread
  #
  def run(sign, sequence)
    return unless sign.push
    @sign = sign
    @instructions = sequence.instructions.order(:number)
    @count = instructions.size
    self.stop
    @curr_idx = 0
    @start_time = Time.now
    @threads << Thread.new do
      EffectsManager.run(sign, instructions[0])
      loop do
        if run_time > instructions[@curr_idx].duration
          @curr_idx += 1
          @curr_idx = @curr_idx % @count
          EffectsManager.run(sign, instructions[@curr_idx])
          @start_time = Time.now
        end
        sleep period
      end
    end
  end

  def thread
    @threads.last
  end

  def stop
    EffectsManager.stop
    @threads ||= []
    @threads.each do |thr|
      Thread.kill(thr)
      @dead_thread = @threads.delete(thr)
    end
  end

  def period
    @period ||= 0.005
  end

  def run_time
    Time.now - @start_time
  end
end
