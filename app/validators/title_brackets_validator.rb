class TitleBracketsValidator < ActiveModel::Validator
  def validate(title)
      if check_title(title.title)
      else
        title.errors.add(:base, "has invalid title")
      end
  end

  private
  def check_title(title)
    bracket_counter = 0
    previous_character = ""

    title.each_char do |char|
      case char
        when "("
          bracket_counter += 1
        when ")"
          bracket_counter -= 1
        when "{"
          bracket_counter += 1
        when "}"
          bracket_counter -= 1
        when "["
          bracket_counter += 1
        when "]"
          bracket_counter -= 1
      end

      return false if previous_character =="(" && char == ")"
      return false if bracket_counter < 0

      previous_character = char
    end

    return bracket_counter == 0
  end
end