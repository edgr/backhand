module ApplicationHelper
  def to_tenth(num)
    num - (num % 10)
  end
end
