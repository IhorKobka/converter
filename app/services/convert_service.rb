class ConvertService
  attr_reader :data, :expected_keys, :skipped_keys

  def initialize(params)
    @data =params[:data]
    @expected_keys = [:country, :school, :class, :student_counts]
    @skipped_keys = params[:skipped_keys] || []
  end

  def call
    keys = expected_keys - skipped_keys
    object = keys.length > 1 ? {} : []
    data.each_with_object(object) { |row, obj| modify_object(keys, row, obj) }
  end

  private

  def modify_object(keys, row, object)
    keys.each do |key|
      value = row[key]
      if key == keys.last
        object << { key => value }
      else
        object[value] ||= key == keys[-2] ? [] : {}
        object = object[value]
      end
    end
  end
end
