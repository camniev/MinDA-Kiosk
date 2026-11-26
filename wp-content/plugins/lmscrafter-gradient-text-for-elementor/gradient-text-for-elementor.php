<?php
/**
 * Plugin Name:       LMSCrafter Gradient Text for Elementor
 * Plugin URI:        https://lmscrafter.com/
 * Description:       Gradient text widgets and opt-in effects for Elementor with visual stops, reusable Brand Gradients, animation, highlights, and accessibility fallbacks.
 * Version:           2.0.0
 * Author:            LMS Crafter
 * Author URI:        https://lmscrafter.com
 * License:           GPL-2.0+
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       lmscrafter-gradient-text-for-elementor
 * Requires Plugins:  elementor

 * Requires at least: 5.6
 * Requires PHP:      7.4
 * Elementor tested up to: 4.2.2
 *
 * @package LMSC_GTE
 * @since   1.0.0
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Plugin version constant.
 *
 * @since 1.0.0
 */
define( 'LMSC_GTE_VERSION', '2.0.0' );

/**
 * Plugin directory path.
 *
 * @since 1.0.0
 */
define( 'LMSC_GTE_PLUGIN_DIR', plugin_dir_path( __FILE__ ) );

/**
 * Plugin directory URL.
 *
 * @since 1.0.0
 */
define( 'LMSC_GTE_PLUGIN_URL', plugin_dir_url( __FILE__ ) );

// Load the site-level Brand Gradients library before Elementor controls are
// registered so widgets and native extensions can populate their selectors.
require_once LMSC_GTE_PLUGIN_DIR . 'includes/brand-gradients/bootstrap.php';
\LMSC_GTE\Brand_Gradients\bootstrap();

/**
 * Minimum required Elementor version.
 *
 * Bumped in 1.7.1 — Elementor 3.15 covers the controls and widget APIs
 * this plugin depends on and matches the floor most modern Elementor
 * addons use. Sites still on Elementor 3.x earlier than 3.15 will see
 * a clear admin notice instead of cryptic runtime errors.
 *
 * @since 1.0.0
 */
define( 'LMSC_GTE_MIN_ELEMENTOR_VERSION', '3.15.0' );

/**
 * Check if Elementor is active and meets the minimum version requirement.
 *
 * @since 1.0.0
 *
 * @return bool True if Elementor is ready, false otherwise.
 */
function lmsc_gte_check_elementor() {
	if ( ! did_action( 'elementor/loaded' ) ) {
		add_action( 'admin_notices', 'lmsc_gte_missing_elementor_notice' );
		return false;
	}

	if ( ! version_compare( ELEMENTOR_VERSION, LMSC_GTE_MIN_ELEMENTOR_VERSION, '>=' ) ) {
		add_action( 'admin_notices', 'lmsc_gte_outdated_elementor_notice' );
		return false;
	}

	return true;
}

/**
 * Display admin notice when Elementor is not installed or activated.
 *
 * @since 1.0.0
 *
 * @return void
 */
function lmsc_gte_missing_elementor_notice() {
	if ( ! current_user_can( 'activate_plugins' ) ) {
		return;
	}
	?>
	<div class="notice notice-error is-dismissible">
		<p>
			<strong><?php esc_html_e( 'LMSCrafter Gradient Text for Elementor', 'lmscrafter-gradient-text-for-elementor' ); ?></strong>
			<?php esc_html_e( 'requires Elementor to be installed and activated.', 'lmscrafter-gradient-text-for-elementor' ); ?>
		</p>
	</div>
	<?php
}

/**
 * Display admin notice when Elementor version is too old.
 *
 * @since 1.0.0
 *
 * @return void
 */
function lmsc_gte_outdated_elementor_notice() {
	if ( ! current_user_can( 'activate_plugins' ) ) {
		return;
	}
	?>
	<div class="notice notice-error is-dismissible">
		<p>
			<strong><?php esc_html_e( 'LMSCrafter Gradient Text for Elementor', 'lmscrafter-gradient-text-for-elementor' ); ?></strong>
			<?php
			printf(
				/* translators: %s: Minimum Elementor version */
				esc_html__( 'requires Elementor %s or higher.', 'lmscrafter-gradient-text-for-elementor' ),
				esc_html( LMSC_GTE_MIN_ELEMENTOR_VERSION )
			);
			?>
		</p>
	</div>
	<?php
}

/**
 * Register all Gradient Text widgets with Elementor.
 *
 * @since 1.0.0
 *
 * @param \Elementor\Widgets_Manager $widgets_manager Elementor widgets manager instance.
 * @return void
 */
function lmsc_gte_register_widgets( $widgets_manager ) {
	// Load the shared gradient helper trait before any widget class that consumes it.
	$trait_path = LMSC_GTE_PLUGIN_DIR . 'includes/trait-gradient-helper.php';
	if ( file_exists( $trait_path ) ) {
		require_once $trait_path;
	}

	$widget_files = [
		'class-gradient-text-widget.php'        => '\LMSC_GTE\Widgets\Gradient_Text_Widget',
		'class-gradient-text-editor-widget.php' => '\LMSC_GTE\Widgets\Gradient_Text_Editor_Widget',
	];

	foreach ( $widget_files as $file => $class ) {
		$file_path = LMSC_GTE_PLUGIN_DIR . 'widgets/' . $file;
		if ( file_exists( $file_path ) ) {
			require_once $file_path;
			if ( class_exists( $class ) ) {
				$widgets_manager->register( new $class() );
			}
		}
	}
}

/**
 * Register the gradient text dynamic tag.
 *
 * Lets users drop gradient text into any Elementor field that
 * supports dynamic content (heading titles, button labels, etc.).
 *
 * @since 1.8.0
 *
 * @param \Elementor\Core\DynamicTags\Manager $dynamic_tags_manager Elementor dynamic tags manager.
 * @return void
 */
function lmsc_gte_register_dynamic_tags( $dynamic_tags_manager ) {
	$trait_path = LMSC_GTE_PLUGIN_DIR . 'includes/trait-gradient-helper.php';
	$tag_path   = LMSC_GTE_PLUGIN_DIR . 'includes/class-gradient-text-tag.php';

	if ( ! file_exists( $trait_path ) || ! file_exists( $tag_path ) ) {
		return;
	}

	require_once $trait_path;
	require_once $tag_path;

	if ( class_exists( '\LMSC_GTE\Dynamic_Tags\Gradient_Text_Tag' ) ) {
		$dynamic_tags_manager->register( new \LMSC_GTE\Dynamic_Tags\Gradient_Text_Tag() );
	}
}

/**
 * Register a custom widget category for Gradient Text widgets.
 *
 * @since 1.0.0
 *
 * @param \Elementor\Elements_Manager $elements_manager Elementor elements manager instance.
 * @return void
 */
function lmsc_gte_register_category( $elements_manager ) {
	$elements_manager->add_category(
		'gradient-text',
		[
			'title' => esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
			'icon'  => 'eicon-font',
		]
	);
}

/**
 * Register the frontend stylesheet without enqueueing it.
 *
 * Each widget declares the handle in `get_style_depends()`, so Elementor
 * will enqueue the file only on pages that actually use a gradient widget.
 * This keeps unrelated Elementor pages from loading the stylesheet.
 *
 * @since 1.7.0
 *
 * @return void
 */
function lmsc_gte_register_styles() {
	wp_register_style(
		'lmsc-gte-gradient-text',
		LMSC_GTE_PLUGIN_URL . 'assets/css/gradient-text.css',
		[],
		LMSC_GTE_VERSION
	);
}

/**
 * Enqueue the stylesheet directly inside the Elementor editor.
 *
 * The editor preview can render any widget at any time, so we always
 * load the stylesheet there regardless of widget usage.
 *
 * @since 1.0.0
 *
 * @return void
 */
function lmsc_gte_enqueue_editor_styles() {
	wp_enqueue_style(
		'lmsc-gte-gradient-text',
		LMSC_GTE_PLUGIN_URL . 'assets/css/gradient-text.css',
		[],
		LMSC_GTE_VERSION
	);
}

/**
 * Enqueue the shared live-preview gradient builder in Elementor editing UI.
 *
 * @since 2.0.0
 *
 * @return void
 */
function lmsc_gte_enqueue_editor_scripts() {
	wp_enqueue_script(
		'lmsc-gte-gradient-preview',
		LMSC_GTE_PLUGIN_URL . 'assets/js/gradient-editor-preview.js',
		[],
		LMSC_GTE_VERSION,
		true
	);
}

/**
 * Enqueue the shared stylesheet whenever Elementor renders the frontend.
 *
 * The plugin exposes both a dynamic tag and utility CSS classes, neither of
 * which appears in Elementor's widget dependency graph. Loading this small
 * stylesheet on Elementor-rendered pages keeps those entry points reliable
 * without adding it to unrelated non-Elementor pages.
 *
 * @since 2.0.0
 *
 * @return void
 */
function lmsc_gte_enqueue_frontend_styles() {
	wp_enqueue_style(
		'lmsc-gte-gradient-text',
		LMSC_GTE_PLUGIN_URL . 'assets/css/gradient-text.css',
		[],
		LMSC_GTE_VERSION
	);
}

/**
 * Load the plugin text domain for translations.
 *
 * Required for self-hosted distributions; on WordPress.org translations
 * load automatically via translate.wordpress.org but this hook keeps
 * other distribution paths working too.
 *
 * @since 1.7.0
 *
 * @return void
 */
function lmsc_gte_load_textdomain() {
	load_plugin_textdomain( // phpcs:ignore PluginCheck.CodeAnalysis.DiscouragedFunctions.load_plugin_textdomainFound -- Retained for self-hosted packages that ship translations outside translate.wordpress.org.
		'lmscrafter-gradient-text-for-elementor',
		false,
		dirname( plugin_basename( __FILE__ ) ) . '/languages'
	);
}

/**
 * Initialize the plugin after all plugins are loaded.
 *
 * Checks Elementor dependency, then hooks widget registration,
 * category registration, and style registration.
 *
 * @since 1.0.0
 *
 * @return void
 */
function lmsc_gte_init() {
	if ( ! lmsc_gte_check_elementor() ) {
		return;
	}

	$native_extension_path = LMSC_GTE_PLUGIN_DIR . 'includes/class-native-widget-gradient-extension.php';
	if ( file_exists( $native_extension_path ) ) {
		require_once $native_extension_path;
		$native_extension = new \LMSC_GTE\Native_Widgets\Native_Widget_Gradient_Extension();
		$native_extension->register();
	}

	add_action( 'elementor/widgets/register', 'lmsc_gte_register_widgets' );
	add_action( 'elementor/elements/categories_registered', 'lmsc_gte_register_category' );
	add_action( 'elementor/dynamic_tags/register', 'lmsc_gte_register_dynamic_tags' );
	add_action( 'elementor/frontend/after_register_styles', 'lmsc_gte_register_styles' );
	add_action( 'elementor/frontend/after_enqueue_styles', 'lmsc_gte_enqueue_frontend_styles' );
	add_action( 'elementor/editor/after_enqueue_styles', 'lmsc_gte_enqueue_editor_styles' );
	add_action( 'elementor/editor/after_enqueue_scripts', 'lmsc_gte_enqueue_editor_scripts' );
	add_action( 'elementor/preview/enqueue_scripts', 'lmsc_gte_enqueue_editor_scripts' );
}
add_action( 'plugins_loaded', 'lmsc_gte_init' );
add_action( 'init', 'lmsc_gte_load_textdomain' );

/**
 * Add a section to WordPress Site Health → Info reporting plugin status.
 *
 * Surfaces the plugin version, the detected Elementor version, whether
 * the textdomain has loaded, and whether the dynamic tag is wired up.
 * Helps support requests resolve faster — users can paste the section
 * straight into a ticket.
 *
 * @since 1.8.0
 *
 * @param array $info Existing debug-info sections.
 * @return array Modified debug-info sections.
 */
function lmsc_gte_site_health_info( $info ) {
	$elementor_version = defined( 'ELEMENTOR_VERSION' ) ? ELEMENTOR_VERSION : __( 'Not detected', 'lmscrafter-gradient-text-for-elementor' );
	$textdomain_loaded = is_textdomain_loaded( 'lmscrafter-gradient-text-for-elementor' )
		? __( 'Yes', 'lmscrafter-gradient-text-for-elementor' )
		: __( 'No (translations may not work)', 'lmscrafter-gradient-text-for-elementor' );

	$info['lmsc-gte'] = [
		'label'       => __( 'Gradient Text for Elementor', 'lmscrafter-gradient-text-for-elementor' ),
		'description' => __( 'Diagnostic information for the LMSCrafter Gradient Text for Elementor plugin. Useful when filing a support request.', 'lmscrafter-gradient-text-for-elementor' ),
		'fields'      => [
			'plugin_version'    => [
				'label' => __( 'Plugin version', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => LMSC_GTE_VERSION,
			],
			'elementor_version' => [
				'label' => __( 'Elementor version detected', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => $elementor_version,
			],
			'min_elementor'     => [
				'label' => __( 'Minimum required Elementor', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => LMSC_GTE_MIN_ELEMENTOR_VERSION,
			],
			'textdomain'        => [
				'label' => __( 'Textdomain loaded', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => $textdomain_loaded,
			],
			'preset_count'      => [
				'label' => __( 'Built-in presets', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => '20 (extensible via the lmsc_gte_preset_gradients filter)',
			],
			'dynamic_tag'       => [
				'label' => __( 'Dynamic tag registered', 'lmscrafter-gradient-text-for-elementor' ),
				'value' => class_exists( '\LMSC_GTE\Dynamic_Tags\Gradient_Text_Tag' )
					? __( 'Yes', 'lmscrafter-gradient-text-for-elementor' )
					: __( 'No (will register when Elementor loads)', 'lmscrafter-gradient-text-for-elementor' ),
			],
		],
	];

	return $info;
}
add_filter( 'debug_information', 'lmsc_gte_site_health_info' );
