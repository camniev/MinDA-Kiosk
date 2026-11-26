<?php
/**
 * Gradient controls for Elementor's native text widgets.
 *
 * This module extends only Elementor's Heading, Text Editor, and Button
 * widgets. It does not replace their render methods or alter their content.
 * Elementor generates the per-element custom-property declarations while a
 * shared stylesheet applies those properties to an explicit selector
 * allowlist.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Native_Widgets;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Add opt-in gradient typography controls to selected native widgets.
 *
 * @since 2.0.0
 */
final class Native_Widget_Gradient_Extension {

	/** Frontend stylesheet handle. */
	const STYLE_HANDLE = 'lmsc-gte-native-widgets';

	/** Controls section ID. */
	const SECTION_ID = 'lmsc_gte_native_gradient_section';

	/**
	 * Whether hooks have already been registered.
	 *
	 * @var bool
	 */
	private $registered = false;

	/**
	 * Elementor builds each control stack once, but the generic section hook
	 * fires after every section. Track stacks so the extension section is added
	 * exactly once even when an Elementor version exposes multiple compatible
	 * anchor IDs.
	 *
	 * Object references are retained for the request so PHP cannot recycle an
	 * object hash and accidentally suppress a later control stack.
	 *
	 * @var array<string, object>
	 */
	private $extended_stacks = [];

	/**
	 * Return the deliberately narrow native-widget and selector allowlist.
	 *
	 * The section IDs and markup selectors are present in Elementor 3.15 and
	 * Elementor 4.2.2. Alternative section IDs are included only as defensive
	 * compatibility anchors; selectors are not guessed at runtime.
	 *
	 * @return array<string, array{sections: string[], selectors: string[]}>
	 */
	public static function get_supported_widgets(): array {
		return [
			'heading'     => [
				'sections'  => [ 'section_title_style', 'section_style' ],
				'selectors' => [ '.elementor-heading-title', '.elementor-heading-title > a' ],
			],
			'text-editor' => [
				'sections'  => [ 'section_style', 'section_text_style' ],
				'selectors' => [ '> .elementor-widget-container', '.elementor-text-editor' ],
			],
			'button'      => [
				'sections'  => [ 'section_style', 'section_button_style' ],
				'selectors' => [ '.elementor-button-text' ],
			],
		];
	}

	/**
	 * Register Elementor and stylesheet hooks once.
	 *
	 * @return void
	 */
	public function register() {
		if ( $this->registered ) {
			return;
		}

		$this->registered = true;

		add_action( 'elementor/element/after_section_end', [ $this, 'register_controls' ], 10, 3 );
		add_action( 'elementor/frontend/after_register_styles', [ $this, 'register_style' ], 20 );
		add_action( 'elementor/frontend/after_enqueue_styles', [ $this, 'enqueue_style' ], 20 );
		add_action( 'elementor/editor/after_enqueue_styles', [ $this, 'enqueue_style' ], 20 );
		add_action( 'elementor/preview/enqueue_styles', [ $this, 'enqueue_style' ], 20 );
		if ( function_exists( 'add_filter' ) ) {
			add_filter( 'elementor/files/css/property', [ $this, 'filter_brand_gradient_css_property' ], 10, 4 );
		}
	}

	/**
	 * Keep a deleted or malformed saved Brand Gradient ID from reaching
	 * Elementor's generated CSS as a raw custom-property value.
	 *
	 * Elementor applies selectors_dictionary only for an exact key. This filter
	 * runs on the actual saved value during CSS generation, including values that
	 * no longer exist in the current central library.
	 *
	 * @param mixed  $value        Control value after dictionary substitution.
	 * @param string $css_property CSS declaration template.
	 * @param array  $matches      Elementor placeholder matches.
	 * @param array  $control      Elementor control definition.
	 * @return mixed Valid gradient fallback for this control; unchanged otherwise.
	 */
	public function filter_brand_gradient_css_property( $value, $css_property, $matches, $control ) { // phpcs:ignore Generic.CodeAnalysis.UnusedFunctionParameter.FoundAfterLastUsed
		if ( ! is_array( $control ) || 'lmsc_gte_native_brand_gradient' !== ( $control['name'] ?? '' ) ) {
			return $value;
		}

		if ( is_string( $value ) && preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $value ) ) {
			return $value;
		}

		return 'linear-gradient(90deg, #FF512F, #DD2476)';
	}

	/**
	 * Register the shared stylesheet.
	 *
	 * @return void
	 */
	public function register_style() {
		if ( ! defined( 'LMSC_GTE_PLUGIN_URL' ) || ! defined( 'LMSC_GTE_VERSION' ) ) {
			return;
		}

		if ( function_exists( 'wp_style_is' ) && wp_style_is( self::STYLE_HANDLE, 'registered' ) ) {
			return;
		}

		wp_register_style(
			self::STYLE_HANDLE,
			LMSC_GTE_PLUGIN_URL . 'assets/css/native-widget-gradient.css',
			[ 'lmsc-gte-gradient-text' ],
			LMSC_GTE_VERSION
		);
	}

	/**
	 * Enqueue the shared stylesheet for Elementor frontend/editor surfaces.
	 *
	 * The file contains no widget-specific values and is intentionally small.
	 * Per-widget values remain in Elementor's generated CSS.
	 *
	 * @return void
	 */
	public function enqueue_style() {
		$this->register_style();
		wp_enqueue_style( self::STYLE_HANDLE );
	}

	/**
	 * Add controls after a known native-widget style section.
	 *
	 * @param object $element    Elementor controls stack.
	 * @param string $section_id Section that has just closed.
	 * @param array  $args       Hook arguments supplied by Elementor.
	 * @return void
	 */
	public function register_controls( $element, $section_id, $args = [] ) { // phpcs:ignore Generic.CodeAnalysis.UnusedFunctionParameter.FoundAfterLastUsed
		if ( ! is_object( $element ) || ! method_exists( $element, 'get_name' ) ) {
			return;
		}

		$widget_name = (string) $element->get_name();
		$supported   = self::get_supported_widgets();

		if ( ! isset( $supported[ $widget_name ] ) ) {
			return;
		}

		if ( ! in_array( (string) $section_id, $supported[ $widget_name ]['sections'], true ) ) {
			return;
		}

		$stack_key = $widget_name . ':' . ( function_exists( 'spl_object_hash' ) ? spl_object_hash( $element ) : self::SECTION_ID );
		if ( isset( $this->extended_stacks[ $stack_key ] ) ) {
			return;
		}

		// Set the guard before ending our own section, because that action can
		// re-enter the generic after_section_end hook on some Elementor builds.
		$this->extended_stacks[ $stack_key ] = $element;

		$this->add_gradient_controls( $element );
	}

	/**
	 * Return curated preset names and their CSS color lists.
	 *
	 * Values are color lists, not complete gradients, so type and direction
	 * controls remain available for every preset.
	 *
	 * @return array<string, array{label: string, colors: string}>
	 */
	public static function get_presets(): array {
		$presets = [
			'sunset'          => [
				'label'  => esc_html__( 'Sunset', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#FF512F, #DD2476',
			],
			'ocean'           => [
				'label'  => esc_html__( 'Ocean', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#2E3192, #1BFFFF',
			],
			'forest'          => [
				'label'  => esc_html__( 'Forest', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#11998E, #38EF7D',
			],
			'fire'            => [
				'label'  => esc_html__( 'Fire', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#F12711, #F5AF19',
			],
			'purple_rain'     => [
				'label'  => esc_html__( 'Purple Rain', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#7F00FF, #E100FF',
			],
			'northern_lights' => [
				'label'  => esc_html__( 'Northern Lights', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#43CEA2, #185A9D',
			],
			'rose_gold'       => [
				'label'  => esc_html__( 'Rose Gold', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#B76E79, #F4D4C8',
			],
			'cyber'           => [
				'label'  => esc_html__( 'Cyber', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => '#F72585, #7209B7, #3A0CA3',
			],
		];

		/**
		 * Filter native-widget preset definitions.
		 *
		 * Keep each `colors` value to a comma-separated list of valid CSS colors.
		 *
		 * @param array $presets Presets keyed by a machine-safe slug.
		 */
		$filtered = function_exists( 'apply_filters' )
			? apply_filters( 'lmsc_gte_native_widget_presets', $presets )
			: $presets;

		if ( ! is_array( $filtered ) ) {
			return $presets;
		}

		$validated = [];
		foreach ( $filtered as $key => $preset ) {
			if ( ! is_string( $key ) || ! is_array( $preset ) || ! isset( $preset['colors'] ) ) {
				continue;
			}

			$clean_key = function_exists( 'sanitize_key' )
				? sanitize_key( $key )
				: strtolower( (string) preg_replace( '/[^a-z0-9_-]/i', '', $key ) );
			$colors = self::sanitize_preset_color_list( $preset['colors'] );
			if ( '' === $clean_key || '' === $colors ) {
				continue;
			}

			$label = isset( $preset['label'] ) && is_scalar( $preset['label'] )
				? (string) $preset['label']
				: ucwords( str_replace( [ '-', '_' ], ' ', $clean_key ) );
			$clean_label = function_exists( 'sanitize_text_field' )
				? sanitize_text_field( $label )
				: ( function_exists( 'wp_strip_all_tags' ) ? wp_strip_all_tags( $label ) : preg_replace( '/<[^>]*>/', '', $label ) );
			$validated[ $clean_key ] = [
				'label'  => trim( (string) $clean_label ),
				'colors' => $colors,
			];
		}

		return ! empty( $validated ) ? $validated : $presets;
	}

	/**
	 * Validate a native preset's comma-separated color list.
	 *
	 * @param mixed $value Filtered preset value.
	 * @return string Safe CSS color list, or an empty string when invalid.
	 */
	private static function sanitize_preset_color_list( $value ): string {
		if ( ! is_scalar( $value ) ) {
			return '';
		}

		$parts = preg_split( '/,(?![^()]*\))/', (string) $value, -1, PREG_SPLIT_NO_EMPTY );
		if ( ! is_array( $parts ) || count( $parts ) < 2 || count( $parts ) > 5 ) {
			return '';
		}

		$colors = [];
		foreach ( $parts as $part ) {
			$color = self::sanitize_preset_color( trim( $part ) );
			if ( '' === $color ) {
				return '';
			}
			$colors[] = $color;
		}

		return implode( ', ', $colors );
	}

	/**
	 * Validate one CSS color accepted by native preset dictionaries.
	 *
	 * @param string $color Candidate color.
	 * @return string Safe color, or an empty string when invalid.
	 */
	private static function sanitize_preset_color( string $color ): string {
		if ( preg_match( '/^#(?:[a-f0-9]{3}|[a-f0-9]{4}|[a-f0-9]{6}|[a-f0-9]{8})$/i', $color )
			|| preg_match( '/^var\(--e-global-color-[a-z0-9_-]+\)$/i', $color ) ) {
			return $color;
		}

		$number  = '-?(?:\d+(?:\.\d+)?|\.\d+)';
		$rgb     = $number . '%?';
		$alpha   = '(?:0|1(?:\.0+)?|0?\.\d+|(?:' . $number . ')%)';
		$hue     = $number . '(?:deg|grad|rad|turn)?';
		$percent = $number . '%';

		if ( preg_match( '/^rgb\(\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $rgb . '\s*\)$/i', $color )
			|| preg_match( '/^rgba\(\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $alpha . '\s*\)$/i', $color )
			|| preg_match( '/^hsl\(\s*' . $hue . '\s*,\s*' . $percent . '\s*,\s*' . $percent . '\s*\)$/i', $color )
			|| preg_match( '/^hsla\(\s*' . $hue . '\s*,\s*' . $percent . '\s*,\s*' . $percent . '\s*,\s*' . $alpha . '\s*\)$/i', $color )
			|| preg_match( '/^rgba?\(\s*' . $rgb . '\s+' . $rgb . '\s+' . $rgb . '(?:\s*\/\s*' . $alpha . ')?\s*\)$/i', $color )
			|| preg_match( '/^hsla?\(\s*' . $hue . '\s+' . $percent . '\s+' . $percent . '(?:\s*\/\s*' . $alpha . ')?\s*\)$/i', $color ) ) {
			return $color;
		}

		return '';
	}

	/**
	 * Add all extension controls to an Elementor controls stack.
	 *
	 * @param object $element Elementor controls stack.
	 * @return void
	 */
	private function add_gradient_controls( $element ) {
		$controls = '\\Elementor\\Controls_Manager';

		$element->start_controls_section(
			self::SECTION_ID,
			[
				'label' => esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
				'tab'   => $controls::TAB_STYLE,
			]
		);

		$element->add_control(
			'lmsc_gte_native_enabled',
			[
				'label'        => esc_html__( 'Enable Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'label_on'     => esc_html__( 'On', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'Off', 'lmscrafter-gradient-text-for-elementor' ),
				'return_value' => 'yes',
				'default'      => '',
				'prefix_class' => 'lmsc-gte-native-enabled-',
				'description'  => esc_html__( 'Applies the effect to this widget\'s text without replacing its native content or markup.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$enabled = [ 'lmsc_gte_native_enabled' => 'yes' ];

		$element->add_control(
			'lmsc_gte_native_source',
			[
				'label'        => esc_html__( 'Source', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SELECT,
				'default'      => 'preset',
				'options'      => [
					'preset' => esc_html__( 'Preset Palette', 'lmscrafter-gradient-text-for-elementor' ),
					'brand'  => esc_html__( 'Saved Brand Gradient', 'lmscrafter-gradient-text-for-elementor' ),
					'custom' => esc_html__( 'Custom Colors', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'prefix_class' => 'lmsc-gte-native-source-',
				'condition'    => $enabled,
			]
		);

		$brand_options        = [];
		$brand_css_dictionary = [];
		if ( function_exists( 'lmsc_gte_get_brand_gradient_options' ) && function_exists( 'lmsc_gte_get_brand_gradient_css' ) ) {
			foreach ( (array) lmsc_gte_get_brand_gradient_options() as $brand_id => $brand_label ) {
				$brand_id  = sanitize_key( (string) $brand_id );
				$brand_css = lmsc_gte_get_brand_gradient_css( $brand_id );
				if ( '' === $brand_id || ! is_string( $brand_css ) || ! preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $brand_css ) ) {
					continue;
				}
				$brand_options[ $brand_id ]        = sanitize_text_field( (string) $brand_label );
				$brand_css_dictionary[ $brand_id ] = $brand_css;
			}
		}

		// Elementor substitutes dictionary values only for exact keys. A saved
		// Brand Gradient can outlive its centrally managed record, so map that
		// canonical orphan to a complete gradient instead of allowing the raw ID
		// to become an invalid CSS value and leave clipped text transparent.
		$is_type_instance = method_exists( $element, 'is_type_instance' ) && $element->is_type_instance();
		if ( ! $is_type_instance && method_exists( $element, 'get_settings' ) ) {
			$saved_brand = $element->get_settings( 'lmsc_gte_native_brand_gradient' );
			if ( is_scalar( $saved_brand ) ) {
				$saved_brand = (string) $saved_brand;
				$clean_brand = sanitize_key( $saved_brand );
				if ( '' !== $clean_brand && $saved_brand === $clean_brand && ! isset( $brand_css_dictionary[ $clean_brand ] ) ) {
					$brand_css_dictionary[ $clean_brand ] = 'linear-gradient(90deg, #FF512F, #DD2476)';
				}
			}
		}

		$element->add_control(
			'lmsc_gte_native_brand_gradient',
			[
				'label'                => esc_html__( 'Brand Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'type'                 => $controls::SELECT,
				'options'              => $brand_options,
				'selectors_dictionary' => $brand_css_dictionary,
				'selectors'            => [
					'{{WRAPPER}}' => '--lmsc-gte-native-brand-gradient: {{VALUE}};',
				],
				'condition'            => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source'  => 'brand',
				],
				'description'          => esc_html__( 'Managed centrally in Settings → Brand Gradients.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$presets             = self::get_presets();
		$preset_options       = [];
		$preset_css_dictionary = [];
		foreach ( $presets as $key => $preset ) {
			if ( ! is_array( $preset ) || empty( $preset['label'] ) || empty( $preset['colors'] ) ) {
				continue;
			}
			$preset_options[ $key ]        = $preset['label'];
			$preset_css_dictionary[ $key ] = $preset['colors'];
		}

		$element->add_control(
			'lmsc_gte_native_preset',
			[
				'label'                => esc_html__( 'Preset', 'lmscrafter-gradient-text-for-elementor' ),
				'type'                 => $controls::SELECT,
				'default'              => 'sunset',
				'options'              => $preset_options,
				'selectors_dictionary' => $preset_css_dictionary,
				'selectors'            => [
					'{{WRAPPER}}' => '--lmsc-gte-native-preset-colors: {{VALUE}};',
				],
				'condition'            => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source'  => 'preset',
				],
			]
		);

		$element->add_control(
			'lmsc_gte_native_color_1',
			[
				'label'     => esc_html__( 'Color 1', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::COLOR,
				'default'   => '#FF512F',
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-color-1: {{VALUE}};',
				],
				'condition' => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source'  => 'custom',
				],
			]
		);

		$element->add_control(
			'lmsc_gte_native_color_2',
			[
				'label'     => esc_html__( 'Color 2', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::COLOR,
				'default'   => '#DD2476',
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-color-2: {{VALUE}};',
				],
				'condition' => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source'  => 'custom',
				],
			]
		);

		$element->add_control(
			'lmsc_gte_native_type',
			[
				'label'        => esc_html__( 'Gradient Type', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SELECT,
				'default'      => 'linear',
				'options'      => [
					'linear' => esc_html__( 'Linear', 'lmscrafter-gradient-text-for-elementor' ),
					'radial' => esc_html__( 'Radial', 'lmscrafter-gradient-text-for-elementor' ),
					'conic'  => esc_html__( 'Conic', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'prefix_class' => 'lmsc-gte-native-type-',
				'condition'    => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source!' => 'brand',
				],
			]
		);

		$direction_options = [
			'to_right'        => '→ ' . esc_html__( 'Left to Right', 'lmscrafter-gradient-text-for-elementor' ),
			'to_left'         => '← ' . esc_html__( 'Right to Left', 'lmscrafter-gradient-text-for-elementor' ),
			'to_bottom'       => '↓ ' . esc_html__( 'Top to Bottom', 'lmscrafter-gradient-text-for-elementor' ),
			'to_top'          => '↑ ' . esc_html__( 'Bottom to Top', 'lmscrafter-gradient-text-for-elementor' ),
			'to_bottom_right' => '↘ ' . esc_html__( 'Top Left to Bottom Right', 'lmscrafter-gradient-text-for-elementor' ),
			'to_bottom_left'  => '↙ ' . esc_html__( 'Top Right to Bottom Left', 'lmscrafter-gradient-text-for-elementor' ),
			'to_top_right'    => '↗ ' . esc_html__( 'Bottom Left to Top Right', 'lmscrafter-gradient-text-for-elementor' ),
			'to_top_left'     => '↖ ' . esc_html__( 'Bottom Right to Top Left', 'lmscrafter-gradient-text-for-elementor' ),
			'custom'          => esc_html__( 'Custom Angle', 'lmscrafter-gradient-text-for-elementor' ),
		];

		$element->add_responsive_control(
			'lmsc_gte_native_direction',
			[
				'label'                => esc_html__( 'Direction', 'lmscrafter-gradient-text-for-elementor' ),
				'type'                 => $controls::SELECT,
				'default'              => 'to_right',
				'tablet_default'       => 'to_right',
				'mobile_default'       => 'to_right',
				'options'              => $direction_options,
				'selectors_dictionary' => [
					'to_top'          => '0',
					'to_top_right'    => '45',
					'to_right'        => '90',
					'to_bottom_right' => '135',
					'to_bottom'       => '180',
					'to_bottom_left'  => '225',
					'to_left'         => '270',
					'to_top_left'     => '315',
					'custom'          => '90',
				],
				'selectors'            => [
					'{{WRAPPER}}' => '--lmsc-gte-native-angle: {{VALUE}}deg;',
				],
				'condition'            => [
					'lmsc_gte_native_enabled' => 'yes',
					'lmsc_gte_native_source!' => 'brand',
					'lmsc_gte_native_type!'   => 'radial',
				],
			]
		);

		$element->add_responsive_control(
			'lmsc_gte_native_angle',
			[
				'label'      => esc_html__( 'Custom Angle', 'lmscrafter-gradient-text-for-elementor' ),
				'type'       => $controls::SLIDER,
				'size_units' => [ 'deg' ],
				'default'    => [
					'size' => 90,
					'unit' => 'deg',
				],
				'range'      => [
					'deg' => [
						'min'  => 0,
						'max'  => 360,
						'step' => 1,
					],
				],
				'selectors'  => [
					'{{WRAPPER}}' => '--lmsc-gte-native-angle: {{SIZE}}deg;',
				],
				'condition'  => [
					'lmsc_gte_native_enabled'   => 'yes',
					'lmsc_gte_native_source!'   => 'brand',
					'lmsc_gte_native_type!'     => 'radial',
					'lmsc_gte_native_direction' => 'custom',
				],
			]
		);

		$element->add_control(
			'lmsc_gte_native_fallback_color',
			[
				'label'       => esc_html__( 'Solid Fallback Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => $controls::COLOR,
				'default'     => '#333333',
				'selectors'   => [
					'{{WRAPPER}}' => '--lmsc-gte-native-fallback: {{VALUE}};',
				],
				'condition'   => $enabled,
				'description' => esc_html__( 'Used when gradient clipping is unavailable, disabled for a device, or overridden by accessibility settings.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$element->add_control(
			'lmsc_gte_native_hover_heading',
			[
				'label'     => esc_html__( 'Hover', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::HEADING,
				'separator' => 'before',
				'condition' => $enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_hover_enabled',
			[
				'label'        => esc_html__( 'Hover Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'return_value' => 'yes',
				'default'      => '',
				'prefix_class' => 'lmsc-gte-native-hover-',
				'condition'    => $enabled,
			]
		);

		$hover_enabled = [
			'lmsc_gte_native_enabled'       => 'yes',
			'lmsc_gte_native_hover_enabled' => 'yes',
		];

		$element->add_control(
			'lmsc_gte_native_hover_color_1',
			[
				'label'     => esc_html__( 'Hover Color 1', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::COLOR,
				'default'   => '#11998E',
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-hover-color-1: {{VALUE}};',
				],
				'condition' => $hover_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_hover_color_2',
			[
				'label'     => esc_html__( 'Hover Color 2', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::COLOR,
				'default'   => '#38EF7D',
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-hover-color-2: {{VALUE}};',
				],
				'condition' => $hover_enabled,
			]
		);

		$element->add_responsive_control(
			'lmsc_gte_native_hover_transition',
			[
				'label'      => esc_html__( 'Hover Transition', 'lmscrafter-gradient-text-for-elementor' ),
				'type'       => $controls::SLIDER,
				'size_units' => [ 's' ],
				'default'    => [
					'size' => 0.3,
					'unit' => 's',
				],
				'range'      => [
					's' => [
						'min'  => 0,
						'max'  => 2,
						'step' => 0.05,
					],
				],
				'selectors'  => [
					'{{WRAPPER}}' => '--lmsc-gte-native-transition: {{SIZE}}s;',
				],
				'condition'  => $hover_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_animation_heading',
			[
				'label'     => esc_html__( 'Animation', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::HEADING,
				'separator' => 'before',
				'condition' => $enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_animation_enabled',
			[
				'label'        => esc_html__( 'Animate Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'return_value' => 'yes',
				'default'      => '',
				'prefix_class' => 'lmsc-gte-native-animation-',
				'condition'    => $enabled,
			]
		);

		$animation_enabled = [
			'lmsc_gte_native_enabled'           => 'yes',
			'lmsc_gte_native_animation_enabled' => 'yes',
		];

		$element->add_responsive_control(
			'lmsc_gte_native_animation_direction',
			[
				'label'                => esc_html__( 'Animation Direction', 'lmscrafter-gradient-text-for-elementor' ),
				'type'                 => $controls::SELECT,
				'default'              => 'horizontal',
				'tablet_default'       => 'horizontal',
				'mobile_default'       => 'horizontal',
				'options'              => [
					'none'       => esc_html__( 'No Animation', 'lmscrafter-gradient-text-for-elementor' ),
					'horizontal' => esc_html__( 'Horizontal', 'lmscrafter-gradient-text-for-elementor' ),
					'vertical'   => esc_html__( 'Vertical', 'lmscrafter-gradient-text-for-elementor' ),
					'diagonal'   => esc_html__( 'Diagonal', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors_dictionary' => [
					'none'       => 'none',
					'horizontal' => 'lmsc-gte-native-flow-horizontal',
					'vertical'   => 'lmsc-gte-native-flow-vertical',
					'diagonal'   => 'lmsc-gte-native-flow-diagonal',
				],
				'selectors'            => [
					'{{WRAPPER}}' => '--lmsc-gte-native-animation-name: {{VALUE}};',
				],
				'condition'            => $animation_enabled,
			]
		);

		$element->add_responsive_control(
			'lmsc_gte_native_animation_speed',
			[
				'label'      => esc_html__( 'Animation Speed', 'lmscrafter-gradient-text-for-elementor' ),
				'type'       => $controls::SLIDER,
				'size_units' => [ 's' ],
				'default'    => [
					'size' => 5,
					'unit' => 's',
				],
				'range'      => [
					's' => [
						'min'  => 1,
						'max'  => 30,
						'step' => 0.5,
					],
				],
				'selectors'  => [
					'{{WRAPPER}}' => '--lmsc-gte-native-animation-speed: {{SIZE}}s;',
				],
				'condition'  => $animation_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_animation_easing',
			[
				'label'     => esc_html__( 'Easing', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::SELECT,
				'default'   => 'ease',
				'options'   => [
					'linear'      => esc_html__( 'Linear', 'lmscrafter-gradient-text-for-elementor' ),
					'ease'        => esc_html__( 'Ease', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-in'     => esc_html__( 'Ease In', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-out'    => esc_html__( 'Ease Out', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-in-out' => esc_html__( 'Ease In Out', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-animation-easing: {{VALUE}};',
				],
				'condition' => $animation_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_animation_iterations',
			[
				'label'     => esc_html__( 'Repeat', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::SELECT,
				'default'   => 'infinite',
				'options'   => [
					'1'        => esc_html__( 'Once', 'lmscrafter-gradient-text-for-elementor' ),
					'2'        => esc_html__( 'Twice', 'lmscrafter-gradient-text-for-elementor' ),
					'3'        => esc_html__( 'Three Times', 'lmscrafter-gradient-text-for-elementor' ),
					'infinite' => esc_html__( 'Continuous', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-native-animation-iterations: {{VALUE}};',
				],
				'condition' => $animation_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_pause_on_hover',
			[
				'label'        => esc_html__( 'Pause on Hover or Focus', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'return_value' => 'yes',
				'default'      => 'yes',
				'prefix_class' => 'lmsc-gte-native-pause-',
				'condition'    => $animation_enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_accessibility_heading',
			[
				'label'     => esc_html__( 'Accessibility & Responsive', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => $controls::HEADING,
				'separator' => 'before',
				'condition' => $enabled,
			]
		);

		$element->add_responsive_control(
			'lmsc_gte_native_responsive_effect',
			[
				'label'                => esc_html__( 'Gradient on This Device', 'lmscrafter-gradient-text-for-elementor' ),
				'type'                 => $controls::SELECT,
				'default'              => 'on',
				'tablet_default'       => 'on',
				'mobile_default'       => 'on',
				'options'              => [
					'on'  => esc_html__( 'On', 'lmscrafter-gradient-text-for-elementor' ),
					'off' => esc_html__( 'Use Solid Fallback', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors_dictionary' => [
					'on'  => 'transparent',
					'off' => 'var(--lmsc-gte-native-fallback)',
				],
				'selectors'            => [
					'{{WRAPPER}}' => '--lmsc-gte-native-effect-fill: {{VALUE}};',
				],
				'condition'            => $enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_reduced_motion',
			[
				'label'        => esc_html__( 'Respect Reduced Motion', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'return_value' => 'yes',
				'default'      => 'yes',
				'prefix_class' => 'lmsc-gte-native-reduced-motion-',
				'condition'    => $enabled,
			]
		);

		$element->add_control(
			'lmsc_gte_native_forced_colors',
			[
				'label'        => esc_html__( 'Readable in Forced Colors', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => $controls::SWITCHER,
				'return_value' => 'yes',
				'default'      => 'yes',
				'prefix_class' => 'lmsc-gte-native-forced-colors-',
				'condition'    => $enabled,
				'description'  => esc_html__( 'Uses the system text color in Windows High Contrast and other forced-color modes.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$element->end_controls_section();
	}
}
