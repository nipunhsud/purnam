require 'ostruct'
class TemporaryRecord < OpenStruct
  def model_name
    OpenStruct.new param_key:
  end

  def to_key
    [ id ]
  end

  class << self
    def from_record(record, **attrs)
      raise ArgumentError unless record.is_a?(ApplicationRecord)

      new record.attributes.merge(param_key: record.model_name.param_key, **attrs)
    end
  end
end
