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
                version="1.0"
                exclude-result-prefixes="java msxsl ext w o v WX aml w10">


  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="no" indent="yes" />
  <!-- doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" -->

  <!--

  <p class="Normal-P"> <span class="Normal-H">blagh blagh</span></p>
  <p class="Normal-P">&nbsp; blagh blagh <br /></p>

  should become

  <w:p>
      <w:r>
          <w:t></w:t>
      </w:r>
  </w:p>


   -->

  <xsl:template match="/ | html">
    <w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mo="http://schemas.microsoft.com/office/mac/office/2008/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:mv="urn:schemas-microsoft-com:mac:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
      <xsl:apply-templates select="//body" />
    </w:document>
  </xsl:template>

  <xsl:template match="body">
    <w:body>
      <xsl:apply-templates/>
    </w:body>
  </xsl:template>

  <xsl:template match="br">
    <w:p><w:t> </w:t></w:p>
  </xsl:template>

  <xsl:template match="p">
    <w:p>
      <xsl:apply-templates select="@*|node()"/>
    </w:p>
  </xsl:template>

  <xsl:template match="span">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="b">
    <w:r>
      <w:rPr>
        <w:b />
      </w:rPr>
      <xsl:apply-templates />
    </w:r>
  </xsl:template>

  <xsl:template match="i">
    <w:r>
      <w:rPr>
        <w:i />
      </w:rPr>
      <xsl:apply-templates />
    </w:r>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="name(..)='span'">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:when test="name(..)='p'">
        <w:r>
          <w:t>
            <xsl:value-of select="."/>
          </w:t>
        </w:r>
      </xsl:when>
      <xsl:when test="name(..)='b' or name(..)='i'">
          <w:t>
            <xsl:value-of select="."/>
          </w:t>
      </xsl:when>
      <xsl:otherwise>
        <!--<xsl:comment>What to do with text '<xsl:value-of select="."/>' in <xsl:value-of select="name(..)"/> element?</xsl:comment>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test="name(..)='span'">
        <w:rPr>
          <w:rStyle w:val="{.}"/>
        </w:rPr>
      </xsl:when>
      <xsl:when test="name(..)='p'">
        <w:pPr>
          <w:pStyle w:val="{.}"/>
        </w:pPr>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

