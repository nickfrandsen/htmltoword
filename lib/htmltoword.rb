# encoding: UTF-8
require "htmltoword/version"
require "htmltoword/htmltoword_helper"
require "action_controller"
require "action_view"
require "nokogiri"
require "zip/zip"

module Htmltoword
  def self.root
    File.expand_path '../..', __FILE__
  end
  def self.templates_path
    File.join root, "templates"
  end

  class Document

    DOC_XML_FILE = "word/document.xml"
    BASIC_PATH = ::Htmltoword.root
    SAVING_REL_PATH = "public/tmp"
    BASIC_REL_URL = "/tmp"
    FILE_EXTENSION = ".docx"
    XSLT_TEMPLATE = File.join(BASIC_PATH, 'xslt', 'html_to_wordml.xslt')

    class << self
      include HtmltowordHelper

      def create content, file_name
        word_file = new(template_file, file_name)
        word_file.replace_file content
        word_file.save
        word_file.rel_url
      end

      def create_with_content template, file_name, content, set=nil
        word_file = new(template_file("#{template}#{FILE_EXTENSION}"), file_name)
        content = replace_values(content, set) if set
        word_file.replace_file content
        word_file.save
        word_file.rel_url
      end
    end

    def initialize(template_path, file_name)
      @file_name = "#{file_name}#{FILE_EXTENSION}"
      @replaceable_files = {}
      @template_zip = Zip::ZipFile.open(template_path)
    end

    def file_name
      @file_name
    end

    #
    # It creates missing folders if needed, creates a new zip/word file on the
    # specified location, copies all the files from the template word document
    # and replace the content of the ones to be replaced.
    #
    # path: Could be an absolute or relative path, by default it uses a
    #       relative path defined on <code>rel_path</code>
    #
    def save(path=rel_path)
      FileUtils.mkdir_p File.dirname(path)
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

    def replace_file html, file_name=DOC_XML_FILE
      source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
      xslt = Nokogiri::XSLT( File.read(XSLT_TEMPLATE) )
      source = xslt.transform( source ) unless (source/"/html").blank?
      @replaceable_files[file_name] = source.to_s
    end

    def rel_path
      File.join(SAVING_REL_PATH, file_name)
    end

    def rel_url
      File.join(BASIC_REL_URL, file_name)
    end

  end
end
