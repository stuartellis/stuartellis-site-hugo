+++
Title = "Optimizing Websites for Google Search"
Slug = "google-search-optimizing"
Date = "2019-04-02T08:06:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["google", "web"]
Type = "article"

+++

Notes summarizing [Google](https://www.google.com/) recommendations for Web developers.

<!--more-->

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

If you have a large or rapidly changing site that relies on JavaScript, Google suggest that you add [dynamic rendering](https://developers.google.com/search/docs/guides/dynamic-rendering), which means detecting Googlebot and serving fully rendered pages to it. They also recommend that you transition to "hybrid rendering".

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
- JSON-LD structured data: https://codelabs.developers.google.com/codelabs/structured-data/index.html

Embedding JSON-LD data in the page enables Google to extract meaning from the page and show rich results.

## Sitemaps

- Individual sitemaps are limited to 50,000 URLs
- Use a sitemap index file to submit a list of multiple sitemaps
- Consider that not every page on your site should be indexed

## Robots.txt

Google crawlers honour robots.txt "strictly".

# Resources

## Google Documentation

Google are consolidating their information to the site [web.dev](https://web.dev/). [The Google Developers Website](https://developers.google.com/web/) still has a large amount of content.

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
