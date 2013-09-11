module Htmltoword
  class Document

    DOC_XML_FILE = "word/document.xml"
    BASIC_PATH = ::Htmltoword.root
    FILE_EXTENSION = ".docx"
    XSLT_TEMPLATE = File.join(BASIC_PATH, 'xslt', 'html_to_wordml.xslt')

    class << self
      include HtmltowordHelper

      def create content, file_name
        word_file = new(template_file, file_name)
        word_file.replace_file content
        word_file.save
      end

      def create_with_content template, file_name, content, set=nil
        word_file = new(template_file("#{template}#{FILE_EXTENSION}"), file_name)
        content = replace_values(content, set) if set
        word_file.replace_file content
        word_file.save
      end
    end

    def initialize(template_path, file_name)
      @file_name = file_name
      @replaceable_files = {}
      @template_path = template_path
    end

    def file_name
      @file_name
    end

    #
    # It creates missing folders if needed, creates a new zip/word file on the
    # specified location, copies all the files from the template word document
    # and replace the content of the ones to be replaced.
    # It will create a tempfile and return it. The rails app using the gem
    # should decide what to do with it.
    #
    #
    def save
      Tempfile.open([file_name, FILE_EXTENSION], type: 'application/zip') do |output_file|
        Zip::File.open(@template_path) do |template_zip|
          Zip::OutputStream.open(output_file.path) do |out|
            template_zip.each do |entry|
              out.put_next_entry entry.name
              if @replaceable_files[entry.name]
                out.write(@replaceable_files[entry.name])
              else
                out.write(template_zip.read(entry.name))
              end
            end
          end
        end
        output_file
      end
    end

    def replace_file html, file_name=DOC_XML_FILE
      source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
      xslt = Nokogiri::XSLT( File.read(XSLT_TEMPLATE) )
      source = xslt.transform( source ) unless (source/"/html").blank?
      @replaceable_files[file_name] = source.to_s
    end

  end
end
