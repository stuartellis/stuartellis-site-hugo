+++
Title = "Optimizing Web Page Performance"
Slug = "web-page-performance"
Date = "2019-04-22T13:05:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["google", "web"]
Type = "article"

+++

Recommendations for good Web page performance. This summarizes the guidance that is provided by [Google](https://www.google.com/).

<!--more-->

# Finding Performance Issues

Collect field data first, and then use that to calibrate your lab data. _Real User Monitoring_ services provide field data from your own site. The [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report/) (CrUX) measures popular Websites across the Internet.

The [Lighthouse](https://developers.google.com/web/tools/lighthouse/) tool also provides recommendations. These are based on a set of good practices that have been defined by Google. You can run this in Chrome, as an online service, or as a command-line tool.

# Using Metrics

There are two types of metrics: _visual metrics_ and _interactivity metrics_. Visual metrics include _First Contenful Paint_ (FCP) and _Speed Index_. Interactivity metrics include _Time to Interactive_ (TTI) and _First Input Delay_, which is the response time of the code that handles the very first input from the user.

The Speed Index measures the period between FCP and TTI. It rewards pages that load assets early. The relationship between these three key metrics is:

First Contenful Paint -> Speed Index -> Time to Interactive

# Reducing Payload

The most effective way to improve performance is to reduce the amount of data that your Website sends. There are several ways to do this:

- Remove unused code
- Minify CSS and JavaScript
- Enable content compression with gzip or brotli
- Set the maximum cache period for each asset that you can
- Use modern image formats, such as WebP
- Use code-splitting

You do need to limit caching of an asset in some cases for security, or to ensure that the content is relevant. Set long cache times for assets that do not need to change frequently.

Code-splitting improves the JavaScript boot-up time, as well as reducing the amount of data that is sent to the browser in each response.

# Optimizing Network Use

Use markup such as _preconnect_, _preload_ and _prefetch_ to provide hints to the browser about what it should load, and what priority these should have. For example, use _preload_ with links to Web fonts, so that the browser begins downloading the font as soon as the HTML is parsed.

You should decide a strategy for loading the Web fonts for your pages. Use _font-display_ to control the transition from default browser fonts to your chosen custom fonts. To have maximum control over the loading and caching of font files, Google recommend that you self-host the fonts that your site uses.

To manage your CSS, split the CSS by priority. Consider inlining critical CSS styles, and using _preload_ to fetch a stylesheet with the rest of the CSS that is needed for the page. Then use the _defer_ attribute or lazy-loading to get stylesheets for less important styles. This enables the Web browser to provide a working page to the user much more quickly.

If you are developing a Progressive Web Application, Google recommend that you follow the [PRPL pattern](https://developers.google.com/web/fundamentals/performance/prpl-pattern/). This combines _Push_, _Render_, _Pre-cache_, and _Lazy Load_.

# Online Tools

## The Chrome User Experience Report

The [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report/) (CrUX) measures user experiences on popular Websites.

The CrUX dataset is updated monthly. Aggregate data for origins (Websites) is published on Google BigQuery, so that you can query that data yourself with Google Data Studio or other tools. [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) uses URL-level data.

## Website Testing Tools

# Resources

## Google Documentation

Google are consolidating their information to the site [web.dev](https://web.dev/). [The Google Developers Website](https://developers.google.com/web/) still has a large amount of content.

The [Webmaster Guidelines](https://support.google.com/webmasters/answer/35769?hl=en) are a brief summary of good practice.

Google provide an [infographic and page to summarize their performance tools](https://developers.google.com/web/fundamentals/performance/speed-tools/).

## Google Videos

- [Web performance made easy (Google I/O '18)](https://www.youtube.com/watch?v=Mv-l3-tJgGk&list=PLOU2XLYxmsIInFRc3M44HUTQc3b_YJ4-Y)
- [Use Lighthouse and Chrome UX Report to optimize web app performance (Google I/O '18)](https://www.youtube.com/watch?v=UvK9zAsSM8Q)

## Third-Party Resources

- [The Science Behind Google PageSpeed Insights & What It Actually Measures](https://wpsmackdown.com/google-pagespeed-insights-explained/)
- [Essential Image Optimization](https://images.guide), a free ebook by Addy Osmani
- [Web Font Loading Recipes](https://www.zachleat.com/web/recipes/), by Zach Leatherman
- [Google Chrome Developer Tools Crash Course](https://www.youtube.com/watch?v=x4q86IjJFag), a video tutorial from Traversy Media
