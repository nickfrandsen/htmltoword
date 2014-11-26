require 'spec_helper'

describe "XSLT for Headings" do

  it "transforms heading tags in the body" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
    <h3>Heading 3</h3>
    <h4>Heading 4</h4>
    <h5>Heading 5</h5>
    <h6>Heading 6</h6>
  </body>
  </html>
    EOL
    expected_wordml = <<-EOL
  <w:body>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading1"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 1</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading2"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 2</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading3"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 3</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading4"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 4</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading5"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 5</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading6"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 6</w:t>
      </w:r>
    </w:p>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms heading tags in a div" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <div>
      <h1>Heading 1</h1>
      <h2>Heading 2</h2>
      <h3>Heading 3</h3>
      <h4>Heading 4</h4>
      <h5>Heading 5</h5>
      <h6>Heading 6</h6>
    </div>
  </body>
  </html>
    EOL
    expected_wordml = <<-EOL
  <w:body>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading1"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 1</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading2"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 2</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading3"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 3</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading4"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 4</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading5"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 5</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading6"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">Heading 6</w:t>
      </w:r>
    </w:p>
  </w:body>
    EOL

    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms heading tags in a table" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <table>
      <tr>
        <td><h1>Heading 1</h1> normal text</td>
        <td><h2>Heading 2</h2> normal text</td>
      </tr>
      <tr>
        <td><h3>Heading 3</h3> normal text</td>
        <td><h4>Heading 4</h4> normal text</td>
      </tr>
      <tr>
        <td><h5>Heading 5</h5> normal text</td>
        <td><h6>Heading 6</h6> normal text</td>
      </tr>
    </table>
  </body>
  </html>
    EOL
    expected_wordml = <<-EOL
  <w:body>
    <w:tbl>
      <w:tblPr>
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:left w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:bottom w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:right w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:insideH w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:insideV w:val="none" w:sz="0" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading1"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 1</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading2"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 2</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 3</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading4"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 4</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading5"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 5</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading6"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Heading 6</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> normal text</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transform tables with empty headers" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <table>
      <thead>
      <tr>
        <th/>
        <th>Header 2</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td><strong>Cell 1,1</strong></td>
        <td>Cell 1,2</td>
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
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:left w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:bottom w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:right w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:insideH w:val="none" w:sz="0" w:space="0" w:color="auto"/>
          <w:insideV w:val="none" w:sz="0" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve"/>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Header 2</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Cell 1,1</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Cell 1,2</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms tables without <tr> tag on <thead>" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <table border="1">
      <thead>
        <th>Header 1</th>
        <th/>
      </thead>
      <tbody>
      <tr>
        <td><strong>Cell 1,1</strong></td>
        <td>Cell 1,2</td>
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
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Header 1</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve"/>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Cell 1,1</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Cell 1,2</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms tables with border attribute and table-bordered class" do
    html = <<-EOL
<!DOCTYPE html>
<html>
<head></head>
<body>
<table border="1">
  <tbody>
    <tr>
      <td>Hello</td>
      <td>World</td>
    </tr>
  </tbody>
</table>
Using table-bordered class
<table class="table-bordered">
  <tbody>
    <tr>
      <td>Hello world</td>
      <td>Part 2</td>
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
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Hello</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">World</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p>
      <w:r>
        <w:t xml:space="preserve"> Using table-bordered class </w:t>
      </w:r>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Hello world</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Part 2</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms nested elements inside table cells" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <table class="table-bordered">
      <tbody>
        <tr>
          <td>Pre H1 <h1>This is a H1</h1> Post H1</td>
          <td>Text <p>A paragraph with <strong>Strong</strong> text</p> More text</td>
        </tr>
        <tr>
          <td><div>Some content <em>inside</em> a <strong>div</strong></div></td>
          <td/>
        </tr>
        <tr>
          <td>Something <p> Inside a p<strong> strong <em> and strong em </em></strong></p></td>
          <td><div>Text inside div</div></td>
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
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLook w:val="0600" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="1" w:noVBand="1"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2310"/>
        <w:gridCol w:w="2310"/>
      </w:tblGrid>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Pre H1 </w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading1"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">This is a H1</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> Post H1</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Text </w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">A paragraph with </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Strong</w:t>
            </w:r>
            <w:r>
              <w:t xml:space="preserve"> text</w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> More text</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Some content </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:i/>
              </w:rPr>
              <w:t xml:space="preserve">inside</w:t>
            </w:r>
            <w:r>
              <w:t xml:space="preserve"> a </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">div</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p/>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Something </w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t xml:space="preserve"> Inside a p</w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve"> strong </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:i/>
              </w:rPr>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve"> and strong em </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:t xml:space="preserve">Text inside div</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end
end
