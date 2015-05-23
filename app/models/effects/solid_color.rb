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

class SolidColor < Effect

  def fields
    %i(color background_color)
  end

  def color
    data['color']
  end

  def background_color
    data['background_color']
  end

  def color=(clr)
    data['color'] = clr
  end

  def background_color=(clr)
    data['background_color'] = clr
  end


  def run(options)
    sign = options[:sign]
    color = Color::RGB.from_html(data['color'])
    bg_color = Color::RGB.from_html(data['background_color'])
    segs = sign.letters.collect(&:segments).flatten
    segs.each do |seg|
      seg.color= (seg.on? ? color : bg_color)
    end
  end
end
