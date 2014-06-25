#@abstract
class BaseFormObject
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  def save
    if valid?
      persist!

      return true
    end

    return false
  end

  # @abstract
  #
  # @return [void]
  protected def persist!
    raise "#{__method__} must be overridden"
  end
end
