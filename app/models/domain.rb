class Domain
  include Mongoid::Document

  field :domain, type: String
  field :manual_class, type: Hash 
  field :locked_classes, type: Boolean

  def add_manual_class(new_manual_class)
    return if self.locked_classes
    
    self.manual_class ||= {:count => 0}
    self.manual_class[:count] += 1

    new_manual_class.keys.reject do |key|
      key == :count
    end.each do |key|
      self.manual_class[key] = ((self.manual_class[key] or 0.0) *
                                (self.manual_class[:count] - 1.0) +
                                (if new_manual_class[key] then 1.0 else 0.0 end)) /
                               self.manual_class[:count]
    end
  end

  def reset_manual_class
    self.manual_class = {:count => 0}
  end

  def toggle_lock
    self.locked_classes = (not self.locked_classes)
  end
end
