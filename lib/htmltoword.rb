# encoding: UTF-8
require "htmltoword/version"
require "action_controller"
require "action_view"
require "nokogiri"
require "zip/zip"

module Htmltoword
  def self.root
    File.expand_path '../..', __FILE__
  end

  class Document
    DOC_XML_FILE = "word/document.xml"
    BASIC_PATH = ::Htmltoword.root
    TEMPLATES_PATH = File.join BASIC_PATH, "templates"
    REL_PATH = "/tmp"
    FILE_EXTENSION = ".docx"
    XSLT_TEMPLATE = File.join(BASIC_PATH, 'xslt', 'html_to_wordml.xslt')

    def initialize(path)
      @replaceable_files = {}
      @template_zip = Zip::ZipFile.open(path)
    end

    def save_to(path)
      Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |out|
        @template_zip.each do |entry|
          out.get_output_stream(entry.name) do |o|
            if @replaceable_files[entry.name]
              o.write(@replaceable_files[entry.name])
            else
              o.write(@template_zip.read(entry.name))
            end
          end
        end
      end
      @template_zip.close
    end

    def replace_body content
      xml = @template_zip.read(DOC_XML_FILE).force_encoding("UTF-8")
      content.gsub!("\n", "")
      xml.gsub!(/<w:body>.*<\/w:body>/, "<w:body>#{content.gsub("\n", "")}</w:body>")
      @replaceable_files[DOC_XML_FILE] = xml
    end

    def replace_file html, file_name=DOC_XML_FILE
      source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
      xslt = Nokogiri::XSLT( File.read(XSLT_TEMPLATE) )
      source = xslt.transform( source ) unless (source/"/html").blank?
      @replaceable_files[file_name] = source.to_s
    end

    def self.template_file template
      default_path = File.join(TEMPLATES_PATH, "template#{FILE_EXTENSION}")
      template_path = File.join(TEMPLATES_PATH, "#{template}#{FILE_EXTENSION}")
      File.exist?(template_path) ? template_path : default_path
    end

    def self.create content, file_name
      word_file = new(template_file("overview"))
      word_file.replace_file content
      relative_path = File.join REL_PATH, "#{file_name}#{FILE_EXTENSION}"
      word_file.save_to File.join("public", relative_path)
      relative_path
    end

    def self.create_with_content template, file_name, content, set=nil
      word_file = new(template_file(template))
      content = replace_values(content, set) if set
      word_file.replace_file content
      relative_path = File.join REL_PATH, "#{file_name}#{FILE_EXTENSION}"
      word_file.save_to File.join("public", relative_path)
      relative_path
    end

    private
    def self.replace_values content, set
      doc = Nokogiri::HTML(content)
      set.each_pair do |key, value|
        fields = (doc/"//span[@data-id='#{key}']")
        fields.each do |f|
          date_format = f.attr("date-format") || "long"
          data_transform = f.attr("data-transform")
          if value.is_a? Hash
            view = ActionView::Base.new(ActionController::Base.view_paths, {})
            final_value = view.render "partials/answer_table", answer: value
            fragment = doc.root.parse(final_value).first
            new_node = doc.root.add_child(fragment)
            f.parent.replace new_node
          elsif value.is_a? Time
            f.content = I18n.l(value.to_date, format: date_format.to_sym)
          elsif data_transform == "capitalized"
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
