# Sam — Game Dev & Software Engineer (Flutter Web Portfolio)

This is a responsive, animated portfolio built with Flutter Web. It highlights game development and full‑stack engineering work in an eye‑catching dark‑neon aesthetic.

## Run locally
- flutter run -d chrome

## Build for web
- flutter build web --release
  - Output in build/web
  - Serve with any static host (GitHub Pages, Netlify, Vercel, Firebase Hosting)

## Customize content
- Edit lib/models/project.dart to add or change projects (title, description, tags, link, type).
- Edit text in lib/sections/hero_section.dart for the headline and CTA.
- Adjust theme colors in lib/theme.dart.
- Update SEO (title/description) in web/index.html.

## Structure
- lib/app.dart: App scaffold, top nav, sections, footer.
- lib/sections/hero_section.dart: Animated starfield hero section.
- lib/sections/projects_section.dart: Filterable grid of projects with hover effects.
- lib/models/project.dart: Project model and demo entries.
- lib/theme.dart: Dark neon theme.

## Deploy to GitHub Pages (quick)
1. flutter build web --release
2. Commit and push build/web to a gh-pages branch or set your Pages source to build/web.

© ${CURRENT_YEAR} Sam. Built with Flutter.
