# Changelog — Autify Web Landing Page

Tutte le modifiche significative al progetto sono documentate in questo file.
Il formato è basato su [Keep a Changelog](https://keepachangelog.com/it/1.0.0/).

---

## [1.0.0] — 2026-05-29

### 🎉 Release Iniziale

#### Aggiunto
- **Struttura progetto** Flutter Web con architettura modulare (theme, widgets, sections, pages)
- **Design System** — Palette colori estratta dal logo Autify (navy, blue, teal, orange su bianco ghiaccio)
- **Tipografia** — Google Fonts: Outfit (headings) + Inter (body) con scala responsive
- **Hero Section** — Full-viewport con logo animato, headline, subtitle, CTA dual-button, decorazioni floating con parallax
- **Features Section** — 4 card in griglia responsiva (Raccolta Dati, AI, Scale Valutazione, Efficienza) con scroll-triggered staggered animations
- **Value Section** — Layout split text+stats con chips highlight e metriche animate
- **Contact Section** — Background dark gradient, form validato (Nome, Email, Centro/Ente, Messaggio), stato di successo
- **Navbar** — Sticky con glassmorphism on-scroll, nav links con hover underline animato, CTA gradient, hamburger menu mobile
- **Footer** — Layout responsivo, links con hover, copyright dinamico
- **Componenti riutilizzabili** — `AnimatedSection`, `FeatureCard`, `SectionTitle`, `ContactForm`
- **Animazioni** — `flutter_animate` + `VisibilityDetector` per scroll-triggered fade-in/slide-up su tutte le sezioni
- **Responsive** — Breakpoints mobile (<600px), tablet (600-1024px), desktop (>1024px)
- **Docker** — Dockerfile multi-stage (Flutter build → nginx), docker-compose.yml, nginx.conf con SPA fallback e gzip
- **Assets** — Logo Autify (varianti light, dark, int) copiati dal progetto principale

#### Configurazione
- Flutter 3.41.9, Dart 3.11.5
- Dipendenze: `flutter_animate ^4.5.2`, `google_fonts ^6.2.1`, `url_launcher ^6.3.1`, `visibility_detector ^0.4.0+2`
- Git remote: `https://github.com/RazorCopter/Autify-web`

#### Risolto
- 🐛 **Dockerfile**: Rimosso il parametro deprecato `--web-renderer canvaskit` dal comando di build di Flutter, risolvendo l'errore di compilazione con codice di uscita 64 introdotto nelle ultime versioni di Flutter.

---

## Legenda
- 🎉 Release
- ✨ Nuova funzionalità
- 🐛 Bug fix
- 🎨 UI/UX miglioramento
- ♻️ Refactoring
- 📦 Dipendenze
- 🔧 Configurazione
- 📝 Documentazione
