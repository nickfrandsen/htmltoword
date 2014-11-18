require 'rubygems'
require 'bundler/setup'
require 'htmltoword'

def compare_resulting_wordml_with_expected(html, resulting_wordml)
  source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
  xslt = Nokogiri::XSLT( File.read(Htmltoword::Document.default_xslt_template))
  result = xslt.transform(source)
  if compare_content_of_body?(resulting_wordml)
    result.at("//w:sectPr").remove
    result = result.at("//w:body")
  end
  result.xpath('//comment()').remove
  expect(remove_whitespace(result.to_s)).to eq(remove_whitespace(resulting_wordml))
end

def compare_content_of_body?(wordml)
  wordml !~ /<?xml version/
end

def remove_whitespace(wordml)
  wordml.gsub(/\s+/, " ")
end
