require 'spec_helper'

describe "XSLT to align div, p and td tags" do

  it "transforms a p element with the correct alignment." do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <p style="text-align:center;width:100%"> p using text-aligned center</p>
    <p style="text-align:right;width:100%"> p using text-aligned right</p>
    <p style="text-align:left;width:100%"> p using text-aligned left</p>
    <p style="text-align:justify;width:100%">
      Praesent commodo leo et tincidunt tincidunt. Aliquam vestibulum vehicula accumsan. In suscipit nunc vitae facilisis mattis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin fringilla, odio in rhoncus tincidunt, mauris lectus gravida nibh, ac consectetur est arcu a turpis. Proin sodales tellus imperdiet, auctor ante sed, pulvinar nisl. Aenean ultricies elementum leo, in mattis dolor dapibus feugiat. Nunc scelerisque nec purus ac tempus. Praesent at velit ac ipsum hendrerit auctor. Nam dui nunc, ultrices quis aliquet in, pellentesque quis diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
    </p>
    <p class='center'><strong>p class center and strong</strong></p>
    <p class='right'><strong>p class right and strong</strong></p>
    <p class='left'><strong>p class left and strong</strong></p>
    <p class="justify">
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ornare sem at sapien accumsan, in pellentesque elit consectetur. Mauris quis dui a magna scelerisque ornare. Vivamus scelerisque sollicitudin ante, auctor dictum nunc iaculis sed. Nullam lobortis ligula odio, a dapibus augue malesuada eget. Nam ac justo nunc. Vestibulum tristique diam sit amet ornare maximus. Duis sit amet libero elit. Proin massa nunc, rutrum nec odio et, hendrerit egestas dui. Donec sit amet aliquam libero.
    </p>
    <p> Just a p </p>
  </body>
  </html>
    EOL
    expected_wordml = <<-EOL
  <w:body>
    <w:p>
      <w:pPr>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> p using text-aligned center</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="right"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> p using text-aligned right</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="left"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> p using text-aligned left</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="both"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">
    Praesent commodo leo et tincidunt tincidunt. Aliquam vestibulum vehicula accumsan. In suscipit nunc vitae facilisis mattis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin fringilla, odio in rhoncus tincidunt, mauris lectus gravida nibh, ac consectetur est arcu a turpis. Proin sodales tellus imperdiet, auctor ante sed, pulvinar nisl. Aenean ultricies elementum leo, in mattis dolor dapibus feugiat. Nunc scelerisque nec purus ac tempus. Praesent at velit ac ipsum hendrerit auctor. Nam dui nunc, ultrices quis aliquet in, pellentesque quis diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
  </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">p class center and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="right"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">p class right and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="left"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">p class left and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="both"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ornare sem at sapien accumsan, in pellentesque elit consectetur. Mauris quis dui a magna scelerisque ornare. Vivamus scelerisque sollicitudin ante, auctor dictum nunc iaculis sed. Nullam lobortis ligula odio, a dapibus augue malesuada eget. Nam ac justo nunc. Vestibulum tristique diam sit amet ornare maximus. Duis sit amet libero elit. Proin massa nunc, rutrum nec odio et, hendrerit egestas dui. Donec sit amet aliquam libero.
  </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t xml:space="preserve"> Just a p </w:t>
      </w:r>
    </w:p>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms a table having its cells properly aligned" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <table class="table table-bordered">
      <thead>
      <tr>
        <th>Left aligned text</th>
        <th>Right aligned text</th>
        <th>Center aligned text</th>
        <th>Justify aligned text</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td style="text-align: left;">To the left</td>
        <td style="text-align: right;">To the right</td>
        <td style="text-align: center;">Centered</td>
        <td style="text-align: justify;">Justified</td>
      </tr>
      <tr>
        <td class="left">To the left</td>
        <td class="right">To the right</td>
        <td class="center">Centered</td>
        <td class="justify">Justified</td>
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
              <w:t xml:space="preserve">Left aligned text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Right aligned text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Center aligned text</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t xml:space="preserve">Justify aligned text</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="left"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">To the left</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="right"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">To the right</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="center"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Centered</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="both"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Justified</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="left"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">To the left</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="right"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">To the right</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="center"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Centered</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:p>
            <w:pPr>
              <w:jc w:val="both"/>
            </w:pPr>
            <w:r>
              <w:t xml:space="preserve">Justified</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </w:body>
    EOL

    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms div element with the correct alignment" do
    html = <<-EOL
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <div style="text-align:center;width:100%"> div using text-aligned center</div>
    <div style="text-align:right;width:100%"> div using text-aligned right</div>
    <div style="text-align:left;width:100%"> div using text-aligned left</div>
    <div style="text-align:justify;width:100%">
      Praesent commodo leo et tincidunt tincidunt. Aliquam vestibulum vehicula accumsan. In suscipit nunc vitae facilisis mattis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin fringilla, odio in rhoncus tincidunt, mauris lectus gravida nibh, ac consectetur est arcu a turpis. Proin sodales tellus imperdiet, auctor ante sed, pulvinar nisl. Aenean ultricies elementum leo, in mattis dolor dapibus feugiat. Nunc scelerisque nec purus ac tempus. Praesent at velit ac ipsum hendrerit auctor. Nam dui nunc, ultrices quis aliquet in, pellentesque quis diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
    </div>
    <div class='center'><strong>div class center and strong</strong></div>
    <div class='right'><strong>div class right and strong</strong></div>
    <div class='left'><strong>div class left and strong</strong></div>
    <div class="justify">
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ornare sem at sapien accumsan, in pellentesque elit consectetur. Mauris quis dui a magna scelerisque ornare. Vivamus scelerisque sollicitudin ante, auctor dictum nunc iaculis sed. Nullam lobortis ligula odio, a dapibus augue malesuada eget. Nam ac justo nunc. Vestibulum tristique diam sit amet ornare maximus. Duis sit amet libero elit. Proin massa nunc, rutrum nec odio et, hendrerit egestas dui. Donec sit amet aliquam libero.
    </div>
    <div> Just a div </div>
  </body>
  </html>
    EOL
    expected_wordml = <<-EOL
  <w:body>
    <w:p>
      <w:pPr>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> div using text-aligned center</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="right"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> div using text-aligned right</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="left"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"> div using text-aligned left</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="both"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">
    Praesent commodo leo et tincidunt tincidunt. Aliquam vestibulum vehicula accumsan. In suscipit nunc vitae facilisis mattis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin fringilla, odio in rhoncus tincidunt, mauris lectus gravida nibh, ac consectetur est arcu a turpis. Proin sodales tellus imperdiet, auctor ante sed, pulvinar nisl. Aenean ultricies elementum leo, in mattis dolor dapibus feugiat. Nunc scelerisque nec purus ac tempus. Praesent at velit ac ipsum hendrerit auctor. Nam dui nunc, ultrices quis aliquet in, pellentesque quis diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
  </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">div class center and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="right"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">div class right and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="left"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t xml:space="preserve">div class left and strong</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:jc w:val="both"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ornare sem at sapien accumsan, in pellentesque elit consectetur. Mauris quis dui a magna scelerisque ornare. Vivamus scelerisque sollicitudin ante, auctor dictum nunc iaculis sed. Nullam lobortis ligula odio, a dapibus augue malesuada eget. Nam ac justo nunc. Vestibulum tristique diam sit amet ornare maximus. Duis sit amet libero elit. Proin massa nunc, rutrum nec odio et, hendrerit egestas dui. Donec sit amet aliquam libero.
  </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t xml:space="preserve"> Just a div </w:t>
      </w:r>
    </w:p>
  </w:body>
    EOL
    compare_resulting_wordml_with_expected(html, expected_wordml.strip)
  end

  it "transforms nested divs with proper alignment" do
    # TODO: Known bug, not implemented yet.
    # <div class=“center”> Something <div> else </div> </div> -> else won’t be centered.
  end
end
