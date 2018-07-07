require 'attributed_object'

class ContentManager
  include AttributedObject::Strict

  attribute :app_name, :string
  attribute :link, :string
  attribute :change_count, :integer

  def initialize(app_name:, link:, change_count: 0)
    @app_name = app_name
    @link = link
    @change_count = change_count
  end

  def standard_text
    standard_text = ""

    if plural?(number: @change_count)
      standard_text = "On #{@app_name} there are #{@change_count} updated items. #{link}"
    else
      standard_text = "On #{@app_name} is #{@change_count} updated item. #{link}"
    end

    standard_text
  end

  private

  def plural?(number:)
    number < 1
  end
end