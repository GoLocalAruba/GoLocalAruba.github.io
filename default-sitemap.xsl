<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
	version="2.0"
	xmlns:html="http://www.w3.org/TR/html40"
	xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<xsl:variable name="fileType">
			<xsl:choose>
				<xsl:when test="//channel">RSS</xsl:when>
				<xsl:when test="//sitemap:url">Sitemap</xsl:when>
				<xsl:otherwise>SitemapIndex</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>
					<xsl:choose>
						<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">Sitemap</xsl:when>
						<xsl:otherwise>Sitemap Index</xsl:otherwise>
					</xsl:choose>
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<style type="text/css">
	body {
		margin: 0;
		font-family: Helvetica, Arial, sans-serif;
		font-size: 68.5%;
	}
	#content-head {
		background-color: #141B38;
		padding: 20px 40px;
	}
	#content-head h1,
	#content-head p,
	#content-head a {
		color: #fff;
		font-size: 1.2em;
	}
	#content-head h1 {
		font-size: 2em;
	}
	table {
		margin: 20px 40px;
		border: none;
		border-collapse: collapse;
		font-size: 1em;
		width: 75%;
	}
	th {
		border-bottom: 1px solid #ccc;
		text-align: left;
		padding: 15px 5px;
		font-size: 14px;
	}
	td {
		padding: 10px 5px;
		border-left: 3px solid #fff;
	}
	tr.stripe {
		background-color: #f7f7f7;
	}
	table td a:not(.localized) {
		display: block;
	}
	table td a img {
		max-height: 30px;
		margin: 6px 3px;
	}
	.empty-sitemap {
		margin: 20px 40px;
		width: 75%;
	}
	.empty-sitemap__title {
		font-size: 18px;
		line-height: 125%;
		margin: 12px 0;
	}
	.empty-sitemap svg {
		width: 140px;
		height: 140px;
	}
	.empty-sitemap__buttons {
		margin-bottom: 30px;
	}
	.empty-sitemap__buttons .button {
		margin-right: 5px;
	}
	.breadcrumb {
		margin: 20px 40px;
		width: 75%;

		display: flex;
		align-items: center;
		font-size: 12px;
		font-weight: 600;
	}
	.breadcrumb a {
		color: #141B38;
		text-decoration: none;
	}
	.breadcrumb svg {
		margin: 0 10px;
	}
	@media (max-width: 1023px) {
		.breadcrumb svg:not(.back),
		.breadcrumb a:not(:last-of-type),
		.breadcrumb span {
			display: none;
		}
		.breadcrumb a:last-of-type::before {
			content: 'Back'
		}
	}
	@media (min-width: 1024px) {
		.breadcrumb {
			font-size: 14px;
		}
		.breadcrumb a {
			font-weight: 400;
		}
		.breadcrumb svg.back {
			display: none;
		}
	}
</style>
			</head>
			<body>
				<xsl:variable name="amountOfURLs">
					<xsl:choose>
						<xsl:when test="$fileType='RSS'">
							<xsl:value-of select="count(//channel/item)"></xsl:value-of>
						</xsl:when>
						<xsl:when test="$fileType='Sitemap'">
							<xsl:value-of select="count(sitemap:urlset/sitemap:url)"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="Header">
					<xsl:with-param name="title">Sitemap</xsl:with-param>
					<xsl:with-param name="amountOfURLs" select="$amountOfURLs"/>
					<xsl:with-param name="fileType" select="$fileType"/>
				</xsl:call-template>

				<div class="content">
					<div class="container">
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 0"><xsl:call-template name="emptySitemap"/></xsl:when>
							<xsl:when test="$fileType='Sitemap'"><xsl:call-template name="sitemapTable"/></xsl:when>
							<xsl:when test="$fileType='RSS'"><xsl:call-template name="sitemapRSS"/></xsl:when>
							<xsl:otherwise><xsl:call-template name="siteindexTable"/></xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="siteindexTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="./index.html"><span>Home</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Sitemap Index</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
				<tr>
					<th class="left">
						URL					</th>
					<th>URL Count</th>
					<th>
						Last Updated					</th>
				</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:sitemapindex/sitemap:sitemap">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="sitemap:loc" />
								</xsl:attribute>
								<xsl:value-of select="sitemap:loc"/>
							</a>
						</td>
						<td>
													</td>
						<td class="datetime">
													</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapRSS">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="./index.html"><span>Home</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">URL</th>
						<th>
							Publication Date						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:for-each select="//channel/item">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="link" />
								</xsl:attribute>
								<xsl:value-of select="link"/>
							</a>
						</td>
						<td class="datetime">
													</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="./index.html"><span>Home</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<a href="./sitemap.xml"><span>Sitemap Index</span></a>
						<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">
							URL						</th>
													<th>
								Images							</th>
												<th>
							Change Frequency						</th>
						<th>
							Priority						</th>
						<th>
							Last Updated						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:urlset/sitemap:url">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>

						<td class="left">
							<xsl:variable name="itemURL">
								<xsl:value-of select="sitemap:loc"/>
							</xsl:variable>

							<xsl:choose>
								<xsl:when test="count(./*[@rel='alternate']) > 0">
									<xsl:for-each select="./*[@rel='alternate']">
										<xsl:if test="position() = last()">
											<a href="{current()/@href}" class="localized">
												<xsl:value-of select="@href"/>
											</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<a href="{$itemURL}">
										<xsl:value-of select="sitemap:loc"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:for-each select="./*[@rel='alternate']">
								<br />
								<xsl:if test="position() != last()">
									<a href="{current()/@href}" class="localized">
										<xsl:value-of select="@href"/>
									</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
								</xsl:if>
							</xsl:for-each>
						</td>
												<td>
							<div class="item-count">
								<xsl:value-of select="count(image:image)"/>
							</div>
						</td>
												<td>
							<xsl:value-of select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/>
						</td>
						<td>
							<xsl:if test="string(number(sitemap:priority))!='NaN'">
								<xsl:call-template name="formatPriority">
									<xsl:with-param name="priority" select="sitemap:priority"/>
								</xsl:call-template>
							</xsl:if>
						</td>
						<td class="datetime">
													</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
			</xsl:template>

	<xsl:template name="Header">
	<xsl:param name="title"/>
	<xsl:param name="amountOfURLs"/>
	<xsl:param name="fileType"/>

	<div id="content-head">
		<h1><xsl:value-of select="$title"/></h1>
		<xsl:choose>
			<xsl:when test="$fileType='RSS'">
				<p>Generated by <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=xml-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, this is an RSS Sitemap, meant to be consumed by search engines like Google or Bing.</p>
				<p>
					You can find more information about RSS Sitemaps at <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>Generated by <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=xml-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, this is an XML Sitemap, meant to be consumed by search engines like Google or Bing.</p>
				<p>
					You can find more information about XML Sitemaps at <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$amountOfURLs &gt; 0">
			<p>
				<xsl:choose>
					<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">
						This sitemap contains						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								URL							</xsl:when>
							<xsl:otherwise>
								URLs							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						This sitemap index contains						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								sitemap							</xsl:when>
							<xsl:otherwise>
								sitemaps							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				and was generated on February 25, 2025 at 12:19 am			</p>
		</xsl:if>
	</div>
</xsl:template>
	<xsl:template name="formatPriority">
	<xsl:param name="priority"/>

	<xsl:variable name="priorityLevel">
		<xsl:choose>
			<xsl:when test="$priority &lt;= 0.5">low</xsl:when>
			<xsl:when test="$priority &gt;= 0.6 and $priority &lt;= 0.8">medium</xsl:when>
			<xsl:when test="$priority &gt;= 0.9">high</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="priorityLabel">
		<xsl:choose>
			<xsl:when test="$priorityLevel = 'low'">Low</xsl:when>
			<xsl:when test="$priorityLevel = 'medium'">Medium</xsl:when>
			<xsl:when test="$priorityLevel = 'high'">High</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div>
		<xsl:attribute name="class">
			<xsl:value-of select="concat('priority priority--', $priorityLevel)" />
		</xsl:attribute>
		<xsl:value-of select="$priorityLabel" />
	</div>
</xsl:template>
	<xsl:template name="emptySitemap">
	<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="./index.html"><span>Home</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Sitemap Index</span>
				</div>	<div class="empty-sitemap">
		<h2 class="empty-sitemap__title">
			Whoops!			<br />
			There are no posts here		</h2>
		<div class="empty-sitemap__buttons">
			<a href="./index.html" class="button">Back to Homepage</a>
					</div>

			</div>
	<style>
		.hand-magnifier{
			animation: hand-magnifier .8s infinite ease-in-out;
			transform-origin: center 90%;
			transform-box: fill-box;
		}
		@keyframes hand-magnifier {
			0% {
				transform: rotate(0deg);
			}
			50% {
				transform: rotate(-12deg);
			}
			100% {
				transform: rotate(0deg);
			}
		}
	</style>
</xsl:template>
</xsl:stylesheet>
