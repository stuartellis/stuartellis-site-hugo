+++
Title = "Optimizing Websites for Google Search"
Slug = "google-search-optimizing"
Date = "2019-04-04T21:34:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["google", "web"]
Type = "article"

+++

Notes summarizing [Google](https://www.google.com/) recommendations for Web developers.

<!--more-->

# Overview

In the U.S. and many other regions, Google is the dominant search provider. [Moz](https://www.moz.com) claim that in 2018, 62.6% of searches in the U.S. are through Google, a further 22.6% are Google Images, and 4.3% are on YouTube. These Google properties are the top three search providers in the U.S. region. 

In addition, voice search is now a growing trend. Google are a leading provider of voice search services through Android phones, and other devices. The answers and results that Google voice search systems provide are based on the main search engine.

Today, about half of searches now result in no further clicks. This is partly because of the information that Google now shows directly on the results page. In these cases, Google is the last page that the user visits, but most of the content has been retrieved from third-party Websites by Google systems.

> This information is from the presentation by Sarah Bird, [the SEO trends for 2019 you need to know about](https://www.youtube.com/watch?v=-8MU_cIhL0g).

# How Google Indexing Works

The system is collectively known as *Googlebot*, but has several components:

- The scheduling sends URLs to crawlers 
- *Crawlers* follow URLs and get content
- *Renderers* process the content, running it as a Web browser does
- *Indexers* extract information from the rendered content

Googlebot performs a crawl and an initial index, then renders the pages later (perhaps days later).

JavaScript pages must be rendered before they can be go to a second indexing, and the contained URLs are crawled in turn. Rendering of JS-powered pages is deferred until resources are available to process that content. This means that server-generated HTML is indexed much more quickly, because there is no waiting for a render. 

# Recommendations on Architecture

## Principles

* *Discoverability*: Help Google find the content
* *Evaluable*: Help Google understand the content
* *Speed* is a ranking factor

## Page Design and Rendering

Pages that are served to Googlebot crawlers should be designed with the crawler in mind. Modern JavaScript frameworks do not prevent Google indexing, but you need to avoid practices that make the indexing process less reliable. 

Search renderers use Chrome 41 (so ES5 JavaScript, *not* ES2015), and default to rendering as if for mobile.

The indexer avoid activating JavaScript events. To ensure that the indexer notices links on your pages, use _a href_ for links, rather than just JS _.onclick()_ event handlers.

For images, either use _img_ tags, or list the images in JSON-LD markup for the page. Googlebot will not see lazy loaded images. References to images in CSS are not followed.

If you have a large or rapidly changing site that relies on JavaScript, Google suggest that you add [dynamic rendering](https://developers.google.com/search/docs/guides/dynamic-rendering), which means detecting Googlebot and serving fully rendered pages to it. They also recommend that you transition to _hybrid rendering_.

Your code can spot "Googlebot" by looking for that string in the User Agent: it may be claiming to be either desktop or mobile.

Ensure that all of the assets that are needed to render a page are accessible to the crawlers. If assets are slow to load, then they might timeout when Googlebot fetches the page, and some of the page might not be indexed. Avoid timed interstitials, because these are effectively timeouts.

## URLs

The process of optimization should start with the URL.

- Single URL per piece of content: for efficiency, Google systems try to discard duplicate URLs
- Use traditional URLs (don't point to fragments)
- The element of "link" with type "canonical" in HEAD sections in treated as a strong hint about preferred URL, but not necessarily obeyed
- The "canonical" element must be provided in the HTML, not added by JavaScript
- If necessary, use Search Console to specify the part of URLs that should be excluded when checking for uniqueness

## Providing the Content of a Search Listing 

Google use the URL and these other items to populate the listing for your in search results:

- Page title: Use a "title" element in the HEAD section
- Description: Use a element of "meta" with name set as "description"
- [JSON-LD](https://json-ld.org/) structured data embedded in the page

Embedding JSON-LD data in the source of a page enables Google to extract meaning from the page and show rich results.

## Sitemaps

- Individual sitemaps are limited to 50,000 URLs
- Use a sitemap index file to submit a list of multiple sitemaps
- Consider that not every page on your site should be indexed

## Robots.txt

Google crawlers honour robots.txt files. The expected format for these files is described in the [Robots.txt Specifications](https://developers.google.com/search/reference/robots_txt).

# Resources

## Google Documentation

Google are consolidating their information to the site [web.dev](https://web.dev/). [The Google Developers Website](https://developers.google.com/web/) still has a large amount of content.

The details of the page ranking systems are secret. To help content creators understand the criteria that are applied, the [Google Search Quality Guidelines](https://static.googleusercontent.com/media/www.google.com/en//insidesearch/howsearchworks/assets/searchqualityevaluatorguidelines.pdf) are published. This document is the handbook for Google staff who check the results of the search engine.

The [Webmaster Guidelines](https://support.google.com/webmasters/answer/35769?hl=en) are a brief summary of good practice.

## Videos 

- [Build a successful web presence with Google Search (Google I/O '18)](https://www.youtube.com/watch?v=NO-sdBzb1Hc) 
- [Deliver search-friendly JavaScript-powered websites (Google I/O '18)](https://www.youtube.com/watch?v=PFwUbgvpdaQ)
- [SEO Snippets series](https://www.youtube.com/watch?v=p74HC4x5AUE&list=PLKoqnv2vTMUPhLQ054sMg3vgzy9md9tWg)

## Online Tools

- [Google "mobile-friendly" test](https://search.google.com/test/mobile-friendly) can also show the source code of a page, as rendered by Googlebot. 
- [Google "rich results" test](https://search.google.com/test/rich-results) shows how Googlebot sees your page when rendering as a desktop browser
- The Google Search Console includes a _Fetch as Google_ feature, so that you see what Googlebot receives from your site, before rendering
- Google provide search data with the Search Console API
- Google now also provide an API for fast link submission

## Third-Party Resources

- [The Beginner's Guide to SEO](https://moz.com/beginners-guide-to-seo), from Moz.
- [SEO Capability Maturity Model](https://moz.com/blog/seo-client-maturity), from Moz.
- [The Science Behind Google PageSpeed Insights & What It Actually Measures](https://wpsmackdown.com/google-pagespeed-insights-explained/)
