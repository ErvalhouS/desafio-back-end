# frozen_string_literal: false

module LineBreaker
  # Receives a file as argument and returns it's array of
  # lines, fixing encoding issues.
  def self.parse(file)
    file.force_encoding('UTF-8')
        .gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
        .split("\n")
  end
end
