+++
Title = "Optimizing Websites for Google Search"
Slug = "google-search-optimizing"
Date = "2019-04-07T09:02:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["google", "web"]
Type = "article"

+++

Notes summarizing [Google](https://www.google.com/) recommendations for Web developers.

<!--more-->

# Overview

In the U.S. and many other regions, Google is the dominant search provider. [Moz](https://www.moz.com) claim that in 2018, 62.6% of searches in the U.S. are through Google, a further 22.6% are Google Images, and 4.3% are on YouTube. These Google properties are the top three search providers in the U.S. region. 

In addition, voice search is a growing trend. Google are a leading provider of voice search services through Android phones, and other devices. The answers and results that Google voice search systems provide are based on the main search engine.

Today, about half of searches now result in no further clicks. This is partly because of the information that Google now shows directly on the results page. In these cases, Google is the last page that the user visits, but most of the content has been retrieved from third-party Websites by Google systems.

> Statistics are from the presentation [the SEO trends for 2019 you need to know about](https://www.youtube.com/watch?v=-8MU_cIhL0g), by Sarah Bird, CEO of Moz.

Google prioritise sites by many factors, but pages must be fast, mobile-friendly and provide relevant information.

# How Google Indexing Works

The system is collectively known as *Googlebot*, but has several components:

- The scheduling sends URLs to crawlers 
- *Crawlers* follow URLs and get content
- *Renderers* process the content, running it as a Web browser does
- *Indexers* extract information from the rendered content

Googlebot performs a crawl and an initial index, then renders the pages later (perhaps days later).

JavaScript pages must be rendered before they can be go to a second indexing, and the contained URLs are crawled in turn. Rendering of JS-powered pages is deferred until resources are available to process that content. This means that server-generated HTML is indexed much more quickly, because there is no waiting for a render. 

# Design Principles

* *Discoverability*: Help Google find the content
* *Evaluable*: Help Google understand the content
* *Speed* is a ranking factor

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

Search renderers use Chrome 41 (so ES5 JavaScript, *not* ES2015), and default to rendering as if for mobile.

The indexer avoid activating JavaScript events. To ensure that the indexer notices links on your pages, use _a href_ for links, rather than just JS _.onclick()_ event handlers.

For images, either use _img_ tags, or list the images in JSON-LD markup for the page. Googlebot will not see lazy loaded images. References to images in CSS are not followed.

If you have a large or rapidly changing site that relies on JavaScript, Google suggest that you add [dynamic rendering](https://developers.google.com/search/docs/guides/dynamic-rendering), which means detecting Googlebot and serving fully rendered pages to it. They also recommend that you transition to _hybrid rendering_.

Your code can spot "Googlebot" by looking for that string in the User Agent: it may be claiming to be either desktop or mobile.

Ensure that all of the assets that are needed to render a page are accessible to the crawlers. If assets are slow to load, then they can timeout when Googlebot fetches the page. This will result in some of the page not being indexed. Avoid timed interstitials, because these are effectively timeouts.

# Recommendations for Page Performance

## Finding Performance Issues

Collect field data first, and then use that to calibrate your lab data. _Real User Monitoring_ services provide field data from your own site. The [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report/) (CrUX) measures popular Websites across the Internet. 

The [Lighthouse](https://developers.google.com/web/tools/lighthouse/) tool also provides recommendations. These are based on a set of good practices that have been defined by Google. You can run this in Chrome, as an online service, or as a command-line tool. 

## Using Metrics 

There are two types of metrics: _visual metrics_ and _interactivity metrics_. Visual metrics include _First Contenful Paint_ (FCP) and _Speed Index_. Interactivity metrics include _Time to Interactive_ (TTI) and _First Input Delay_, which is the response time of the code that handles the very first input from the user.

The Speed Index measures the period between FCP and TTI. It rewards pages that load assets early. The relationship between these three key metrics is:

First Contenful Paint -> Speed Index -> Time to Interactive 

## Reducing Payload

The most effective way to improve performance is to reduce the amount of data that your Website sends. There are several ways to do this: 

- Remove unused code
- Minify CSS and JavaScript
- Enable content compression with gzip or brotli
- Set the maximum cache period for each asset that you can
- Use modern image formats, such as WebP
- Use code-splitting

You do need to limit caching of an asset in some cases for security, or to ensure that the content is relevant. Set long cache times for assets that do not need to change frequently.

Code-splitting improves the JavaScript boot-up time, as well as reducing the amount of data that is sent to the browser in each response.

## Optimizing Network Use

Use markup such as _preconnect_, _preload_ and _prefetch_ to provide hints to the browser about what it should load, and what priority these should have. For example, use _preload_ with links to Web fonts, so that the browser begins downloading the font as soon as the HTML is parsed. 

You should decide a strategy for loading the Web fonts for your pages. Use _font-display_ to control the transition from default browser fonts to your chosen custom fonts. To have maximum control over the loading and caching of font files, Google recommend that you self-host the fonts that your site uses.

To manage your CSS, split the CSS by priority. Consider inlining critical CSS styles, and using _preload_ to fetch a stylesheet with the rest of the CSS that is needed for the page. Then use the _defer_ attribute or lazy-loading to get stylesheets for less important styles. This enables the Web browser to provide a working page to the user much more quickly.

If you are developing a Progressive Web Application, Google recommend that you follow the [PRPL pattern](https://developers.google.com/web/fundamentals/performance/prpl-pattern/). This combines _Push_, _Render_, _Pre-cache_, and _Lazy Load_. 

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

Google provide an [infographic and page to summarize their performance tools](https://developers.google.com/web/fundamentals/performance/speed-tools/).

## Videos 

- [Build a successful web presence with Google Search (Google I/O '18)](https://www.youtube.com/watch?v=NO-sdBzb1Hc) 
- [Deliver search-friendly JavaScript-powered websites (Google I/O '18)](https://www.youtube.com/watch?v=PFwUbgvpdaQ)
- [Web performance made easy (Google I/O '18)](https://www.youtube.com/watch?v=Mv-l3-tJgGk&list=PLOU2XLYxmsIInFRc3M44HUTQc3b_YJ4-Y)
- [Use Lighthouse and Chrome UX Report to optimize web app performance (Google I/O '18)](https://www.youtube.com/watch?v=UvK9zAsSM8Q)
- [SEO Snippets series](https://www.youtube.com/watch?v=p74HC4x5AUE&list=PLKoqnv2vTMUPhLQ054sMg3vgzy9md9tWg)

## Third-Party Resources

### SEO

- [The Beginner's Guide to SEO](https://moz.com/beginners-guide-to-seo), from Moz.
- [SEO Capability Maturity Model](https://moz.com/blog/seo-client-maturity), from Moz.
-  [the SEO trends for 2019 you need to know about](https://www.youtube.com/watch?v=-8MU_cIhL0g)

### Performance

- [The Science Behind Google PageSpeed Insights & What It Actually Measures](https://wpsmackdown.com/google-pagespeed-insights-explained/)
- [Essential Image Optimization](https://images.guide), a free ebook by Addy Osmani
- [Web Font Loading Recipes](https://www.zachleat.com/web/recipes/), by Zach Leatherman
