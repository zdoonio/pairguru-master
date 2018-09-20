class FameDecorator < Draper::Decorator
  delegate_all

  decorates_association :comments

end
