class ConvertService
  attr_reader :data, :keys

  def initialize(params)
    @data = params[:data]
    @keys = params[:keys] || []
  end

  def call
    return data if keys.empty?

    convert_object
  end

  private

  def convert_object
    object = {}
    data.group_by { |d| d.fetch_values(*keys) }.each_with_object(object) do |(grouped_keys, values), obj|
      grouped_keys.each do |key|
        if key == grouped_keys.last
          obj[key] ||= []
          values.map { |value| obj[key] << value.except(*keys) }
        else
          obj[key] ||= {}
        end
        obj = obj[key]
      end
    end
    object
  end
end
