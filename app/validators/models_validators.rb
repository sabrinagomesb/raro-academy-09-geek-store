# frozen_string_literal: true

module ModelsValidators
  def allowed_length(string, min, max)
    errors.add(string, "must be between #{min} and #{max} characters") unless string.length.between?(min, max)
  end

  def name_allowed_length
    allowed_length(name, 3, 255)
  end
end
