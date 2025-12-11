# 🧑‍💻 [Your Name/Alias] - Personal Portfolio Website

### Modern, Component-Driven, and Responsive Web Presence

---

## 📄 Project Description

This project is a personal portfolio website designed to serve as a comprehensive, modern, and high-performance showcase of my skills, professional experience, and technical abilities.

Built as a Single-Page Application (SPA), the site prioritizes user experience with a clean, developer-centric design, fast load times, and complete responsiveness across desktop, tablet, and mobile devices.

### Key Sections:

1.  **Home / About Me:** An introductory section detailing core skills and offering a quick summary.
2.  **Resume:** Features a responsive, chronological timeline for professional experience and education, alongside a dynamic, variable-height grid for technical skills.
3.  **Portfolio / Projects:** A comprehensive showcase of projects using a flexible, masonry-style layout with dynamic filtering based on the technology stack used.
4.  **Blogs / Articles:** A dedicated section for sharing thoughts, tutorials, and insights, featuring clean, immersive reading pages.

---

## 🛠 Technology & Architecture

The entire front-end of this personal website is built using **Flutter**. This choice was made to leverage a single codebase for high-quality, native-level performance and design consistency across all target platforms (Web, Mobile).

| Category | Technology / Library | Purpose |
| :--- | :--- | :--- |
| **Framework** | **Flutter** (3.x+) | Primary UI toolkit, ensuring a single codebase for Web and Mobile. |
| **Language** | **Dart** | High-level, optimized language for the Flutter framework. |
| **Routing** | `go_router` | Handles declarative navigation and deep linking for clean, shareable URLs (e.g., `/blogs/123`). |
| **Layout** | **Custom Responsive Utilities** | Uses `LayoutBuilder` and custom size breakpoints to adapt content, column count, and padding for optimal viewing on any device. |
| **UI/Design** | **Material Design 3** | Adheres to modern design principles, supporting a consistent, aesthetic theme (including dark mode compatibility). |
| **Icons** | `font_awesome_flutter` | Provides a rich set of professional icons for UI elements and links. |
| **Deployment** | Web (SPA) / Android (APK) | Built to be easily deployed to hosting services like GitHub Pages or Firebase Hosting, and packaged as a mobile application. |

---

## 📂 Folder Structure

The project employs a clear feature-based folder structure to maintain separation of concerns:
lib/ ├── core/ # Theme, constants, and global utilities (responsive logic) ├── data/ # Data models and mock content (e.g., ProjectsContent) ├── presentation/ # UI layer (Pages and Widgets) │ ├── blogs/ # BlogListPage, BlogDetailPage │ ├── portfolio/ # PortfolioPage │ ├── resume/ # ResumePage, SkillsGrid, Timelines │ └── widgets/ # Reusable, non-screen-specific components (NavBar, Footer) └── main.dart # Application entry point and router configuration