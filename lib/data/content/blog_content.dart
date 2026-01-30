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

  static const String _pieChartContent = '''
  # Interactive Pie Chart Feature: A Deep Dive into Expense Visualization

## Overview

The pie chart feature is a sophisticated data visualization component built into the Transactions page of our finance app. It provides users with an intuitive, interactive way to understand their spending patterns by breaking down expenses by category. This feature combines the power of the **fl_chart** library with custom painting techniques to create a polished, professional visualization experience.

## Key Features

### 1. **Interactive Touch Response**
- Users can tap on pie chart segments to highlight them
- Touched segments expand slightly (from 80px to 90px radius) for visual feedback
- Real-time interaction using Flutter's touch event system

### 2. **Custom Label System**
- Smart label positioning with automatic overlap resolution
- Leader lines connecting segments to labels
- Color-coded labels matching their respective segments
- Percentage display for each category

### 3. **Comprehensive Analysis Tab**
- Summary grid showing Income, Expense, Savings, and Investment totals
- Detailed expense breakdown by category
- Legend with category names, percentages, and amounts
- Link to detailed analytics page for deeper insights

## Technical Architecture

### Core Technologies

#### 1. **fl_chart Library (v0.68.0)**
The foundation of our pie chart implementation. This Flutter charting library provides:
- `PieChart` widget for rendering the chart
- `PieChartData` for configuration
- `PieChartSectionData` for individual segments
- `PieTouchData` for interaction handling

#### 2. **Custom Painter Pattern**
We implemented a custom `PieChartLabelPainter` that extends Flutter's `CustomPainter` to:
- Draw leader lines from segments to labels
- Position labels intelligently to avoid overlaps
- Render text with proper styling and alignment

#### 3. **State Management with Riverpod**
- `ConsumerStatefulWidget` for reactive state management
- Watches transaction and category data streams
- Automatically updates when data changes

### Implementation Details

#### Data Processing Pipeline

```dart
// 1. Filter transactions by date range (if selected)
final filtered = transactions.where((t) {
  if (_dateRange == null) return true;
  return (t.date.isAfter(_dateRange!.start.subtract(const Duration(seconds: 1))) &&
      t.date.isBefore(_dateRange!.end.add(const Duration(days: 1))));
}).toList();

// 2. Aggregate expenses by category
final Map<String, double> categorySpending = {};
for (var t in widget.transactions) {
  if (t.type == 'expense') {
    expense += t.amount;
    categorySpending[t.categoryId] = (categorySpending[t.categoryId] ?? 0) + t.amount;
  }
}

// 3. Sort categories by spending amount (descending)
final sortedCategories = categorySpending.entries.toList()
  ..sort((a, b) => b.value.compareTo(a.value));
```

#### Pie Chart Configuration

**Key Parameters:**
- `startDegreeOffset: -90` - Starts the chart from the top (12 o'clock position)
- `sectionsSpace: 0` - No gaps between segments
- `centerSpaceRadius: 0` - Full pie chart (not a donut)
- `borderSide: BorderSide(color: Colors.black12, width: 1)` - Subtle separators between segments

**Touch Interaction:**
```dart
pieTouchData: PieTouchData(
  touchCallback: (FlTouchEvent event, pieTouchResponse) {
    setState(() {
      if (!event.isInterestedForInteractions ||
          pieTouchResponse == null ||
          pieTouchResponse.touchedSection == null) {
        touchedIndex = -1;
        return;
      }
      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    });
  },
)
```

#### Custom Label Painter Algorithm

The `PieChartLabelPainter` implements a sophisticated label positioning system:

**Step 1: Calculate Initial Positions**
```dart
for (var item in items) {
  final sweepAngle = (item.value / total) * 2 * math.pi;
  final midAngle = currentAngle + sweepAngle / 2;
  
  // Anchor point at chart edge
  final anchorRadius = radius;
  final anchorX = center.dx + anchorRadius * math.cos(midAngle);
  final anchorY = center.dy + anchorRadius * math.sin(midAngle);
  
  // Ideal label position (outside the chart)
  final labelRadius = radius + 40;
  final idealX = center.dx + labelRadius * math.cos(midAngle);
  final idealY = center.dy + labelRadius * math.sin(midAngle);
}
```

**Step 2: Resolve Overlaps**
- Labels are grouped by side (left/right)
- Sorted by vertical position
- Minimum spacing of 28px enforced
- Overlapping labels are pushed down to maintain readability

**Step 3: Draw Leader Lines**
The leader line consists of three segments:
1. **Radial segment**: From chart edge outward (15px)
2. **Angled segment**: To the label position
3. **Horizontal tail**: 20px horizontal line for label attachment

```dart
final path = Path();
path.moveTo(pos.anchor.dx, pos.anchor.dy);

// Segment 1: Clear the chart
final clearRadius = radius + 15;
final clearX = center.dx + clearRadius * math.cos(pos.midAngle);
final clearY = center.dy + clearRadius * math.sin(pos.midAngle);
path.lineTo(clearX, clearY);

// Segment 2: Angle to label
path.lineTo(pos.finalPos.dx, pos.finalPos.dy);

// Segment 3: Horizontal tail
final tailEnd = Offset(
  pos.finalPos.dx + (pos.isRightSide ? 20 : -20), 
  pos.finalPos.dy
);
path.lineTo(tailEnd.dx, tailEnd.dy);

canvas.drawPath(path, paint);
```

### Data Models

#### ChartLabelItem
```dart
class ChartLabelItem {
  final double value;      // Expense amount
  final Color color;       // Category color
  final String text;       // "Category Name\nXX.X%"
}
```

#### _LabelPos (Internal)
```dart
class _LabelPos {
  final ChartLabelItem item;
  final double midAngle;        // Angle at segment center
  final Offset anchor;          // Point on chart edge
  final Offset idealPos;        // Desired label position
  final bool isRightSide;       // Left or right of center
  Offset finalPos;              // Actual position after overlap resolution
}
```

## User Interface Components

### Summary Grid
A 2x2 grid displaying:
- **Income** (green, arrow down icon)
- **Expense** (red, arrow up icon)
- **Savings** (blue, savings icon)
- **Investment** (purple, trending up icon)

Each card features:
- Color-coded background with 10% opacity
- Matching border with 20% opacity
- Icon and label
- Formatted currency amount

### Pie Chart Visualization
- **Height**: 400px (increased to accommodate labels)
- **Radius**: 80px (base), 90px (touched)
- **Positioning**: Centered in container
- **Labels**: External with leader lines

### Legend Section
Below the chart, a scrollable list showing:
- Color indicator (12px circle)
- Category name
- Percentage of total expenses
- Absolute amount

### Navigation
"View Detailed Analytics" button links to `DetailedStatsPage` for comprehensive analysis.

## Design Decisions

### Why Custom Labels?
The built-in fl_chart labels had limitations:
- Limited positioning control
- Overlap issues with many categories
- Less flexibility in styling

Our custom painter provides:
- Precise control over label placement
- Smart overlap resolution
- Professional appearance with leader lines
- Better use of available space

### Color Consistency
- Each category has a unique color stored in the database
- Colors are used consistently across:
  - Pie chart segments
  - Leader lines
  - Legend indicators
  - Transaction list items

### Performance Optimization
- `shouldRepaint()` only triggers on data changes
- Efficient overlap resolution algorithm
- Minimal canvas redraws

## Code Organization

### File Structure
```
lib/features/transactions/presentation/pages/all_transactions_page.dart
├── AllTransactionsPage (Main widget)
│   ├── History Tab
│   └── Analysis Tab
├── MultiSectionAnalysis (Analysis implementation)
│   ├── Summary Grid
│   ├── Pie Chart with Custom Labels
│   └── Legend
├── ChartLabelItem (Data model)
├── PieChartLabelPainter (Custom painter)
└── _LabelPos (Internal positioning helper)
```

### Dependencies
```yaml
dependencies:
  fl_chart: ^0.68.0          # Charting library
  flutter_riverpod: ^2.6.1   # State management
  intl: ^0.19.0              # Date formatting
```

## Usage Flow

1. **User navigates** to Transactions page
2. **Selects** Analysis tab
3. **Views** summary grid with totals
4. **Interacts** with pie chart (tap to highlight)
5. **Reads** labels via leader lines
6. **Scrolls** through legend for details
7. **Optionally** filters by date range
8. **Navigates** to detailed analytics if needed

## Future Enhancements

Potential improvements could include:
- Animation on chart load
- Export chart as image
- Comparison mode (month-over-month)
- Drill-down to category transactions
- Custom color themes
- Accessibility improvements (screen reader support)

## Conclusion

This pie chart feature demonstrates the power of combining third-party libraries with custom Flutter painting to create a polished, professional data visualization. The implementation balances functionality, performance, and user experience, providing users with clear insights into their spending patterns while maintaining the app's modern aesthetic.

The modular design makes it easy to maintain and extend, while the custom label system ensures readability even with many expense categories. This feature is a cornerstone of the app's analytics capabilities, helping users make informed financial decisions.

---

**Technologies Used:**
- Flutter SDK
- fl_chart library
- Custom Canvas painting
- Riverpod state management
- Dart math library
- Material Design principles

**Key Files:**
- `all_transactions_page.dart` - Main implementation
- `transaction_model.dart` - Data models
- `category_model.dart` - Category definitions
- `transaction_provider.dart` - Data providers
 
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
    Blog(
      id: 'interactive-pie-chart-flutter',
      title:
          'Building a Professional Interactive Pie Chart in Flutter: Expense Visualization Done Right',
      excerpt:
          'A deep dive into building a production-grade interactive pie chart in Flutter using fl_chart, '
          'CustomPainter, and Riverpod. Learn how to create professional analytics UI for finance apps '
          'with scalable architecture, clean UX, and performance in mind.',
      content: _pieChartContent,
      author: 'Saugat Jonchhen',
      publishDate: '2026-01-30',
      readTime: '10 min read',
      imageUrl: '',
      category: 'Pie Chart in Flutter',
      tags: [
        'Flutter',
        'fl_chart',
        'Data Visualization',
        'Finance App',
        'CustomPainter',
        'Riverpod',
        'Analytics',
        'Mobile UI',
        'UX Design',
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
