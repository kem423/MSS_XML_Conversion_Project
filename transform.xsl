<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" standalone="yes" indent="no"/>



<xsl:template match="/">Role Information
<xsl:for-each select="/article/front/article-meta/contrib-group/contrib">
<xsl:if test="(role/@content-type) and (count(role) > 1)">
<xsl:value-of select="name/given-names"/>
<xsl:text disable-output-escaping="yes"> </xsl:text>
<xsl:value-of select="name/surname"/>
<xsl:text disable-output-escaping="yes">: </xsl:text>
<xsl:for-each select="role[position() > 1]">
<xsl:value-of select="@content-type"/>
<xsl:if test="position() != last()">
<xsl:text>; </xsl:text>
</xsl:if>
<xsl:if test="position() = last()">
<xsl:text>. </xsl:text>
</xsl:if>
</xsl:for-each>
</xsl:if>
</xsl:for-each>

Funding Information
<xsl:for-each select="/article/front/article-meta/funding-group/award-group"> <!-- find all awards -->
<xsl:value-of select="principal-award-recipient"/> <!-- find the names of all recipients -->
<xsl:text disable-output-escaping="yes">, </xsl:text> <!-- comma seperator always -->
<xsl:for-each select="funding-source"> <!-- find the name of the instiution -->
<xsl:value-of select="text()"/> <!-- use text() to avoid picking up the <named-content> element -->
<xsl:text disable-output-escaping="yes"> </xsl:text> 
<xsl:if test="named-content"> <!-- if there is a funder-id find it and wrap it in '()'s -->
<xsl:text disable-output-escaping="yes">(</xsl:text><xsl:value-of select="named-content"/><xsl:text disable-output-escaping="yes">)</xsl:text>
</xsl:if> 
</xsl:for-each>

<xsl:if test="award-id"> <!-- if there is an award-id find it and add "Award ID:" text -->
<xsl:text disable-output-escaping="yes">, Award ID: </xsl:text>
</xsl:if>
<xsl:value-of select="award-id"/> <xsl:if test="position() != last()">
<xsl:text>. </xsl:text>
</xsl:if>
<xsl:if test="position() = last()">
<xsl:text>.</xsl:text>
</xsl:if> </xsl:for-each>

<!-- Get the running head and title -->
<xsl:for-each select="/article/front/article-meta/title-group">
<xsl:if test="alt-title/@alt-title-type='running-head'"> <!-- Check that the alt-title element actually holds the running head -->

Running head: <xsl:value-of select="alt-title"/>
</xsl:if>

Article Title: <xsl:value-of select="article-title"/> <!-- get the main title -->
</xsl:for-each>

<!-- Get the article-type -->
<xsl:for-each select="/article/front/article-meta/article-categories/subj-group">
<xsl:if test="@subj-group-type='Article Type'">

Article Type: <xsl:value-of select="subject"/>
</xsl:if>
</xsl:for-each>


<!-- Get Authors and affiliations -->
<xsl:for-each select="/article/front/article-meta/contrib-group/contrib"> 
    

    
<xsl:text>&#xa;</xsl:text>
    
<xsl:if test="(./@contrib-type='author') or (./@contrib-type='editor')"> 
<xsl:text>&#xa;</xsl:text>

<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="name/given-names"/>  <!-- Get the author names -->
<xsl:text disable-output-escaping="yes"> </xsl:text>
    <xsl:value-of select="name/surname"/> <xsl:text disable-output-escaping="yes"> (</xsl:text> <xsl:value-of select="./@contrib-type"/><xsl:text disable-output-escaping="yes">)</xsl:text>
    
    <xsl:text>&#xa;</xsl:text>
    <xsl:value-of select="email"/>  <!-- Get the author email -->    
<xsl:if test="xref/@ref-type='aff'"> <!-- Get the affiliation number -->
<xsl:variable name="affID" select="xref/@rid"/>
<xsl:for-each select="/article/front/article-meta/contrib-group/aff">
<xsl:if test="@id=$affID">

<xsl:choose>
<xsl:when test="./institution-wrap">
<xsl:for-each select="./institution-wrap/institution">
    <xsl:if test="(position() = '1') and (. != ',')"> <!-- If we are in the first <institution> element  just grab the text because know there is no attribute -->
Institution: <xsl:value-of select="."/> <!-- output instiution --> 
</xsl:if>
    <xsl:if test="(position() != '1') and (./@* = 'dept') and (. != ',')"> <!-- If there's another <institution> element check to see if it's a department. If it is, ouput it.  -->
Department: <xsl:value-of select="."/>
</xsl:if>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:for-each select="institution">
    <xsl:if test="(position() = '1') and (. != ',')"> <!-- If we are in the first <institution> element  just grab the text because know there is no attribute -->
Institution: <xsl:value-of select="."/> <!-- output instiution --> 
</xsl:if>
    <xsl:if test="(position() != '1') and (./@* = 'dept') and (. != ',')"> <!-- If there's another <institution> element check to see if it's a department. If it is, ouput it.  -->
Department: <xsl:value-of select="."/>
</xsl:if>
</xsl:for-each>
</xsl:otherwise>
</xsl:choose>


<!--<xsl:if test="./institution-wrap">
<xsl:for-each select="./institution-wrap/institution">
<xsl:if test="position() = '1'"> <!-\- If we are in the first <institution> element  just grab the text because know there is no attribute -\->
Institution: <xsl:value-of select="."/> <!-\- output instiution -\-> 
</xsl:if>
<xsl:if test="(position() != '1') and (./@* = 'dept')"> <!-\- If there's another <institution> element check to see if it's a department. If it is, ouput it.  -\->
Department: <xsl:value-of select="."/>
</xsl:if>
</xsl:for-each>
</xsl:if>

<xsl:for-each select="institution">
<xsl:if test="position() = '1'"> <!-\- If we are in the first <institution> element  just grab the text because know there is no attribute -\->
Institution: <xsl:value-of select="."/> <!-\- output instiution -\-> 
</xsl:if>
<xsl:if test="(position() != '1') and (./@* = 'dept')"> <!-\- If there's another <institution> element check to see if it's a department. If it is, ouput it.  -\->
Department: <xsl:value-of select="."/>
</xsl:if>
</xsl:for-each>-->
</xsl:if>
</xsl:for-each>
</xsl:if>
    
<xsl:if test="(contrib-id/@contrib-id-type='orcid')">
Orcid: <xsl:value-of select="contrib-id"/>  <!--  Get the ORCID -->  
<xsl:text>&#xa;</xsl:text>
</xsl:if>  
</xsl:if>
</xsl:for-each>
    
<!-- Get Handling editor -->

<xsl:for-each select="/article/front/article-meta/contrib-group/contrib"> 
<xsl:if test="./role = 'Editor'"> 
<xsl:text>&#xa;</xsl:text>
Handling Editor: <xsl:value-of select="name/given-names"/> <xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="name/surname"/>
</xsl:if>

<xsl:if test="./@corresp='yes'"> 
<xsl:text>&#xa;</xsl:text>
Corresponding Author: <xsl:value-of select="name/given-names"/> <xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="name/surname"/><xsl:text disable-output-escaping="yes"> (</xsl:text><xsl:value-of select="email"/><xsl:text disable-output-escaping="yes">)</xsl:text>
</xsl:if>
</xsl:for-each>
    

    <!-- Get the received and accepted date -->
<xsl:text>&#xa;</xsl:text>
<xsl:for-each select="/article/front/article-meta/history/date">
    <xsl:if test="@date-type='received' or @date-type='accepted'">
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="@date-type"/>: <xsl:value-of select="month"/>-<xsl:value-of select="day"/>-<xsl:value-of select="year"/>
</xsl:if>
</xsl:for-each>


<!-- Get the DAS -->
<xsl:text>&#xa;</xsl:text>
<xsl:for-each select="/article/front/article-meta/custom-meta-group/custom-meta">
<xsl:if test="./meta-name = 'Data availability statement'"> 
<xsl:text>&#xa;</xsl:text>
Data availability statement: <xsl:value-of select="./meta-value"/>
<xsl:value-of select="meta-name"/>
</xsl:if>
    
<xsl:if test="./meta-name = 'Please add repository name and URL/DOI'"> 
<xsl:text>&#xa;</xsl:text>
Repository name and URL/DOI: <xsl:value-of select="./meta-value"/>
<xsl:value-of select="meta-name"/>
</xsl:if>
</xsl:for-each>
    
</xsl:template>
</xsl:stylesheet>
