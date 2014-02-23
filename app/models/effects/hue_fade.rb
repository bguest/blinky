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

class HueFade < Effect

  def fields
    %i(fade_time)
  end

  def run(options)
    @clock = options[:clock]
    @sign  = options[:sign]
    @color = nil
    segs = @sign.letters.collect(&:segments).flatten
    segs.each do |seg|
      seg.color = color if seg.on?
    end
    options[:needs_update] ||= true
  end

  def fade_time
    data['fade_time'].to_f
  end

  private

  def color
    return @color if @color
    period = EffectsManager.period
    angle = 360/fade_time*period*@clock
    @color = Color::HSL.new(angle%360,100,50)
  end
end
