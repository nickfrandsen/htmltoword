require 'spec_helper'

describe "XSLT" do

  it "transforms an empty html doc into an empty docx doc" do
    html = '<html><head></head><body></body></html>'
    source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
    xslt = Nokogiri::XSLT( File.read(Htmltoword::Document::XSLT_TEMPLATE))
    result = xslt.transform(source).to_s

    result.gsub(/\s+/, " ").should == "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<w:document xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:mo=\"http://schemas.microsoft.com/office/mac/office/2008/main\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:mv=\"urn:schemas-microsoft-com:mac:vml\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:pkg=\"http://schemas.microsoft.com/office/2006/xmlPackage\" xmlns:str=\"http://exslt.org/common\" xmlns:fn=\"http://www.w3.org/2005/xpath-functions\" mc:Ignorable=\"w14 wp14\">\n  <w:body>\n    <w:sectPr>\n      <w:pgSz w:w=\"11906\" w:h=\"16838\"/>\n      <w:pgMar w:top=\"1440\" w:right=\"1440\" w:bottom=\"1440\" w:left=\"1440\" w:header=\"708\" w:footer=\"708\" w:gutter=\"0\"/>\n      <w:cols w:space=\"708\"/>\n      <w:docGrid w:linePitch=\"360\"/>\n    </w:sectPr>\n  </w:body>\n</w:document>\n".gsub(/\s+/, " ")
  end

end