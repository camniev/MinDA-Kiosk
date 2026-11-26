=== LMSCrafter Gradient Text for Elementor ===
Contributors: mmubashirtaqi, lmscrafter
Tags: gradient text, elementor, gradient heading, text gradient, color text
Requires at least: 5.6
Tested up to: 7.0
Requires PHP: 7.4
Requires Plugins: elementor
Stable tag: 2.0.0
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Create reusable gradient text in Elementor with a visual builder, Brand Gradients, animation, highlights, and accessible fallbacks. No Pro required.

== Description ==

= How to Add Gradient Text in Elementor =

Looking for a simple way to **add gradient text in Elementor** without writing CSS or buying Elementor Pro? **LMSCrafter Gradient Text for Elementor** is the solution.

This focused plugin adds two dedicated gradient text widgets and optional gradient controls for Elementor's Heading, Text Editor, and Button widgets. Choose a preset, build a multi-stop gradient visually, or reuse a centrally managed Brand Gradient. No custom CSS or Elementor Pro is required.

= Why Choose LMSCrafter Gradient Text for Elementor? =

Most gradient text solutions require Elementor Pro custom CSS or a large general-purpose addon suite. This plugin stays focused on **gradient text for Elementor** and the controls needed to make it reusable, responsive, and readable.

= Two Powerful Widgets =

* **Gradient Text** - Perfect for gradient headings, titles, and short text. Supports H1-H6, p, span, and div tags with optional link wrapping.
* **Gradient Text Editor** - A full WYSIWYG rich text editor with gradient support. Add gradient effects to paragraphs, bold text, italic text, lists, and any formatted content.

= 20 Beautiful Preset Gradient Palettes =

Get started instantly with curated gradient presets:

* **Sunset** - Warm orange to pink
* **Ocean** - Deep blue to cyan
* **Forest** - Teal to green
* **Fire** - Red to orange
* **Purple Rain** - Violet to magenta
* **Cherry Blossom** - Pink floral
* **Northern Lights** - Green to blue aurora
* **Citrus** - Orange to yellow
* **Frost** - Icy blue gradient
* **Rose Gold** - Warm metallic blush
* **Midnight** - Dark teal
* **Candy** - Purple to cyan
* **Neon** - Electric green to blue
* **Peach** - Peach to coral
* **Royal** - Deep purple
* **Bubblegum** - Playful pink
* **Aurora** - Cyan to green
* **Cyber** - Vibrant pink to purple (3-color)
* **Warm Flame** - Orange flame
* **Mango** - Yellow to orange

= Full Customization =

* **Visual Gradient Builder** - Add, reorder, color, and position 2-5 stops while the Elementor canvas previews the result
* **Saved Brand Gradients** - Manage reusable linear, radial, and conic gradients centrally, including Elementor Global Color references and JSON import/export
* **Existing Elementor Widgets** - Opt in from the Style tab of Heading, Text Editor, and Button widgets without replacing their content
* **Custom Gradient Colors** - Pick your own colors with up to 5 color stops
* **Linear, Radial & Conic Gradients** - Control angle, radial shape, and radial position
* **Multiple Highlighted Phrases** - Build an ordered heading from plain and gradient segments
* **Gradient Pill Effect** - Add a gradient pill background behind highlighted words
* **Gradient Underline** - Thick gradient underline bar beneath highlighted words
* **Gradient Marker** - Highlighter pen effect on highlighted words
* **Gradient Glow** - Soft gradient glow effect behind highlighted words
* **Animated Gradient** - Flowing, shifting gradient animation with speed and direction controls
* **Text Stroke Gradient** - Apply gradient to text outline for stunning hollow text effects
* **Hover Effects** - Add a different gradient on hover for interactive text
* **Full Typography Control** - Font family, size, weight, letter spacing, and text shadow
* **Responsive Alignment** - Set different alignment for desktop, tablet, and mobile
* **Responsive Motion** - Change direction or pause animation by device
* **Accessible Fallbacks** - Solid fallback colors, keyboard focus, reduced-motion support, and forced-colors readability
* **Link Support** - Make your gradient text a clickable link

= Works with Elementor Free =

Unlike custom CSS methods that require Elementor Pro, this plugin works with the **free version of Elementor**. No Pro license needed!

= Lightweight & Conflict-Free =

* Single-purpose plugin that does one thing perfectly
* Properly namespaced code (prefixed with `lmsc-gte-`) to avoid conflicts with themes and other plugins
* No jQuery dependency, no external API calls, and one WordPress option for saved Brand Gradients
* Frontend effects use CSS; a small JavaScript helper is loaded only in the Elementor editor for live preview
* Designed to inherit normal theme typography and work alongside standard Elementor widget markup

= Support =

Need help? Visit our [Support Center](https://lmscrafter.com/support-center/) for documentation and assistance.

= For Developers =

The plugin exposes a `lmsc_gte_preset_gradients` filter so theme and plugin authors can register custom presets without forking:

`add_filter( 'lmsc_gte_preset_gradients', function ( $presets ) {`
`    $presets['brand'] = [`
`        'label'  => __( 'Brand', 'my-theme' ),`
`        'colors' => [ '#0a3d62', '#3c6382' ],`
`    ];`
`    return $presets;`
`} );`

A "Gradient Text" dynamic tag is also registered under Elementor's Site group. Use it in text fields that preserve dynamic-tag HTML output; fields that deliberately escape HTML will show plain markup instead. The plugin now loads its shared fallback stylesheet even when a page uses only the dynamic tag or a preset utility class.

== Installation ==

= How to Install LMSCrafter Gradient Text for Elementor =

1. Upload the `lmscrafter-gradient-text-for-elementor` folder to `/wp-content/plugins/`
2. Activate the plugin through the **Plugins** menu in WordPress
3. Make sure **Elementor** (free or Pro) is installed and active
4. Edit any page with Elementor
5. Search for "Gradient Text" in the widget panel
6. Drag the widget onto your page and start customizing!

== Frequently Asked Questions ==

= How do I add gradient text in Elementor? =

Install and activate this plugin, then edit any page with Elementor. Search for "Gradient Text" in the widget panel, drag the widget onto your page, and choose a preset gradient or create a custom one. No CSS knowledge required!

= Does this gradient text plugin require Elementor Pro? =

No! This plugin works with the free version of Elementor. You don't need Elementor Pro to create gradient text.

= Can I add gradient to paragraph text, not just headings? =

Yes! The **Gradient Text Editor** widget provides a full WYSIWYG rich text editor with gradient support. You can add gradient effects to paragraphs, lists, bold text, and any formatted content.

= Can I use more than two gradient colors? =

Yes. In custom mode you can enable up to **five color stops**, so you can build anything from a simple two-color gradient all the way to vivid multi-stop rainbow effects.

= Does it support responsive design? =

Yes. Text alignment, gradient direction, animation direction, animation state, and animation travel can be adjusted by device where applicable.

= Will this plugin slow down my website? =

The frontend effect is CSS-based and has no jQuery or external API dependency. A small preview helper runs only inside Elementor editing screens. As with any plugin, measure the result with your own theme, page, and optimization stack.

= Will this plugin conflict with my theme or other plugins? =

The plugin uses prefixed CSS classes and PHP functions. Its native-widget feature adds an opt-in Style section only to Elementor Heading, Text Editor, and Button widgets; it does not replace their render methods or change their content when the feature is disabled.

= Can I add animated gradient text in Elementor? =

Yes. Enable the "Gradient Animation" toggle in the Style tab to add a flowing color animation. You can control the animation speed (1–20 seconds), choose horizontal, vertical, or diagonal movement, limit repetitions, and pause motion by device or user preference. The frontend animation is CSS-based and does not require JavaScript.

= What is the difference between Gradient Text and Gradient Text Editor? =

**Gradient Text** is a heading-style widget, perfect for titles, H1-H6 tags, and short gradient text. **Gradient Text Editor** is a WYSIWYG-based widget, perfect for longer content, paragraphs, lists, and rich formatted text with gradient effects.

== Screenshots ==

1. Two gradient text widgets in Elementor — Gradient Text and Gradient Text Editor
2. Gradient text examples using several built-in palettes
3. Visual Gradient Builder with five reorderable color stops and a live canvas preview
4. Saved Brand Gradients library for reusable linear, radial, and conic palettes with JSON import/export
5. Opt-in Gradient Text controls on Elementor's native Heading, Text Editor, and Button widgets
6. Multiple highlighted phrases built from ordered plain and gradient text segments
7. Animated gradient text with adjustable speed, direction, easing, repetitions, and motion preferences
8. Gradient Pill examples for highlighted words

== Changelog ==

= 2.0.0 =
* New: Visual gradient-stop builder with draggable 2-5 color rows and live Elementor canvas preview
* New: Saved Brand Gradients library with linear, radial, and conic geometry, Elementor Global Color tokens, and validated JSON import/export
* New: Opt-in gradient controls for Elementor Heading, Text Editor, and Button widgets
* New: Ordered multi-highlight heading segments for several gradient phrases in one heading
* New: Responsive gradient and animation direction controls, per-device animation state, finite repeats, and pause-on-hover/focus
* Improved: Solid fallback color, forced-colors mode, reduced-motion handling, and accessible-label support
* Fixed: Dynamic-tag-only and utility-class-only Elementor pages now receive the required stylesheet
* Fixed: Highlight mode now receives the same hover, animation, and stroke behavior as full-text mode
* Fixed: Hover effects use scoped CSS custom properties instead of emitting repeated per-widget style elements
* Fixed: Malformed preset filters, functional colors, negative angles, and negative stop positions are safely rejected or clamped
* Compatibility: Verified control registration and rendering with Elementor 4.2.2 and PHP 8.2

= 1.9.0 =
* Added: Direction picker for linear and conic gradients — choose common directions (left to right, top to bottom, diagonals) without guessing angles; Custom Angle keeps the slider
* Added: Color Position sliders (0-100%) for every custom and hover color, controlling how much space each color takes in the gradient
* Improved: Angle slider now explains the CSS angle convention (0° = bottom to top, 90° = left to right, 180° = top to bottom)
* Note: Fully backward compatible — existing widgets render exactly as before

= 1.8.2 =
* Improved: Confirmed compatibility with WordPress 7.0

= 1.8.1 =
* Improved: Updated plugin banner and icon assets with new premium PNG designs
* Improved: Asset quality — replaced compressed JPG banner and GIF icon with high-resolution PNG versions

= 1.8.0 =
* New: Gradient Text **Dynamic Tag** — drop gradient text into any Elementor field that supports dynamic content (heading titles, button labels, post titles in loops, image captions, custom HTML, etc.) without dragging a dedicated widget.
* New: **Conic gradient** support — `conic-gradient(from <angle>, …)` joins linear and radial as a third gradient type for sweeping color-wheel effects on text.
* New: **Animation easing** control — choose from Linear, Ease, Ease In, Ease Out, or Ease In-Out for animated gradients (was hardcoded `ease`).
* New: Site Health debug panel section — exposes plugin version, detected Elementor version, textdomain status, and dynamic tag registration so support tickets can be diagnosed faster.

= 1.7.1 =
* Fixed: Highlight spans (none, underline, glow modes) no longer render invisible on browsers without `background-clip: text` support — added a `@supports not` CSS fallback that recovers them to a readable solid color.
* Improved: Minimum required Elementor version raised from 3.0.0 to 3.15.0 — old, unmaintained Elementor installs now see a clean admin notice instead of risking runtime errors.
* Fixed: FAQ now correctly states that custom gradients support up to five color stops (was outdated and said three).

= 1.7.0 =
* Improved: Internal refactor — preset palette, color sanitization, and gradient builder consolidated into a shared trait. Both widgets now share a single source of truth (~400 fewer duplicated lines).
* Improved: Frontend stylesheet now loads conditionally — only on pages that actually use a gradient widget. Pages without the widget skip the request entirely.
* Improved: Color sanitization now uses WordPress core sanitize_hex_color() for hex values, with a tightened functional-notation regex.
* Improved: PHP type hints added across the gradient helper trait for better IDE support and earlier error detection.
* Improved: Gradient Text Editor now defaults to the same "Sunset" preset as the Gradient Text widget for a consistent first-run experience.
* Improved: CSS @supports gating ensures non-webkit browsers see a visible fallback color instead of invisible transparent text.
* Improved: :focus-visible outline added for keyboard users on linked gradient text.
* Added: load_plugin_textdomain() hook so translations work for self-hosted distributions, not just WordPress.org.
* Added: lmsc_gte_preset_gradients filter — themes and developers can register custom palettes without forking the plugin.
* Added: LICENSE.txt, CHANGELOG.md, and .gitignore for proper repository hygiene.

= 1.6.0 =
* New: Support for 4th and 5th color stops in custom gradients — create stunning rainbow and multi-color effects
* New: 20 ready-to-use preset CSS classes (e.g. lmsc-gte-gradient-sunset) — apply gradient text to any Elementor widget via Advanced > CSS Classes
* New: SEO-friendly plain text fallback via render_plain_content() for search engines, RSS feeds, and screen readers
* Improved: Accessibility — gradient animations now respect prefers-reduced-motion browser setting
* Improved: CSS version bumped to 1.6.0

= 1.5.0 =
* Improved: Redesigned highlighted text UX with intuitive 3-field layout (Before Text / Gradient Text / After Text)
* Fixed: Hover effect not working — replaced wp_add_inline_style with inline style output (timing issue)
* Fixed: Pill, Underline, Marker, Glow effects now use direct inline styles for full browser compatibility
* Fixed: Text selectability in Elementor editor when using full gradient mode
* Improved: All highlight effects now render correctly in both frontend and Elementor live preview
* Improved: Simplified CSS — removed redundant CSS-variable-based rules
* Verified: Full code sanitization audit passed (esc_html, esc_attr, sanitize_color, absint, wp_kses_post)

= 1.4.0 =
* New: Highlighted Text feature — apply gradient to specific words within a heading
* New: Gradient Pill effect — gradient background pill behind highlighted words
* New: Gradient Underline effect — thick gradient bar beneath highlighted words
* New: Gradient Marker effect — highlighter pen effect on highlighted words
* New: Gradient Glow effect — soft gradient glow behind highlighted words
* New: Base Text Color control for non-highlighted text
* New: Highlight padding, border radius, and underline height controls
* Fixed: Rose Gold preset now uses actual rose gold colors (was hot pink)
* Fixed: Cherry Blossom preset now uses vibrant pink tones (was washed out)
* Fixed: Peach preset now uses visible peach-to-coral colors (was too light)
* Fixed: Aurora preset now uses cyan-to-green like real aurora (was pastel)
* Fixed: Warm Flame preset now uses orange flame colors (was pastel pink)
* Fixed: Midnight preset now uses dark teal gradient (was invisible gray)
* Fixed: Royal preset now uses deep purple gradient (was invisible navy)
* Fixed: Frost preset now uses icy blue gradient (was too dark)

= 1.3.1 =
* Improved: Optimized plugin tags for better WordPress.org search discoverability
* New: Animated gradient plugin icon for WordPress.org directory

= 1.3.0 =
* New: Animated gradient effect with flowing color animation (CSS-only, no JavaScript)
* New: Animation speed control (1-20 seconds)
* New: Animation direction control (horizontal, vertical, diagonal)
* New: Text stroke/outline gradient mode (Fill, Stroke, or Both)
* New: Stroke width control (1-10px)
* New: 8 additional gradient presets (Neon, Peach, Royal, Bubblegum, Aurora, Cyber, Warm Flame, Mango)
* Total of 20 curated gradient presets
* Updated prefix references in documentation

= 1.2.0 =
* New: Gradient Text Editor widget with WYSIWYG rich text support
* Improved: Color value sanitization for enhanced security
* Improved: Defensive widget loading to prevent fatal errors
* Improved: Full PHPDoc documentation on all functions and methods
* Improved: XSS prevention in editor template
* Added: Security index.php files in all directories
* Added: uninstall.php for clean uninstallation
* Added: Capability checks on admin notices
* Added: Translation support with load_plugin_textdomain

= 1.0.0 =
* Initial release
* 12 preset gradient palettes
* Custom gradient with up to 3 color stops
* Linear and radial gradient types
* Hover gradient effect
* Full typography and text shadow controls
* Responsive alignment
* Link support
