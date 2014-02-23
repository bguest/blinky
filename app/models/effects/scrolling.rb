# == Schema Information
#
# Table name: effects
#
#  id             :integer          not null, primary key
#  instruction_id :integer
#  type           :character varyin
#  number         :integer
#  data           :character varyin
#  created_at     :timestamp withou not null
#  updated_at     :timestamp withou not null
#
# Indexes
#
#  index_effects_on_instruction_id  (instruction_id)
#

class Scrolling < Effect

  attr_reader :sign, :inst
  attr_accessor :cycles

  def fields
    %i(tempo)
  end

  # Returns phrase to be used with currenc sign based on phrase size and
  #  number of letters in sign. This value is cached.
  #
  def phrase
    return @phrase if @phrase

    letters_size = sign.letters.size
    if inst.phrase.size > letters_size
      @phrase = ' '*letters_size + inst.phrase
    else
      @phrase = inst.phrase
    end
  end

  # Number of cycles before scrolling moves one letter
  #
  def cycles
    @cycles ||= 5
  end

  def reset
    @phrase = nil
    @step_number = nil
  end

  # Number scrolling steps that have been taken
  #
  def step_number
    @step_number ||= (@time.to_f/60.0*data['tempo'].to_f).floor
  end

  def run(options)
    self.reset
    @clock = options[:clock]
    @sign = options[:sign]
    @inst = options[:instruction]
    @time = options.fetch(:time){0}
    @step_number = 0 if inst.phrase.size <= sign.letters.size
    sign.ordered_letters.each_with_index do |letter, idx|
      curr_idx = (idx+step_number)%phrase.size
      letter.set_value(phrase[curr_idx])
    end
    options[:needs_update] ||= needs_update
  end

  private
  # Returns true for false depending on if sing needs update
  #
  def needs_update
    return true if @clock == 0
    return true if inst.phrase.size > sign.letters.size && @time%(60/data['tempo'].to_f) < Manager.period - 0.001

    false
  end
end
