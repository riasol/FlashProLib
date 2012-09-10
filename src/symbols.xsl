<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="no" method="text" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:template match="/swf/Header/tags/SymbolClass/symbols">symbols=<xsl:apply-templates></xsl:apply-templates>
</xsl:template>
<xsl:template match="/swf/Header/tags/SymbolClass/symbols/Symbol">
<xsl:value-of select="@objectID"/>,</xsl:template>
<xsl:template match="text()"></xsl:template>
</xsl:stylesheet>