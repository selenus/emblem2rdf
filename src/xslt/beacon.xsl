<xsl:transform version="2.0"
               xpath-default-namespace="http://uri.hab.de/ontology/emblem#"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:dct="http://purl.org/dc/terms/"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:skos="http://www.w3.org/2004/02/skos/core#"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <xsl:template match="text()"/>

  <xsl:template match="Emblem[@rdf:about]">
    <rdf:Description rdf:about="{@rdf:about}">
      <xsl:for-each select="skos:prefLabel">
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:value-of select="concat('Emblem ', .)"/>
        </xsl:copy>
      </xsl:for-each>
      <xsl:for-each select=".//skos:Concept">
        <xsl:for-each select="skos:notation[@rdf:datatype = 'http://uri.hab.de/ontology/diglib-types#Iconclass']">
          <dc:subject rdf:datatype="{@rdf:datatype}"><xsl:value-of select="."/></dc:subject>
          <dct:references rdf:resource="http://iconclass.org/{encode-for-uri(.)}"/>
        </xsl:for-each>
        <xsl:for-each select="skos:prefLabel">
          <dc:subject>
            <xsl:copy-of select="@xml:lang"/>
            <xsl:value-of select="."/>
          </dc:subject>
        </xsl:for-each>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>

</xsl:transform>
