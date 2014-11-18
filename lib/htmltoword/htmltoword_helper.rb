module Htmltoword
  module HtmltowordHelper

    def template_file template_file_name=nil
      default_path = File.join(::Htmltoword.config.default_templates_path, 'default.docx')
      template_path = template_file_name.present? ? File.join(::Htmltoword.config.custom_templates_path, template_file_name) : ''
      File.exist?(template_path) ? template_path : default_path
    end

    def replace_values content, set
      doc = Nokogiri::HTML(content)
      set.each_pair do |key, value|
        fields = (doc/"//span[@data-id='#{key}']")
        fields.each do |f|
          date_format = f.attr("date-format") || "long"
          data_transform = f.attr("data-transform")
          if value.is_a? Hash
            view = ActionView::Base.new(ActionController::Base.view_paths, {})
            final_value = view.render 'partials/answer_table', answer: value
            fragment = doc.root.parse(final_value).first
            new_node = doc.root.add_child(fragment)
            f.parent.replace new_node
          elsif value.is_a? Time
            f.content = I18n.l(value.to_date, format: date_format.to_sym)
          elsif data_transform == 'capitalized'
            f.content = value.mb_chars.capitalize rescue value
          else
            f.content = value
          end
        end
      end
      doc.to_s
    end
  end
end
