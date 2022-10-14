class CreateRecord
  attr_reader :error_messages

  def initialize(model, params)
    @params = params
    @model = model
    @error_messages = []
  end
  
  def save
    @record = @model.new(@params)
    
    return true if @record.save
    
    @error_messages = @record.errors.full_messages
    false
  end

  def method_missing(m)
    return @record if m == @model.to_s.underscore.to_sym

    raise NoMethodError.new("undefined method `#{m}' for NoMethodError:Class")
  end

  protected
  attr_reader :params, :record
end