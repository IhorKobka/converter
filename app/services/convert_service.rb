class ConvertService
  attr_reader :data, :keys

  def initialize(params)
    @data = [
      { "country": "US", "school": "Stanford", "class": "Grade 11", "student_counts": 10},
      { "country": "US", "school": "MIT", "class": "Grade 7", "student_counts": 12},

      { "country": "UK", "school": "Cambridge", "class": "Grade 11", "student_counts": 19 },
      { "country": "UK", "school": "Cambridge", "class": "Grade 12", "student_counts": 14 },
      { "country": "UK", "school": "Cambridge", "class": "Grade 12", "student_counts": 16 },

      { "country": "UA", "school": "KPI", "class": "Grade 7", "student_counts": 20 },
    ]
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
          obj[key] << values.map { |value| value.except(*keys) }
        else
          obj[key] ||= {}
        end
        obj = obj[key]
      end
    end
    object
  end
end
