<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:v="urn:schemas-microsoft-com:vml"
                xmlns:WX="http://schemas.microsoft.com/office/word/2003/auxHint"
                xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
                xmlns:w10="urn:schemas-microsoft-com:office:word"
                xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:ext="http://www.xmllab.net/wordml2html/ext"
                xmlns:java="http://xml.apache.org/xalan/java"
                xmlns:str="http://exslt.org/common"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="1.0"
                exclude-result-prefixes="java msxsl ext w o v WX aml w10">


  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="no" indent="yes" />

  <xsl:template match="/ | html">
    <w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mo="http://schemas.microsoft.com/office/mac/office/2008/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:mv="urn:schemas-microsoft-com:mac:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
      <xsl:apply-templates select="//body"/>
    </w:document>
  </xsl:template>

  <xsl:template match="body">
    <w:body>
      <w:p>
        <xsl:apply-templates/>
      </w:p>
      <w:sectPr>
        <w:pgSz w:w="11906" w:h="16838"/>
        <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="708" w:footer="708" w:gutter="0"/>
        <w:cols w:space="708"/>
        <w:docGrid w:linePitch="360"/>
      </w:sectPr>
    </w:body>
  </xsl:template>

  <xsl:template match="br">
    <xsl:choose>
      <xsl:when test="name(..)='div' or name(..)='small'">
        <w:r><w:br/></w:r>
      </xsl:when>
      <xsl:when test="name(..)='td'">
      </xsl:when>
      <xsl:otherwise>
        <w:pPr><w:pStyle w:val="Afsnit"/></w:pPr><w:r><w:br/></w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="i">
    <w:r>
      <w:rPr>
        <w:i />
      </w:rPr>
      <xsl:apply-templates />
    </w:r>
  </xsl:template>

  <xsl:template match="b|strong">
    <w:r>
      <w:rPr>
        <w:b />
      </w:rPr>
      <xsl:apply-templates />
    </w:r>
  </xsl:template>

  <xsl:template match="font">
    <w:r>
      <xsl:apply-templates />
    </w:r>
  </xsl:template>

  <xsl:template match="div[@class='crumbNav']"/>
  <xsl:template match="small"/>

  <xsl:template match="div[contains(concat(' ', @class, ' '), ' -page-break ')]">
    <xsl:comment>Making PAGEBREAKS</xsl:comment>
    <w:r><w:br w:type="page" /></w:r>
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="div">
    <xsl:choose>
      <xsl:when test="name(..)='body'">
        <xsl:apply-templates select="node()"/>
      </xsl:when>
      <xsl:when test="./div">
        <xsl:apply-templates select="node()"/>
      </xsl:when>
      <xsl:otherwise>
        <w:r><w:br/></w:r>
          <xsl:apply-templates select="node()"/>
        <w:r><w:br/></w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ol|ul">
    <w:r><w:br/></w:r>
    <xsl:apply-templates/>
    <w:r><w:br/></w:r>
  </xsl:template>

  <xsl:template match="li">
    <w:r><w:t xml:space="preserve">   </w:t></w:r>
    <xsl:apply-templates/>

    <w:r><w:br/></w:r>
  </xsl:template>

  <xsl:template match="span[contains(concat(' ', @class, ' '), ' h ')]">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="./@data-style='pink'">magenta</xsl:when>
        <xsl:when test="./@data-style='blue'">cyan</xsl:when>
        <xsl:otherwise><xsl:value-of select="./@data-style"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <w:r>
      <w:rPr>
        <w:highlight w:val="{$color}"/>
      </w:rPr>
      <xsl:apply-templates/>
    </w:r>
  </xsl:template>

  <xsl:template match="span">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="table">
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
      <xsl:apply-templates select="tr"/>
    </w:tbl>
  </xsl:template>

  <xsl:template match="tr">
    <w:tr>
      <xsl:apply-templates select="td"/>
    </w:tr>
  </xsl:template>

  <xsl:template match="td">
    <w:tc>
      <xsl:apply-templates/>
    </w:tc>
  </xsl:template>

  <xsl:template match="a">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="h1">
    <w:r>
      <w:rPr>
        <w:rStyle w:val="h1"/>
      </w:rPr>
      <w:br/>
      <xsl:apply-templates />
      <w:br/>
    </w:r>
  </xsl:template>

  <xsl:template match="h2">
    <w:r>
      <w:rPr>
        <w:rStyle w:val="h2"/>
      </w:rPr>
      <w:br/>
      <xsl:apply-templates />
      <w:br/>
    </w:r>
  </xsl:template>

  <xsl:template match="h3">
    <w:r>
      <w:rPr>
        <w:rStyle w:val="h3"/>
      </w:rPr>
      <w:br/>
      <xsl:apply-templates />
      <w:br/>
    </w:r>
  </xsl:template>

  <xsl:template match="h4">
    <w:r>
      <w:rPr>
        <w:rStyle w:val="h4"/>
      </w:rPr>
      <w:br/>
      <xsl:apply-templates />
      <w:br/>
    </w:r>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="name(..)='i' or name(..)='b' or name(..)='strong' or name(..)='font' or name(..)='h1' or name(..)='h2' or name(..)='h3' or name(..)='h4'">
        <xsl:if test="string-length(.) > 0">
          <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
        </xsl:if>
      </xsl:when>
      <xsl:when test="name(..)='a' or name(..)='div' or name(..)='span' or name(..)='li' or name(..)='td' or name(..)='p'">
        <xsl:if test="string-length(.) > 0">
          <w:r>
            <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
          </w:r>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment>What to do with text '<xsl:value-of select="."/>' in <xsl:value-of select="name(..)"/> element?</xsl:comment>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  <!--Need to tokenize the value of the class and remove the useless ones.-->
  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test="name(..)='span'">
        <xsl:comment>Is this being used? 1</xsl:comment>
        <w:rPr>
          <w:rStyle w:val="{.}"/>
        </w:rPr>
      </xsl:when>
      <xsl:when test="name(..)='div'">
        <xsl:comment>Is this being used? 2</xsl:comment>
        <w:pPr>
          <w:pStyle w:val="{.}"/>
        </w:pPr>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

