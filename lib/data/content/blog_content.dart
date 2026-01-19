// lib/data/content/blogs_content.dart
import '../models/blog.dart';

class BlogsContent {
  static const String _content = '''
## Introduction

Flutter Web is an excellent choice for building highly interactive, visually rich web applications.
However, when it comes to **SEO**, especially with **CanvasKit**, things are not as straightforward
as traditional HTML-based frameworks.

My portfolio website is built using **Flutter Web with CanvasKit** and deployed on **Netlify**.
Since I also publish blogs on this site, I needed to understand how far SEO could realistically
go—and how to implement the *best possible SEO* within Flutter’s limitations.

This article shares exactly what worked, what didn’t, and how I implemented SEO in a real
production setup.  

##

---

##

## Why SEO Is Hard with CanvasKit

CanvasKit renders your UI inside a canvas element. This means:

- Search engines **cannot read your text content**
- There are **no semantic HTML tags** like h1, p, or article
- Blog content rendered inside Flutter widgets is invisible to crawlers

In short, **CanvasKit is not content-indexable**.

However, SEO is more than just content indexing.
##
---
##
## What SEO Is Possible with CanvasKit

Even with CanvasKit, you can still achieve:

- URL indexing
- Proper page titles
- Meta descriptions
- Social media previews
- Sitemap-based crawling
- Strong performance scores

For portfolio websites, this is often more than enough.
##
---
##
## Step 1: Netlify Redirects for Clean URLs

Flutter Web requires proper rewrite rules to support clean URLs like /blog/flutter-seo.

Create a file named _redirects inside the web directory with the following content:

    /all-paths   /index.html   200

This ensures all routes resolve correctly and are indexable.
##
---
##
## Step 2: Treat index.html as Your SEO Backbone

Since CanvasKit content is invisible, **index.html becomes your SEO foundation**.

Add proper meta tags in the head section:

    <title>Saugat Jonchhen | Senior Flutter Developer</title>
    <meta name="description"
          content="Senior Flutter developer specializing in scalable mobile and web applications." />
    <meta name="robots" content="index, follow" />

This defines how your homepage appears in search results.
##
---
##
## Step 3: Dynamic Page Titles and Meta Descriptions

Even though content isn’t readable, **Google still indexes page titles per URL**.

Example Flutter Web code:

    import 'dart:html' as html;

    void updateSeo(String title, String description) {
      html.document.title = title;

      final meta = html.document.querySelector(
        'meta[name="description"]',
      ) ?? html.MetaElement(name: 'description');

      meta.content = description;
      html.document.head!.append(meta);
    }

Call this method when navigating to blog or page routes.
##
---
##
## Step 4: Sitemap and Robots Configuration

Create a robots.txt file:

    User-agent: *
    Allow: /

    Sitemap: https://yoursite.netlify.app/sitemap.xml

Then create a sitemap.xml listing your main routes and blog pages.

This helps search engines discover all pages—even if content visibility is limited.
##
---
##
## Step 5: Performance Matters More Than Content

With CanvasKit, **performance becomes your SEO advantage**.

Focus on:

- Release builds
- Image compression
- Avoiding heavy startup logic
- Aggressive caching using Netlify headers

Fast websites tend to rank better, even with limited content indexing.
##
---
##
## What I Did Not Do (On Purpose)

- I did **not** hide HTML text behind the canvas
- I did **not** keyword-stuff meta tags
- I did **not** expect long-form blog content to rank highly

These techniques either violate SEO guidelines or create unrealistic expectations.
##
---
##
## Final Verdict

Flutter Web with CanvasKit is **not ideal for SEO-heavy blogs**, but it works well for:

- Developer portfolios
- App showcases
- Interactive demos

If SEO is your top priority, static HTML or SSR frameworks are a better choice.
If UI quality and developer experience matter more, **CanvasKit is a solid option**.
##
---
##
## Closing Thoughts

This setup allowed my portfolio to remain discoverable while preserving the performance and
visual polish that Flutter excels at.

Understanding the limitations—and working within them—is the key to using Flutter Web
effectively.
''';

  static const List<Blog> blogs = [
    // Blog(
    //   id: '1',
    //   title: 'The Future of Flutter Development',
    //   excerpt:
    //       'Exploring the roadmap of Flutter, Impeller engine, and what it means for cross-platform developers in 2024.',
    //   content: _dummyContent,
    //   author: 'John Doe',
    //   publishDate: 'Dec 12, 2023',
    //   readTime: '5 min read',
    //   imageUrl:
    //       'https://via.placeholder.com/800x400/0F172A/00BFA5?text=Flutter+Future',
    //   category: 'Tech',
    //   tags: ['Flutter', 'Mobile', 'Dart'],
    // ),
    // Blog(
    //   id: '2',
    //   title: 'Mastering State Management',
    //   excerpt:
    //       'A deep dive into Riverpod 2.0. Understanding providers, notifiers, and code generation for scalable apps.',
    //   content: _dummyContent,
    //   author: 'John Doe',
    //   publishDate: 'Nov 28, 2023',
    //   readTime: '8 min read',
    //   imageUrl:
    //       'https://via.placeholder.com/800x400/0F172A/7C3AED?text=State+Management',
    //   category: 'Tutorial',
    //   tags: ['Riverpod', 'Architecture'],
    // ),
    // Blog(
    //   id: '3',
    //   title: 'UI/UX Principles for Developers',
    //   excerpt:
    //       'How to think like a designer. Basic principles of spacing, typography, and color theory for engineers.',
    //   content: _dummyContent,
    //   author: 'John Doe',
    //   publishDate: 'Oct 15, 2023',
    //   readTime: '6 min read',
    //   imageUrl:
    //       'https://via.placeholder.com/800x400/0F172A/FBBF24?text=Design+Principles',
    //   category: 'Design',
    //   tags: ['UI/UX', 'Figma'],
    // ),
    // Blog(
    //   id: '4',
    //   title: 'From Junior to Senior Engineer',
    //   excerpt:
    //       'Lessons learned over 5 years of software engineering. Soft skills, mentorship, and technical growth.',
    //   content: _dummyContent,
    //   author: 'John Doe',
    //   publishDate: 'Sep 02, 2023',
    //   readTime: '10 min read',
    //   imageUrl:
    //       'https://via.placeholder.com/800x400/0F172A/0EA5E9?text=Career+Growth',
    //   category: 'Career',
    //   tags: ['Career', 'Soft Skills'],
    // ),
    Blog(
      id: 'flutter-seo-canvaskit-netlify',
      title:
          'SEO in Flutter Web with CanvasKit: What’s Possible and How I Implemented It on Netlify',
      excerpt:
          'Flutter Web with CanvasKit is not SEO-friendly by default, but you can still make it discoverable. '
          'This post explains what actually works, what doesn’t, and how I improved SEO for my Flutter '
          'CanvasKit portfolio deployed on Netlify.',
      content: _content,
      author: 'Saugat Jonchhen',
      publishDate: '2025-12-22',
      readTime: '6 min read',
      imageUrl: '/images/blog/flutter-seo-canvaskit.png',
      category: 'Flutter Web',
      tags: [
        'Flutter',
        'Flutter Web',
        'SEO',
        'CanvasKit',
        'Netlify',
        'Web Performance',
      ],
    ),
  ];

  static const String _dummyContent = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

### The Core Concept
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

* **Efficiency**: Optimize your build times.
* **Scalability**: Plan for growth from day one.
* **Maintainability**: Write clean, documented code.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
  """;
}
