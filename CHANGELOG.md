# Changelog — Autify Web Landing Page

Tutte le modifiche significative al progetto sono documentate in questo file.
Il formato è basato su [Keep a Changelog](https://keepachangelog.com/it/1.0.0/).

---

## [2.0.0] — 2026-05-29

### 🚀 Major Redesign
- **Nuovo Layout Split-Screen Hero**: Sostituita la precedente hero text-only con un layout più dinamico a doppia colonna, valorizzato dall'immagine `tablet_doctor.png`.
- **Showcase Section**: Aggiunta una nuova sezione dedicata alla riprova sociale con contatori animati e l'immagine `presentation_vertical.png` su sfondo scuro per maggior contrasto.
- **Features & Value Ridisegnate**: Le card features sono state ridotte e impilate a lato del mockup dashboard `hologram_dashboard.png`. La sezione statistiche è ora un layout orizzontale molto più pulito, sovrastato dal banner `presentation_wide.png`.
- **UI/UX Refinements**: Aggiornato il design system con ombre più profonde, gradienti marcati, e rimozione delle vecchie immagini fuori posto dalla contact section in favore di una nuova *trust bar*.

---

## [1.0.3] — 2026-05-29

### 🎨 UI/UX Miglioramento
- **Integrazione Immagini**: Aggiunte le foto ad alta qualità fornite per migliorare l'impatto visivo della landing page:
  - `hologram_dashboard.png` inserita come elemento fluttuante nella Hero Section.
  - `presentation_wide.png` integrata come intestazione panoramica del pannello statistiche nella Value Section.
  - `tablet_doctor.png` aggiunta sopra ai contatti nella Contact Section per rendere la sezione più accogliente.

---

## [1.0.2] — 2026-05-29

### Risolto
- 🐛 **Docker Compose**: Cambiata la porta host predefinita da `8082` a `8085` per evitare conflitti con altri servizi locali già attivi sulla porta 8082.

---

## [1.0.1] — 2026-05-29

### Risolto
- 🐛 **Dockerfile**: Rimosso il parametro deprecato `--web-renderer canvaskit` dal comando di build di Flutter, risolvendo l'errore di compilazione con codice di uscita 64 nelle ultime versioni del Flutter SDK.

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
