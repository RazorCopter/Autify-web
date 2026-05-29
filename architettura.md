# Architettura — Autify Web Landing Page

> **Memoria operativa** del progetto. Questo documento traccia tutte le decisioni architetturali, le strategie tecniche, le funzionalità implementate e le note di contesto per non perdere mai il filo del lavoro.

---

## 📋 Panoramica Progetto

| Campo | Valore |
|-------|--------|
| **Nome** | Autify Web — Landing Page |
| **Tipo** | Flutter Web SPA (Single Page Application) |
| **Framework** | Flutter 3.41.9 / Dart 3.11.5 |
| **Stile** | Premium Light, minimalista |
| **Repo** | [github.com/RazorCopter/Autify-web](https://github.com/RazorCopter/Autify-web) |
| **Deploy** | Docker (nginx) su Portainer |
| **Dominio** | autify.it |

---

## 🏗️ Struttura del Progetto

```
autify-web/
├── lib/
│   ├── main.dart                    # Entry point, MaterialApp
│   ├── theme/
│   │   ├── app_colors.dart          # Palette colori, gradienti, ombre
│   │   └── app_theme.dart           # ThemeData, tipografia, breakpoints
│   ├── widgets/                     # Componenti riutilizzabili
│   │   ├── animated_section.dart    # Wrapper scroll-triggered animation
│   │   ├── navbar.dart              # Navbar sticky + glassmorphism
│   │   ├── feature_card.dart        # Card feature con hover
│   │   ├── section_title.dart       # Titolo sezione con accento
│   │   ├── contact_form.dart        # Form contatto validato
│   │   └── footer.dart              # Footer responsivo
│   ├── sections/                    # Sezioni della landing page
│   │   ├── hero_section.dart        # Hero full-viewport
│   │   ├── features_section.dart    # Griglia features
│   │   ├── value_section.dart       # Proposta di valore
│   │   └── contact_section.dart     # Contatti + form
│   └── pages/
│       └── landing_page.dart        # Assemblaggio pagina
├── assets/
│   └── images/
│       ├── autify_logo.png          # Logo con sfondo chiaro
│       ├── logo_autify_int.png      # Logo senza sfondo (per hero)
│       └── logo_autify_dark.png     # Logo scuro (per navbar/footer)
├── web/
│   └── index.html                   # Shell HTML con meta SEO
├── Dockerfile                       # Multi-stage build
├── docker-compose.yml               # Orchestrazione container
├── nginx.conf                       # Config server web
├── CHANGELOG.md                     # Registro modifiche
├── architettura.md                  # Questo file
└── pubspec.yaml                     # Dipendenze Flutter
```

---

## 🎨 Design System

### Palette Colori (estratta dal logo)

Il logo Autify rappresenta un cervello stilizzato con elementi di data analytics (grafici, nodi neurali, puzzle, DNA). I colori dominanti sono:

| Ruolo | Nome | Hex | Uso |
|-------|------|-----|-----|
| Primary Dark | Deep Navy | `#1A2B50` | Testo principale, navbar, footer bg |
| Primary Blue | Royal Blue | `#2B6CB0` | CTA, link, accenti primari |
| Primary Light | Sky Blue | `#4A90D9` | Hover states, variante chiara |
| Accent Teal | Teal/Cyan | `#38A89D` | Accenti secondari, icone feature |
| Accent Green | Emerald | `#48BB78` | Feature "Efficienza", successo |
| Accent Orange | Warm Orange | `#ED8936` | Feature "Scale", attenzione |
| Accent Coral | Coral | `#E8705A` | Errori, alert |
| Background | Ice White | `#F7FAFC` | Sfondo pagina |
| Surface | Pure White | `#FFFFFF` | Card, form inputs |
| Border | Light Gray | `#E2E8F0` | Bordi sottili |

### Gradienti
- **Hero**: Bianco → Azzurro chiaro → Ice white (verticale)
- **CTA**: Blue → Teal (diagonale top-left → bottom-right)
- **Dark Section**: Navy → Charcoal (diagonale)
- **Primary**: Blue → Teal (per accenti decorativi)

### Ombre (BoxShadow)
- **Soft**: `navy @ 6% opacity, blur 24, offset y:8` — Card normali
- **Medium**: `navy @ 8%, blur 32, offset y:12` — Elementi in evidenza
- **Hover**: `blue @ 15%, blur 40, offset y:16` — Card in hover

### Tipografia

| Elemento | Font | Size | Weight | Note |
|----------|------|------|--------|------|
| H1 Hero | Outfit | 56px (mobile 34px) | 700 | Letter-spacing -1 |
| H2 Sezione | Outfit | 40px (mobile 28px) | 700 | |
| H3 Card | Outfit | 20px | 600 | |
| Body Large | Inter | 18px | 400 | Line-height 1.7 |
| Body | Inter | 16px | 400 | Line-height 1.6 |
| Caption | Inter | 14px | 400 | Color: textMuted |
| Button | Inter | 16px | 600 | Letter-spacing 0.3-0.5 |

---

## 🧩 Componenti

### `AnimatedSection`
- **Strategia**: `VisibilityDetector` monitora quando il widget entra nel viewport (threshold 15%)
- **Una volta visibile**: attiva `flutter_animate` con fadeIn + moveY
- **Parametri configurabili**: delay, duration, slideOffset
- **Nota**: l'animazione si attiva solo una volta (no reverse on scroll-out)

### `Navbar`
- **Glassmorphism**: Il background diventa traslucido (`surface @ 85%`) dopo 50px di scroll
- **Stato scroll**: Riceve `scrollOffset` dal parent `LandingPage`
- **Mobile**: Usa `PopupMenuButton` per il menu hamburger
- **Desktop**: Nav links con underline animato al hover + CTA gradient button
- **Scroll-to**: Usa `Scrollable.ensureVisible()` con durata 800ms e curva `easeInOutCubic`

### `FeatureCard`
- **Hover**: Eleva la card di 4px (`translate Y -4`), cambia shadow a `hoverShadow`, bordo con accent color
- **Icon container**: Background con gradient dell'accent color, opacità aumenta al hover
- **Layout**: Icona → Titolo → Descrizione, padding 32px

### `ContactForm`
- **Campi**: Nome, Email, Centro/Ente, Messaggio
- **Validazione**: Campi obbligatori + regex email
- **Layout**: Desktop = Nome+Email in riga, Mobile = tutto stacked
- **Submit**: Simula API call (1s delay), mostra spinner, poi stato successo
- **Stato successo**: Card con icona check, messaggio di conferma

---

## 📐 Sezioni della Pagina

### 1. Hero Section
- **Layout**: Full-viewport (92% screen height)
- **Background**: `heroGradient` (white → azzurro → ice white)
- **Contenuto**: Logo (animate scale+fade) → H1 → Subtitle → 2x CTA → Scroll indicator
- **Decorazioni**: 4 blob/dot floating con animazioni loop (moveY/moveX 3-5 secondi)
- **Scroll indicator**: Mouse icon con animazione bounce loop

### 2. Features Section
- **Layout**: `GridView` con 2 colonne desktop, 1 mobile
- **Card**: 4 feature con icone Material, colori accent diversificati
- **Animazione**: Stagger 150ms per card (0, 150, 300, 450ms)
- **Aspect ratio**: Desktop 1.35, Tablet 1.15, Mobile 1.4

### 3. Value Section
- **Layout desktop**: Split 5:4 (testo a sx, stats a dx)
- **Layout mobile**: Stacked
- **Stats panel**: 3 metriche con icone colorate (3 scale, 100% tracciabilità, -60% tempo)
- **Chips**: "Dashboard in tempo reale", "Report AI", "GDPR Compliant"
- **Animazione**: Testo slide-in da sinistra, stats da destra

### 4. Contact Section
- **Background**: `darkGradient` (navy → charcoal)
- **Layout desktop**: Split 4:5 (info a sx, form a dx)
- **Info**: Titolo, descrizione, email, sito, badge GDPR
- **Form**: Integrato nel componente `ContactForm`

### 5. Footer
- **Background**: Navy pieno con border-top blue @ 20%
- **Desktop**: Logo+copyright a sx, links a dx
- **Mobile**: Centrato stacked
- **Links**: Privacy Policy, Termini di Servizio, info@autify.it

---

## ⚡ Strategia Animazioni

### Libreria: `flutter_animate ^4.5.2`
Scelta per la sua API dichiarativa e il supporto nativo per catene di animazione.

### Pattern scroll-triggered
```
VisibilityDetector (threshold 15%)
  → setState(_isVisible = true)
    → flutter_animate .fadeIn() + .moveY()
```

### Tempistiche
| Sezione | Tipo | Duration | Delay | Curve |
|---------|------|----------|-------|-------|
| Hero Logo | scale + fade | 800ms | 0ms | easeOutBack |
| Hero H1 | fade + moveY | 800ms | 200ms | easeOutCubic |
| Hero Subtitle | fade + moveY | 700ms | 450ms | easeOutCubic |
| Hero CTA | fade + moveY | 700ms | 650ms | easeOutCubic |
| Feature Cards | fade + moveY | 700ms | 150ms × index | easeOutCubic |
| Value Text | fade + moveX | 700ms | 0ms | easeOutCubic |
| Value Stats | fade + moveX | 700ms | 200ms | easeOutCubic |
| Contact | fade + moveY | 700ms | 0-200ms | easeOutCubic |

### Animazioni loop (decorazioni)
- Blob floating: moveY 15-20px, 4-5 secondi, easeInOut, repeat(reverse)
- Dot accent: moveY/moveX 8-10px, 3-3.5 secondi, easeInOut, repeat(reverse)
- Scroll indicator: moveY 0→8px, 1.5 secondi, repeat(reverse)

---

## 🐳 Strategia Deployment

### Docker Multi-Stage Build
1. **Stage 1 (flutter-build)**: `ghcr.io/cirruslabs/flutter:stable`
   - Copia sorgenti, `flutter pub get`, `flutter build web --release --web-renderer canvaskit`
2. **Stage 2 (serve)**: `nginx:alpine`
   - Copia build artifacts da stage 1 in `/usr/share/nginx/html`
   - Applica `nginx.conf` personalizzato

### nginx.conf
- SPA fallback: `try_files $uri $uri/ /index.html`
- Gzip: abilitato per text, JS, CSS, JSON, SVG
- Cache: 30 giorni per assets statici (JS, CSS, immagini)
- Headers: `X-Frame-Options`, `X-Content-Type-Options` per sicurezza

### docker-compose.yml
- Servizio singolo `autify-web`
- Porta: `8080:80`
- Restart policy: `unless-stopped`
- Pronto per Portainer

---

## 📱 Strategia Responsive

| Breakpoint | Larghezza | Colonne Grid | Padding | Layout Speciale |
|------------|-----------|-------------|---------|-----------------|
| Mobile | < 600px | 1 | 20px | Stack verticale, menu hamburger |
| Tablet | 600–1024px | 2 | 40px | Grid 2 col, layout intermedio |
| Desktop | > 1024px | 2 | 80px | Split layout, max-width 1200px |

### Helper utilizzati
- `AppTheme.isMobile(context)` / `isTablet()` / `isDesktop()`
- `AppTheme.responsivePadding(context)` — restituisce padding laterale appropriato
- `MediaQuery.sizeOf(context)` — preferito a `MediaQuery.of(context).size` per performance

---

## 🔗 Dipendenze

| Package | Versione | Uso |
|---------|----------|-----|
| `flutter_animate` | ^4.5.2 | Animazioni dichiarative, scroll-triggered |
| `google_fonts` | ^6.2.1 | Font Inter + Outfit da Google Fonts CDN |
| `url_launcher` | ^6.3.1 | Apertura link esterni (email, sito) |
| `visibility_detector` | ^0.4.0+2 | Rilevamento visibilità per trigger animazioni |

---

## 📝 Note & Decisioni

### Perché Flutter Web e non HTML/React?
- Coerenza con l'ecosistema Autify (frontend_admin e frontend_client sono Flutter)
- Possibilità futura di condividere componenti tra landing e app
- CanvasKit renderer per rendering di alta qualità delle animazioni

### Perché `flutter_animate` e non `AnimationController`?
- API dichiarativa più leggibile e manutenibile
- Supporto nativo per catene e stagger
- Riduzione drastica del boilerplate rispetto a controller manuali

### Perché Google Fonts via CDN?
- Nessun font file da bundlare (riduce dimensione build)
- Cache CDN di Google per performance
- Fallback automatico se CDN non disponibile

### Perché nginx alpine?
- Immagine Docker ultraleggera (~5MB)
- Performance eccellente per servire static files
- Configurazione semplice per SPA fallback

---

## 🚧 TODO / Roadmap Futura

- [ ] Integrazione form contatto con backend API (POST endpoint)
- [ ] Aggiunta sezione "Testimonianze" / "Chi siamo"
- [ ] Implementazione i18n (Italiano/Inglese)
- [ ] Analytics integration (Google Analytics / Plausible)
- [ ] SEO: meta tags dinamici, sitemap.xml, robots.txt
- [ ] PWA: Service Worker per offline support
- [ ] A/B testing sulla hero copy
- [ ] Video demo embed nella hero o sezione dedicata
