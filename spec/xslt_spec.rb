require 'spec_helper'

describe "XSLT" do

  it "transforms an empty html doc into an empty docx doc" do
    html = '<html><head></head><body></body></html>'
    compare_resulting_wordml_with_expected(html, "<?xml version=\"1.0\" encoding=\"utf-8\"?> <w:document xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" xmlns:mo=\"http://schemas.microsoft.com/office/mac/office/2008/main\" xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" xmlns:mv=\"urn:schemas-microsoft-com:mac:vml\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:pkg=\"http://schemas.microsoft.com/office/2006/xmlPackage\" xmlns:str=\"http://exslt.org/common\" xmlns:fn=\"http://www.w3.org/2005/xpath-functions\" mc:Ignorable=\"w14 wp14\"> <w:body> <w:sectPr> <w:pgSz w:w=\"11906\" w:h=\"16838\"/> <w:pgMar w:top=\"1440\" w:right=\"1440\" w:bottom=\"1440\" w:left=\"1440\" w:header=\"708\" w:footer=\"708\" w:gutter=\"0\"/> <w:cols w:space=\"708\"/> <w:docGrid w:linePitch=\"360\"/> </w:sectPr> </w:body> </w:document> ")
  end

  it "transforms a div into a docx block element." do
    html = '<html><head></head><body><div>Hello</div></body></html>'
    compare_resulting_wordml_with_expected(html, "<w:body> <w:p> <w:r> <w:t xml:space=\"preserve\">Hello</w:t> </w:r> </w:p> </w:body>")
  end

  context "transform a span" do

    it "into a docx block element if child of body." do
      html = '<html><head></head><body><span>Hello</span></body></html>'
      compare_resulting_wordml_with_expected(html, "<w:body> <w:p> <w:r> <w:t xml:space=\"preserve\">Hello</w:t> </w:r> </w:p> </w:body>")
    end

    it "into a docx inline element if not child of body." do
      html = '<html><head></head><body><div><span>Hello</span></div></body></html>'
      compare_resulting_wordml_with_expected(html, "<w:body> <w:p> <w:r> <w:t xml:space=\"preserve\">Hello</w:t> </w:r> </w:p> </w:body>")
    end

  end

  it "transforms a p into a docx block element." do
    html = '<html><head></head><body><p>Hello</p></body></html>'
    compare_resulting_wordml_with_expected(html, "<w:body> <w:p> <w:r> <w:t xml:space=\"preserve\">Hello</w:t> </w:r> </w:p> </w:body>")
  end

  it "Should strip out details tags" do
    html = '<html><head></head><body><div><p>Hello</p><details><summary>Title</summary><p>Second</p><details></div></body></html>'
    compare_resulting_wordml_with_expected(html, "<w:body> <w:p> <w:r> <w:t xml:space=\"preserve\">Hello</w:t> </w:r> </w:p> </w:body>")
  end

  it "transforms a table into a tbl element" do
    html = <<-EOL
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>A nested table</title>
</head>
<body>
  <table>
    <tbody>
      <tr>
        <td>
          Hello
        </td>
      </tr>
    </tbody>
  </table>
</body>
</html>
    EOL
    expected_wordml = <<-EOL
<w:body>
  <w:tbl>
    <w:tblPr>
      <w:tblStyle w:val=\"TableGrid\"/>
      <w:tblW w:w=\"0\" w:type=\"auto\"/>
      <w:tblBorders>
        <w:top w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:left w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:bottom w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:right w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:insideH w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:insideV w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
      </w:tblBorders>
      <w:tblLook w:val=\"0600\" w:firstRow=\"0\" w:lastRow=\"0\" w:firstColumn=\"0\" w:lastColumn=\"0\" w:noHBand=\"1\" w:noVBand=\"1\"/>
    </w:tblPr>
    <w:tblGrid>
      <w:gridCol w:w=\"2310\"/>
      <w:gridCol w:w=\"2310\"/>
    </w:tblGrid>
    <w:tr>
      <w:tc>
        <w:p>
          <w:r>
            <w:t xml:space=\"preserve\">
              Hello
            </w:t>
          </w:r>
        </w:p>
      </w:tc>
    </w:tr>
  </w:tbl>
</w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "should transform a nested table" do
    html = <<-EOL
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>A nested table</title>
</head>
<body>
  <table>
    <tbody>
      <tr>
        <td>
          <table>
            <tbody>
              <tr>
                <td>Nested</td>
                <td>Table</td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
    </tbody>
  </table>
</body>
</html>
    EOL
    expected_wordml = <<-EOL
<w:body>
  <w:tbl>
    <w:tblPr>
      <w:tblStyle w:val=\"TableGrid\"/>
      <w:tblW w:w=\"0\" w:type=\"auto\"/>
      <w:tblBorders>
        <w:top w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:left w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:bottom w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:right w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:insideH w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
        <w:insideV w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
      </w:tblBorders>
      <w:tblLook w:val=\"0600\" w:firstRow=\"0\" w:lastRow=\"0\" w:firstColumn=\"0\" w:lastColumn=\"0\" w:noHBand=\"1\" w:noVBand=\"1\"/>
    </w:tblPr>
    <w:tblGrid>
      <w:gridCol w:w=\"2310\"/>
      <w:gridCol w:w=\"2310\"/>
    </w:tblGrid>
    <w:tr>
      <w:tc>
        <w:tbl>
          <w:tblPr>
            <w:tblStyle w:val=\"TableGrid\"/>
            <w:tblW w:w=\"0\" w:type=\"auto\"/>
            <w:tblBorders>
              <w:top w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
              <w:left w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
              <w:bottom w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
              <w:right w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
              <w:insideH w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
              <w:insideV w:val=\"none\" w:sz=\"0\" w:space=\"0\" w:color=\"auto\"/>
            </w:tblBorders>
            <w:tblLook w:val=\"0600\" w:firstRow=\"0\" w:lastRow=\"0\" w:firstColumn=\"0\" w:lastColumn=\"0\" w:noHBand=\"1\" w:noVBand=\"1\"/>
          </w:tblPr>
          <w:tblGrid>
            <w:gridCol w:w=\"2310\"/>
            <w:gridCol w:w=\"2310\"/>
          </w:tblGrid>
          <w:tr>
            <w:tc>
              <w:p>
                <w:r>
                  <w:t xml:space=\"preserve\">Nested</w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:p>
                <w:r>
                  <w:t xml:space=\"preserve\">Table</w:t>
                </w:r>
              </w:p>
            </w:tc>
          </w:tr>
        </w:tbl>
        <w:p/>
      </w:tc>
    </w:tr>
  </w:tbl>
</w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  protected

  def compare_resulting_wordml_with_expected(html, resulting_wordml)
    source = Nokogiri::HTML(html.gsub(/>\s+</, "><"))
    xslt = Nokogiri::XSLT( File.read(Htmltoword::Document::XSLT_TEMPLATE))
    result = xslt.transform(source)
    if compare_content_of_body?(resulting_wordml)
      result.at("//w:sectPr").remove
      result = result.at("//w:body")
    end
    expect(remove_comments_and_whitespace(result.to_s)).to eq(resulting_wordml.gsub(/\s+/, " "))
  end

  def compare_content_of_body?(wordml)
    wordml !~ /<?xml version/
  end

  def remove_comments_and_whitespace(wordml)
    wordml.gsub(/<!--([^*]|[\r\n])*-->/, "").gsub(/\s+/, " ")
  end
end
