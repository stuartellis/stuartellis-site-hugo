+++
Title = "Optimizing Websites for Google Search"
Slug = "google-search-optimizing"
Date = "2019-06-08T18:50:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["google", "web"]
Type = "article"
Toc = true

+++

A summary of [Google](https://www.google.com/) recommendations for Web developers.

<!--more-->

# Overview

In the U.S. and many other regions, Google is the dominant search provider. [Moz](https://www.moz.com) claim that in 2018, 62.6% of searches in the U.S. are through Google, a further 22.6% are Google Images, and 4.3% are on YouTube. These Google properties are the top three search providers in the U.S. region.

In addition, voice search is a growing trend. Google are a leading provider of voice search services through Android phones, and other devices. The answers and results that Google voice search systems provide are based on the main search engine.

Today, about half of searches now result in no further clicks. This is partly because of the information that Google now shows directly on the results page. In these cases, Google is the last page that the user visits, but most of the content has been retrieved from third-party Websites by Google systems.

> Statistics are from the presentation [the SEO trends for 2019 you need to know about](https://www.youtube.com/watch?v=-8MU_cIhL0g), by Sarah Bird, CEO of Moz.

Google prioritise sites by many factors, but pages must be fast, mobile-friendly and provide relevant information.

# How Google Indexing Works

The system is collectively known as _Googlebot_, but has several components:

- The scheduling sends URLs to crawlers
- _Crawlers_ follow URLs and get content
- _Renderers_ process the content, running it as a Web browser does
- _Indexers_ extract information from the rendered content

Googlebot performs a crawl and an initial index, then renders the pages later (perhaps days later).

JavaScript pages must be rendered before they can be go to a second indexing, and the contained URLs are crawled in turn. Rendering of JS-powered pages is deferred until resources are available to process that content. This means that server-generated HTML is indexed much more quickly, because there is no waiting for a render.

# Design Principles

- _Discoverability_: Help Google find the content
- _Evaluable_: Help Google understand the content
- _Speed_ is a ranking factor

Google research indicates that users consider speed to be the most important factor in how they feel about a site. The break-point is five seconds: In 2018, DoubleClick analytics show a 53% lower bounce rate for mobile sites that have load times of less than five seconds.

# URLs

The process of optimization should start with the URL.

- Single URL per piece of content: for efficiency, Google systems try to discard duplicate URLs
- Use traditional URLs (don't point to fragments)
- The element of "link" with type "canonical" in HEAD sections in treated as a strong hint about preferred URL, but not necessarily obeyed
- The "canonical" element must be provided in the HTML, not added by JavaScript
- If necessary, use Search Console to specify the part of URLs that should be excluded when checking for uniqueness

# Providing the Content of a Search Listing

Google use the URL and these other items to populate the listing for your in search results:

- Page title: Use a "title" element in the HEAD section
- Description: Use a element of "meta" with name set as "description"
- [JSON-LD](https://json-ld.org/) structured data embedded in the page

Embedding JSON-LD data in the source of a page enables Google to extract meaning from the page and show rich results.

# Sitemaps

- Individual sitemaps are limited to 50,000 URLs
- Use a sitemap index file to submit a list of multiple sitemaps
- Consider that not every page on your site should be indexed

# Robots.txt

Google crawlers honor robots.txt files. The expected format for these files is described in the [Robots.txt Specifications](https://developers.google.com/search/reference/robots_txt).

# Page Design and Rendering for Search

Pages that are served to Googlebot crawlers should be designed with the crawler in mind. Modern JavaScript frameworks do not prevent Google indexing, but you need to avoid practices that make the indexing process less reliable.

The search renderers use the latest stable release of Chromium. The version of Chromium is updated every six weeks, when a new stable version of Google Chrome is released. By default, the renderers emulate Chromium on mobile.

The indexer avoid activating JavaScript events. To ensure that the indexer notices links on your pages, use the traditional _a href_ markup for links, rather than just JavaScript _.onclick()_ event handlers.

For images, either use standard _img_ tags in your markup, or list the images in JSON-LD markup for the page. Googlebot will not see lazy loaded images. References to images in CSS are not followed.

If you have a large or rapidly changing site that relies on JavaScript, Google suggest that you add [dynamic rendering](https://developers.google.com/search/docs/guides/dynamic-rendering), which means detecting Googlebot and serving fully rendered pages to it. They also recommend that you transition to _hybrid rendering_.

Your code can spot "Googlebot" by looking for that string in the User Agent: it may be claiming to be either desktop or mobile.

Ensure that all of the assets that are needed to render a page are accessible to the crawlers. If assets are slow to load, then they can timeout when Googlebot fetches the page. This will result in some of the page not being indexed. Avoid timed interstitials, because these are effectively timeouts.

# Online Tools

## Google Search Console

The [Google Search Console](https://search.google.com/search-console/about) is your main interface for understanding how Google interacts with your Website.

- The Search Console includes a _Fetch as Google_ feature, so that you see what Googlebot receives from your site, before rendering
- Google provide search data with the Search Console API
- Google now also provide an API for fast link submission

## The Chrome User Experience Report

The [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report/) (CrUX) measures user experiences on popular Websites.

The CrUX dataset is updated monthly. Aggregate data for origins (Websites) is published on Google BigQuery, so that you can query that data yourself with Google Data Studio or other tools. [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) uses URL-level data.

## Website Testing Tools

- [Google "mobile-friendly" test](https://search.google.com/test/mobile-friendly) can also show the source code of a page, as rendered by Googlebot.
- [Google "rich results" test](https://search.google.com/test/rich-results) shows how Googlebot sees your page when rendering as a desktop browser

# Resources

## Google Documentation

Google are consolidating their information to the site [web.dev](https://web.dev/). [The Google Developers Website](https://developers.google.com/web/) still has a large amount of content.

The details of the page ranking systems are secret. To help content creators understand the criteria that are applied, the [Google Search Quality Guidelines](https://static.googleusercontent.com/media/www.google.com/en//insidesearch/howsearchworks/assets/searchqualityevaluatorguidelines.pdf) are published. This document is the handbook for Google staff who check the results of the search engine.

The [Webmaster Guidelines](https://support.google.com/webmasters/answer/35769?hl=en) are a brief summary of good practice.

## Videos

- [Build a successful web presence with Google Search (Google I/O '18)](https://www.youtube.com/watch?v=NO-sdBzb1Hc)
- [Deliver search-friendly JavaScript-powered websites (Google I/O '18)](https://www.youtube.com/watch?v=PFwUbgvpdaQ)
- [Use Lighthouse and Chrome UX Report to optimize web app performance (Google I/O '18)](https://www.youtube.com/watch?v=UvK9zAsSM8Q)
- [SEO Snippets series](https://www.youtube.com/watch?v=p74HC4x5AUE&list=PLKoqnv2vTMUPhLQ054sMg3vgzy9md9tWg)

## Third-Party Resources

### SEO

- [The Beginner's Guide to SEO](https://moz.com/beginners-guide-to-seo), from Moz.
- [SEO Capability Maturity Model](https://moz.com/blog/seo-client-maturity), from Moz.
- [the SEO trends for 2019 you need to know about](https://www.youtube.com/watch?v=-8MU_cIhL0g)

### Web Page Performance

See the separate article for [recommendations for Web page performance](https://www.stuartellis.name/articles/python-learning-resources).
