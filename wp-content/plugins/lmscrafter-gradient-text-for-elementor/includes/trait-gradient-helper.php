<?php
/**
 * Gradient Helper Trait.
 *
 * Shared logic for gradient widgets — preset palette, color sanitization,
 * and CSS gradient string assembly. Both Gradient_Text_Widget and
 * Gradient_Text_Editor_Widget consume this trait so the gradient
 * pipeline lives in exactly one place.
 *
 * @package LMSC_GTE
 * @since   1.7.0
 */

namespace LMSC_GTE\Widgets;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Provides preset palette + gradient builder utilities to widget classes.
 *
 * @since 1.7.0
 */
trait Gradient_Helper {

	/**
	 * Cached preset gradients.
	 *
	 * @since 1.7.0
	 * @var array
	 */
	protected $presets = [];

	/**
	 * Get preset gradient definitions.
	 *
	 * Returns an associative array of curated gradient presets, each
	 * containing a translatable label and an array of hex color stops.
	 * Filterable via `lmsc_gte_preset_gradients` so themes / site-builders
	 * can add their own palette without forking the plugin.
	 *
	 * @since 1.7.0
	 *
	 * @return array Preset gradient definitions.
	 */
	protected function get_preset_gradients(): array {
		$presets = [
			'sunset'          => [
				'label'  => __( 'Sunset', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#FF512F', '#DD2476' ],
			],
			'ocean'           => [
				'label'  => __( 'Ocean', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#2E3192', '#1BFFFF' ],
			],
			'forest'          => [
				'label'  => __( 'Forest', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#11998e', '#38ef7d' ],
			],
			'fire'            => [
				'label'  => __( 'Fire', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#f12711', '#f5af19' ],
			],
			'purple_rain'     => [
				'label'  => __( 'Purple Rain', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#7F00FF', '#E100FF' ],
			],
			'cherry_blossom'  => [
				'label'  => __( 'Cherry Blossom', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#FF6B9D', '#C94C7C' ],
			],
			'northern_lights' => [
				'label'  => __( 'Northern Lights', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#43cea2', '#185a9d' ],
			],
			'citrus'          => [
				'label'  => __( 'Citrus', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#f7971e', '#ffd200' ],
			],
			'frost'           => [
				'label'  => __( 'Frost', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#0052D4', '#65C7F7' ],
			],
			'rose_gold'       => [
				'label'  => __( 'Rose Gold', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#B76E79', '#F4D4C8' ],
			],
			'midnight'        => [
				'label'  => __( 'Midnight', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#0F2027', '#2C5364' ],
			],
			'candy'           => [
				'label'  => __( 'Candy', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#D585FF', '#00FFEE' ],
			],
			'neon'            => [
				'label'  => __( 'Neon', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#00ff87', '#60efff' ],
			],
			'peach'           => [
				'label'  => __( 'Peach', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#FF9966', '#FF5E62' ],
			],
			'royal'           => [
				'label'  => __( 'Royal', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#1A0533', '#6441A5' ],
			],
			'bubblegum'       => [
				'label'  => __( 'Bubblegum', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#ff6a88', '#ff99ac' ],
			],
			'aurora'          => [
				'label'  => __( 'Aurora', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#00C9FF', '#92FE9D' ],
			],
			'cyber'           => [
				'label'  => __( 'Cyber', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#f72585', '#7209b7', '#3a0ca3' ],
			],
			'warm_flame'      => [
				'label'  => __( 'Warm Flame', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#FF6B35', '#F7931E' ],
			],
			'mango'           => [
				'label'  => __( 'Mango', 'lmscrafter-gradient-text-for-elementor' ),
				'colors' => [ '#ffe259', '#ffa751' ],
			],
		];

		/**
		 * Filter the list of preset gradients.
		 *
		 * @since 1.7.0
		 *
		 * @param array $presets Array of preset gradient definitions keyed by slug.
		 */
		$filtered = apply_filters( 'lmsc_gte_preset_gradients', $presets );

		if ( ! is_array( $filtered ) ) {
			return $presets;
		}

		$validated = [];
		foreach ( $filtered as $slug => $preset ) {
			if ( ! is_string( $slug ) || ! is_array( $preset ) || empty( $preset['colors'] ) || ! is_array( $preset['colors'] ) ) {
				continue;
			}

			$clean_slug = sanitize_key( $slug );
			$colors     = [];
			foreach ( array_slice( $preset['colors'], 0, 5 ) as $color ) {
				if ( ! is_scalar( $color ) ) {
					continue;
				}
				$colors[] = $this->sanitize_color( (string) $color );
			}

			if ( '' === $clean_slug || count( $colors ) < 2 ) {
				continue;
			}

			$validated[ $clean_slug ] = [
				'label'  => isset( $preset['label'] ) && is_scalar( $preset['label'] )
					? sanitize_text_field( (string) $preset['label'] )
					: ucwords( str_replace( [ '-', '_' ], ' ', $clean_slug ) ),
				'colors' => $colors,
			];
		}

		return ! empty( $validated ) ? $validated : $presets;
	}

	/**
	 * Sanitize a CSS color value.
	 *
	 * Accepts hex colors via WordPress core `sanitize_hex_color()`,
	 * plus rgb/rgba/hsl/hsla functional notation. Returns a safe
	 * default if the input cannot be validated.
	 *
	 * @since 1.7.0
	 *
	 * @param mixed $color The color value to sanitize.
	 * @return string Sanitized color value.
	 */
	protected function sanitize_color( $color ): string {
		if ( ! is_scalar( $color ) ) {
			return '#000000';
		}

		$color = trim( (string) $color );

		if ( '' === $color ) {
			return '#000000';
		}

		// Hex: defer to WordPress core for #RGB, #RGBA, #RRGGBB, #RRGGBBAA.
		if ( '#' === $color[0] ) {
			if ( function_exists( 'sanitize_hex_color' ) ) {
				$clean = sanitize_hex_color( $color );
				if ( ! empty( $clean ) ) {
					return $clean;
				}
			}
			// Fallback regex if core helper is unavailable for some reason.
			if ( preg_match( '/^#([A-Fa-f0-9]{3}|[A-Fa-f0-9]{4}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$/', $color ) ) {
				return $color;
			}
			return '#000000';
		}

		// Elementor global colors are stored as CSS custom properties. Only
		// accept Elementor's strictly-prefixed variable names; arbitrary CSS
		// functions remain disallowed.
		if ( preg_match( '/^var\(--e-global-color-[a-z0-9_-]+\)$/i', $color ) ) {
			return $color;
		}

		// The Brand Gradients library uses a compact global:<id> token in its
		// JSON export. Resolve it to Elementor's public CSS variable format.
		if ( preg_match( '/^global:([a-z0-9_-]+)$/i', $color, $matches ) ) {
			return 'var(--e-global-color-' . sanitize_key( $matches[1] ) . ')';
		}

		// Functional notation. Require the exact component count so malformed
		// input such as rgb(1,,2) cannot survive into a style attribute.
		$number = '-?(?:\d+(?:\.\d+)?|\.\d+)';
		$rgb    = $number . '%?';
		$alpha  = '(?:0|1(?:\.0+)?|0?\.\d+|(?:' . $number . ')%)';
		$hue    = $number . '(?:deg|grad|rad|turn)?';
		$percent = $number . '%';

		if ( preg_match( '/^rgb\(\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $rgb . '\s*\)$/i', $color )
			|| preg_match( '/^rgba\(\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $rgb . '\s*,\s*' . $alpha . '\s*\)$/i', $color )
			|| preg_match( '/^hsl\(\s*' . $hue . '\s*,\s*' . $percent . '\s*,\s*' . $percent . '\s*\)$/i', $color )
			|| preg_match( '/^hsla\(\s*' . $hue . '\s*,\s*' . $percent . '\s*,\s*' . $percent . '\s*,\s*' . $alpha . '\s*\)$/i', $color )
			|| preg_match( '/^rgba?\(\s*' . $rgb . '\s+' . $rgb . '\s+' . $rgb . '(?:\s*\/\s*' . $alpha . ')?\s*\)$/i', $color )
			|| preg_match( '/^hsla?\(\s*' . $hue . '\s+' . $percent . '\s+' . $percent . '(?:\s*\/\s*' . $alpha . ')?\s*\)$/i', $color ) ) {
			return $color;
		}

		return '#000000';
	}

	/**
	 * Map of direction preset keys to CSS gradient angles (degrees).
	 *
	 * CSS convention: 0deg points up, angles increase clockwise.
	 *
	 * @since 1.9.0
	 *
	 * @return array Direction => angle map.
	 */
	protected function get_direction_angles(): array {
		return [
			'to_top'          => 0,
			'to_top_right'    => 45,
			'to_right'        => 90,
			'to_bottom_right' => 135,
			'to_bottom'       => 180,
			'to_bottom_left'  => 225,
			'to_left'         => 270,
			'to_top_left'     => 315,
		];
	}

	/**
	 * Resolve the effective gradient angle from settings.
	 *
	 * Direction presets take precedence; 'custom' (and legacy widgets
	 * saved before the direction control existed) fall back to the
	 * angle slider, preserving backward compatibility.
	 *
	 * @since 1.9.0
	 *
	 * @param array $settings Widget settings array.
	 * @return int Angle in degrees (0-360).
	 */
	protected function resolve_angle( array $settings ): int {
		$directions = $this->get_direction_angles();
		$direction  = isset( $settings['gradient_direction'] ) ? (string) $settings['gradient_direction'] : 'custom';

		if ( isset( $directions[ $direction ] ) ) {
			return $directions[ $direction ];
		}

		$angle = isset( $settings['gradient_angle']['size'] ) ? (int) $settings['gradient_angle']['size'] : 90;
		return min( 360, max( 0, $angle ) );
	}

	/**
	 * Extract an optional color-stop position (percent) from a slider setting.
	 *
	 * Returns null when the slider was left empty, meaning the browser
	 * should distribute the stop automatically (previous behavior).
	 *
	 * @since 1.9.0
	 *
	 * @param array  $settings Widget settings array.
	 * @param string $key      Slider control key, e.g. 'color_1_stop'.
	 * @return int|null Stop position 0-100, or null for automatic.
	 */
	protected function get_stop_position( array $settings, string $key ) {
		if ( ! isset( $settings[ $key ]['size'] ) || '' === $settings[ $key ]['size'] || null === $settings[ $key ]['size'] ) {
			return null;
		}
		return min( 100, max( 0, (int) $settings[ $key ]['size'] ) );
	}

	/**
	 * Register the Direction + custom Angle controls.
	 *
	 * The direction dropdown covers the eight common cases with plain
	 * labels; "Custom Angle" reveals the raw slider. Existing widgets
	 * saved before 1.9.0 default to 'custom', so their stored angle
	 * keeps working unchanged.
	 *
	 * @since 1.9.0
	 *
	 * @param bool $responsive Whether Elementor should generate device-specific angle CSS.
	 * @return void
	 */
	protected function register_direction_controls( bool $responsive = true ) {
		$direction_args = [
			'label'                => esc_html__( 'Direction', 'lmscrafter-gradient-text-for-elementor' ),
			'type'                 => \Elementor\Controls_Manager::SELECT,
			'default'              => 'custom',
			'options'              => [
				'to_right'        => '→ ' . esc_html__( 'Left to Right', 'lmscrafter-gradient-text-for-elementor' ),
				'to_left'         => '← ' . esc_html__( 'Right to Left', 'lmscrafter-gradient-text-for-elementor' ),
				'to_bottom'       => '↓ ' . esc_html__( 'Top to Bottom', 'lmscrafter-gradient-text-for-elementor' ),
				'to_top'          => '↑ ' . esc_html__( 'Bottom to Top', 'lmscrafter-gradient-text-for-elementor' ),
				'to_bottom_right' => '↘ ' . esc_html__( 'Diagonal (Top-Left to Bottom-Right)', 'lmscrafter-gradient-text-for-elementor' ),
				'to_bottom_left'  => '↙ ' . esc_html__( 'Diagonal (Top-Right to Bottom-Left)', 'lmscrafter-gradient-text-for-elementor' ),
				'to_top_right'    => '↗ ' . esc_html__( 'Diagonal (Bottom-Left to Top-Right)', 'lmscrafter-gradient-text-for-elementor' ),
				'to_top_left'     => '↖ ' . esc_html__( 'Diagonal (Bottom-Right to Top-Left)', 'lmscrafter-gradient-text-for-elementor' ),
				'custom'          => esc_html__( 'Custom Angle', 'lmscrafter-gradient-text-for-elementor' ),
			],
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
				'{{WRAPPER}}' => '--lmsc-gte-gradient-angle: {{VALUE}}deg;',
			],
			'condition'            => [
				'gradient_type' => [ 'linear', 'conic' ],
			],
		];

		if ( $responsive ) {
			$this->add_responsive_control( 'gradient_direction', $direction_args );
		} else {
			unset( $direction_args['selectors'], $direction_args['selectors_dictionary'] );
			$this->add_control( 'gradient_direction', $direction_args );
		}

		$angle_args = [
			'label'       => esc_html__( 'Angle', 'lmscrafter-gradient-text-for-elementor' ),
			'description' => esc_html__( '0° = bottom to top, 90° = left to right, 180° = top to bottom, 270° = right to left. For conic gradients this sets the starting angle of the color sweep.', 'lmscrafter-gradient-text-for-elementor' ),
			'type'        => \Elementor\Controls_Manager::SLIDER,
			'size_units'  => [ 'deg' ],
			'default'     => [
				'size' => 90,
				'unit' => 'deg',
			],
			'range'       => [
				'deg' => [
					'min'  => 0,
					'max'  => 360,
					'step' => 1,
				],
			],
			'selectors'   => [
				'{{WRAPPER}}' => '--lmsc-gte-gradient-angle: {{SIZE}}deg;',
			],
			'condition'   => [
				'gradient_type'      => [ 'linear', 'conic' ],
				'gradient_direction' => 'custom',
			],
		];

		if ( $responsive ) {
			$this->add_responsive_control( 'gradient_angle', $angle_args );
		} else {
			unset( $angle_args['selectors'] );
			$this->add_control( 'gradient_angle', $angle_args );
		}
	}

	/**
	 * Register a color-stop position slider.
	 *
	 * Left empty, the browser spaces stops evenly (previous behavior).
	 * Setting a value controls how much room each color gets, e.g.
	 * Color 1 at 70% and Color 2 at 100% makes Color 1 dominate.
	 *
	 * @since 1.9.0
	 *
	 * @param string $id        Control ID, e.g. 'color_1_stop'.
	 * @param string $label     Control label.
	 * @param array  $condition Display condition.
	 * @return void
	 */
	protected function register_stop_control( string $id, string $label, array $condition ) {
		$this->add_control(
			$id,
			[
				'label'       => $label,
				'type'        => \Elementor\Controls_Manager::SLIDER,
				'size_units'  => [ '%' ],
				'default'     => [
					'size' => '',
					'unit' => '%',
				],
				'range'       => [
					'%' => [
						'min'  => 0,
						'max'  => 100,
						'step' => 1,
					],
				],
				'condition'   => $condition,
				'description' => esc_html__( 'Where this color sits in the gradient. Leave empty for automatic even spacing.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);
	}

	/**
	 * Return saved Brand Gradients formatted for an Elementor select control.
	 *
	 * @since 2.0.0
	 *
	 * @return array Gradient ID => label.
	 */
	protected function get_brand_gradient_control_options(): array {
		if ( ! function_exists( 'lmsc_gte_get_brand_gradient_options' ) ) {
			return [];
		}

		$options = lmsc_gte_get_brand_gradient_options();
		return is_array( $options ) ? $options : [];
	}

	/**
	 * Return validated Brand Gradient CSS for Elementor editor templates.
	 *
	 * @since 2.0.0
	 *
	 * @return array Gradient ID => complete CSS gradient value.
	 */
	protected function get_brand_gradient_editor_css(): array {
		$gradients = [];
		if ( function_exists( 'lmsc_gte_get_brand_gradients_for_editor' ) ) {
			foreach ( (array) lmsc_gte_get_brand_gradients_for_editor() as $id => $record ) {
				$clean_id = sanitize_key( (string) $id );
				$css      = is_array( $record ) && isset( $record['css'] ) ? (string) $record['css'] : '';
				if ( '' !== $clean_id && preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $css ) ) {
					$gradients[ $clean_id ] = $css;
				}
			}
			return $gradients;
		}

		if ( ! function_exists( 'lmsc_gte_get_brand_gradient_css' ) ) {
			return [];
		}

		foreach ( $this->get_brand_gradient_control_options() as $id => $label ) { // phpcs:ignore Generic.CodeAnalysis.UnusedFunctionParameter.FoundAfterLastUsed
			$clean_id = sanitize_key( (string) $id );
			$css      = lmsc_gte_get_brand_gradient_css( $clean_id );
			if ( is_string( $css ) && preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $css ) ) {
				$gradients[ $clean_id ] = $css;
			}
		}

		return $gradients;
	}

	/**
	 * Register the visual stop builder, Brand Gradient picker, and radial
	 * geometry controls shared by widgets and the dynamic tag.
	 *
	 * Existing classic custom-color controls remain available so saved 1.x
	 * widgets and familiar editing workflows continue to work unchanged.
	 *
	 * @since 2.0.0
	 *
	 * @return void
	 */
	protected function register_modern_gradient_controls() {
		$repeater = new \Elementor\Repeater();
		$repeater->add_control(
			'color',
			[
				'label'   => esc_html__( 'Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => \Elementor\Controls_Manager::COLOR,
				'default' => '#FF512F',
			]
		);
		$repeater->add_control(
			'position',
			[
				'label'   => esc_html__( 'Position (%)', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => \Elementor\Controls_Manager::NUMBER,
				'min'     => 0,
				'max'     => 100,
				'step'    => 1,
				'default' => 0,
			]
		);

		$this->add_control(
			'visual_gradient_stops',
			[
				'label'         => esc_html__( 'Gradient Stops', 'lmscrafter-gradient-text-for-elementor' ),
				'type'          => \Elementor\Controls_Manager::REPEATER,
				'fields'        => $repeater->get_controls(),
				'min_items'     => 2,
				'max_items'     => 5,
				'prevent_empty' => true,
				'default'       => [
					[ 'color' => '#FF512F', 'position' => 0 ],
					[ 'color' => '#DD2476', 'position' => 100 ],
				],
				'title_field'  => '{{ color }} at {{ position }}%',
				'condition'    => [ 'gradient_source' => 'visual' ],
				'description'  => esc_html__( 'Add 2–5 stops and drag rows to reorder them. The Elementor canvas is the live preview.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'brand_gradient',
			[
				'label'       => esc_html__( 'Brand Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => \Elementor\Controls_Manager::SELECT,
				'options'     => $this->get_brand_gradient_control_options(),
				'condition'   => [ 'gradient_source' => 'brand' ],
				'label_block' => true,
				'description' => esc_html__( 'Saved gradients update centrally from Settings → Brand Gradients.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'radial_shape',
			[
				'label'     => esc_html__( 'Radial Shape', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => \Elementor\Controls_Manager::SELECT,
				'default'   => 'circle',
				'options'   => [
					'circle'  => esc_html__( 'Circle', 'lmscrafter-gradient-text-for-elementor' ),
					'ellipse' => esc_html__( 'Ellipse', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'condition' => [ 'gradient_type' => 'radial' ],
			]
		);

		$this->add_control(
			'radial_position',
			[
				'label'     => esc_html__( 'Radial Position', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => \Elementor\Controls_Manager::SELECT,
				'default'   => 'center',
				'options'   => [
					'center'       => esc_html__( 'Center', 'lmscrafter-gradient-text-for-elementor' ),
					'top'          => esc_html__( 'Top', 'lmscrafter-gradient-text-for-elementor' ),
					'bottom'       => esc_html__( 'Bottom', 'lmscrafter-gradient-text-for-elementor' ),
					'left'         => esc_html__( 'Left', 'lmscrafter-gradient-text-for-elementor' ),
					'right'        => esc_html__( 'Right', 'lmscrafter-gradient-text-for-elementor' ),
					'top_left'     => esc_html__( 'Top Left', 'lmscrafter-gradient-text-for-elementor' ),
					'top_right'    => esc_html__( 'Top Right', 'lmscrafter-gradient-text-for-elementor' ),
					'bottom_left'  => esc_html__( 'Bottom Left', 'lmscrafter-gradient-text-for-elementor' ),
					'bottom_right' => esc_html__( 'Bottom Right', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'condition' => [ 'gradient_type' => 'radial' ],
			]
		);
	}

	/**
	 * Register solid fallback and motion controls shared by both widgets.
	 *
	 * @since 2.0.0
	 *
	 * @param string $selector Elementor selector for the rendered target.
	 * @return void
	 */
	protected function register_accessibility_controls( string $selector ) {
		$this->add_control(
			'heading_accessibility',
			[
				'label'     => esc_html__( 'Accessibility & Responsive Motion', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => \Elementor\Controls_Manager::HEADING,
				'separator' => 'before',
			]
		);

		$this->add_control(
			'fallback_color',
			[
				'label'       => esc_html__( 'Solid Fallback Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => \Elementor\Controls_Manager::COLOR,
				'default'     => '#333333',
				'selectors'   => [ $selector => '--lmsc-gte-fallback-color: {{VALUE}};' ],
				'description' => esc_html__( 'Shown when gradient clipping is unavailable and in accessibility fallbacks.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'animation_iterations',
			[
				'label'     => esc_html__( 'Animation Repeats', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => \Elementor\Controls_Manager::SELECT,
				'default'   => 'infinite',
				'options'   => [
					'1'        => esc_html__( 'Once', 'lmscrafter-gradient-text-for-elementor' ),
					'3'        => esc_html__( '3 Times', 'lmscrafter-gradient-text-for-elementor' ),
					'5'        => esc_html__( '5 Times', 'lmscrafter-gradient-text-for-elementor' ),
					'infinite' => esc_html__( 'Continuous', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'condition' => [ 'enable_animation' => 'yes' ],
			]
		);

		$this->add_control(
			'pause_on_interaction',
			[
				'label'        => esc_html__( 'Pause on Hover / Focus', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => \Elementor\Controls_Manager::SWITCHER,
				'return_value' => 'yes',
				'default'      => 'yes',
				'condition'    => [ 'enable_animation' => 'yes' ],
			]
		);

		$this->add_responsive_control(
			'animation_play_state',
			[
				'label'       => esc_html__( 'Animation on This Device', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => \Elementor\Controls_Manager::SELECT,
				'default'     => 'running',
				'options'     => [
					'running' => esc_html__( 'Run', 'lmscrafter-gradient-text-for-elementor' ),
					'paused'  => esc_html__( 'Pause', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors'   => [ $selector => '--lmsc-gte-animation-play-state: {{VALUE}};' ],
				'condition'   => [ 'enable_animation' => 'yes' ],
				'description' => esc_html__( 'Use the device icons to pause motion on desktop, tablet, or mobile. Reduced-motion preferences always stop it.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_responsive_control(
			'animation_background_size',
			[
				'label'      => esc_html__( 'Animation Travel', 'lmscrafter-gradient-text-for-elementor' ),
				'type'       => \Elementor\Controls_Manager::SLIDER,
				'size_units' => [ '%' ],
				'default'    => [ 'size' => 200, 'unit' => '%' ],
				'range'      => [ '%' => [ 'min' => 100, 'max' => 400, 'step' => 10 ] ],
				'selectors'  => [
					$selector . ', ' . $selector . '.lmsc-gte-partial-mode .lmsc-gte-highlight' => 'background-size: {{SIZE}}% {{SIZE}}% !important;',
				],
				'condition'  => [ 'enable_animation' => 'yes' ],
			]
		);
	}

	/**
	 * Build shared effect classes for a rendered gradient target.
	 *
	 * @since 2.0.0
	 *
	 * @param array  $settings Widget settings.
	 * @param string $base     Base class name.
	 * @return string Sanitized class list.
	 */
	protected function build_gradient_classes( array $settings, string $base ): string {
		$classes = $base;

		if ( 'yes' === ( $settings['enable_hover'] ?? '' ) ) {
			$classes .= ' lmsc-gte-has-hover';
		}

		if ( 'yes' === ( $settings['enable_animation'] ?? '' ) ) {
			$allowed_directions = [ 'horizontal', 'vertical', 'diagonal' ];
			$direction          = isset( $settings['animation_direction'] ) ? (string) $settings['animation_direction'] : 'horizontal';
			if ( ! in_array( $direction, $allowed_directions, true ) ) {
				$direction = 'horizontal';
			}
			$classes .= ' lmsc-gte-animated lmsc-gte-animated-' . $direction;

			if ( 'yes' === ( $settings['pause_on_interaction'] ?? 'yes' ) ) {
				$classes .= ' lmsc-gte-pause-on-interaction';
			}
		}

		$apply_to = isset( $settings['gradient_apply_to'] ) ? (string) $settings['gradient_apply_to'] : 'fill';
		if ( 'stroke' === $apply_to ) {
			$classes .= ' lmsc-gte-stroke-only';
		} elseif ( 'both' === $apply_to ) {
			$classes .= ' lmsc-gte-stroke-both';
		}

		return $classes;
	}

	/**
	 * Build shared inline custom properties without emitting a style element.
	 *
	 * @since 2.0.0
	 *
	 * @param array  $settings Widget settings.
	 * @param string $gradient Sanitized CSS gradient value.
	 * @return string Style declaration list.
	 */
	protected function build_gradient_style( array $settings, string $gradient ): string {
		$fallback = $this->sanitize_color( $settings['fallback_color'] ?? '#333333' );
		$style    = sprintf(
			'background-image:%1$s;--lmsc-gte-gradient:%1$s;--lmsc-gte-fallback-color:%2$s;',
			$gradient,
			$fallback
		);

		if ( 'yes' === ( $settings['enable_hover'] ?? '' ) ) {
			$hover_settings                    = $settings;
			$hover_settings['gradient_source'] = 'visual';
			$hover_gradient                    = $this->make_gradient_angle_responsive(
				$this->build_gradient( $settings, true ),
				$hover_settings
			);
			$style                            .= sprintf( '--lmsc-gte-hover-gradient:%s;', $hover_gradient );
		}

		if ( 'yes' === ( $settings['enable_animation'] ?? '' ) ) {
			$speed = isset( $settings['animation_speed']['size'] ) ? (int) $settings['animation_speed']['size'] : 5;
			$speed = min( 20, max( 1, $speed ) );

			$allowed_easings = [ 'linear', 'ease', 'ease-in', 'ease-out', 'ease-in-out' ];
			$easing          = isset( $settings['animation_easing'] ) ? (string) $settings['animation_easing'] : 'ease';
			if ( ! in_array( $easing, $allowed_easings, true ) ) {
				$easing = 'ease';
			}

			$iterations = isset( $settings['animation_iterations'] ) ? (string) $settings['animation_iterations'] : 'infinite';
			if ( ! in_array( $iterations, [ '1', '3', '5', 'infinite' ], true ) ) {
				$iterations = 'infinite';
			}

			$play_state = isset( $settings['animation_play_state'] ) ? (string) $settings['animation_play_state'] : 'running';
			if ( ! in_array( $play_state, [ 'running', 'paused' ], true ) ) {
				$play_state = 'running';
			}

			$style .= sprintf(
				'--lmsc-gte-animation-speed:%1$ds;--lmsc-gte-animation-easing:%2$s;--lmsc-gte-animation-iterations:%3$s;--lmsc-gte-animation-play-state:%4$s;',
				$speed,
				$easing,
				$iterations,
				$play_state
			);
		}

		$apply_to = isset( $settings['gradient_apply_to'] ) ? (string) $settings['gradient_apply_to'] : 'fill';
		if ( in_array( $apply_to, [ 'stroke', 'both' ], true ) ) {
			$stroke_width = isset( $settings['stroke_width']['size'] ) ? (int) $settings['stroke_width']['size'] : 2;
			$style       .= sprintf( '--lmsc-gte-stroke-width:%dpx;', min( 10, max( 1, $stroke_width ) ) );
		}

		return $style;
	}

	/**
	 * Replace a fixed linear/conic angle with a CSS custom-property fallback.
	 * Elementor's responsive direction controls override the property per
	 * breakpoint while the original angle remains the no-generated-CSS value.
	 *
	 * @since 2.0.0
	 *
	 * @param string $gradient Complete CSS gradient.
	 * @param array  $settings Widget settings.
	 * @return string Responsive-safe gradient.
	 */
	protected function make_gradient_angle_responsive( string $gradient, array $settings ): string {
		if ( 'brand' === ( $settings['gradient_source'] ?? '' ) ) {
			return $gradient;
		}

		$gradient = preg_replace(
			'/^linear-gradient\((\d+)deg,/',
			'linear-gradient(var(--lmsc-gte-gradient-angle, $1deg),',
			$gradient
		);

		return preg_replace(
			'/^conic-gradient\(from (\d+)deg,/',
			'conic-gradient(from var(--lmsc-gte-gradient-angle, $1deg),',
			$gradient
		);
	}

	/**
	 * Build the CSS gradient value from widget settings.
	 *
	 * Constructs a linear-gradient, radial-gradient, or conic-gradient CSS
	 * value based on the widget's gradient source, type, direction/angle,
	 * color, and color-stop position settings.
	 *
	 * @since 1.7.0
	 * @since 1.9.0 Added direction presets and per-color stop positions.
	 *
	 * @param array $settings Widget settings array.
	 * @param bool  $hover    Whether to build the hover gradient. Default false.
	 * @return string CSS gradient value.
	 */
	protected function build_gradient( array $settings, bool $hover = false ): string {
		if ( ! $hover && 'brand' === ( $settings['gradient_source'] ?? '' ) && function_exists( 'lmsc_gte_get_brand_gradient_css' ) ) {
			$raw_brand_id = $settings['brand_gradient'] ?? '';
			$brand_id     = is_scalar( $raw_brand_id ) ? sanitize_key( (string) $raw_brand_id ) : '';
			$brand_css = lmsc_gte_get_brand_gradient_css( $brand_id );
			if ( is_string( $brand_css ) && preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $brand_css ) ) {
				return $brand_css;
			}
		}

		// Compatibility fallback for integrations that provide only the 2.0
		// Elementor-settings adapter. The direct CSS helper above remains the
		// authoritative path because it preserves decimals and global tokens.
		if ( ! $hover && 'brand' === ( $settings['gradient_source'] ?? '' ) && function_exists( 'lmsc_gte_brand_gradient_to_elementor_settings' ) ) {
			$raw_brand_id   = $settings['brand_gradient'] ?? '';
			$brand_id       = is_scalar( $raw_brand_id ) ? sanitize_key( (string) $raw_brand_id ) : '';
			$brand_settings = lmsc_gte_brand_gradient_to_elementor_settings( $brand_id );
			if ( is_array( $brand_settings ) && ! empty( $brand_settings ) ) {
				$settings = array_merge( $settings, $brand_settings );
			}
		}

		$type = isset( $settings['gradient_type'] ) ? (string) $settings['gradient_type'] : 'linear';
		if ( ! in_array( $type, [ 'linear', 'radial', 'conic' ], true ) ) {
			$type = 'linear';
		}
		$angle = $this->resolve_angle( $settings );

		// Each entry: [ color, stop-position|null ].
		if ( $hover ) {
			$colors = [
				[ $this->sanitize_color( $settings['hover_color_1'] ?? '#11998e' ), $this->get_stop_position( $settings, 'hover_color_1_stop' ) ],
				[ $this->sanitize_color( $settings['hover_color_2'] ?? '#38ef7d' ), $this->get_stop_position( $settings, 'hover_color_2_stop' ) ],
			];
		} elseif ( 'preset' === ( $settings['gradient_source'] ?? 'preset' ) ) {
			$raw_preset_key = $settings['preset_gradient'] ?? 'sunset';
			$preset_key     = is_scalar( $raw_preset_key )
				? sanitize_key( (string) $raw_preset_key )
				: 'sunset';
			if ( '' === $preset_key ) {
				$preset_key = 'sunset';
			}
			$preset_colors = isset( $this->presets[ $preset_key ]['colors'] )
				? $this->presets[ $preset_key ]['colors']
				: [ '#FF512F', '#DD2476' ];
			$colors        = [];
			foreach ( $preset_colors as $preset_color ) {
				$colors[] = [ $preset_color, null ];
			}
		} elseif ( 'visual' === ( $settings['gradient_source'] ?? '' ) && ! empty( $settings['visual_gradient_stops'] ) && is_array( $settings['visual_gradient_stops'] ) ) {
			$colors = [];
			foreach ( array_slice( $settings['visual_gradient_stops'], 0, 5 ) as $stop ) {
				if ( ! is_array( $stop ) ) {
					continue;
				}

				$raw_color = isset( $stop['color'] ) && is_scalar( $stop['color'] ) ? (string) $stop['color'] : '';
				if ( 'global' === ( $stop['source'] ?? '' ) && ! empty( $stop['global_id'] ) ) {
					$raw_color = 'global:' . sanitize_key( (string) $stop['global_id'] );
				}

				$position = null;
				if ( isset( $stop['position'] ) && '' !== $stop['position'] && null !== $stop['position'] ) {
					$position = min( 100, max( 0, (int) $stop['position'] ) );
				}

				$colors[] = [ $this->sanitize_color( $raw_color ), $position ];
			}

			if ( count( $colors ) < 2 ) {
				$colors = [ [ '#FF512F', 0 ], [ '#DD2476', 100 ] ];
			}
		} else {
			$colors = [
				[ $this->sanitize_color( $settings['color_1'] ?? '#FF512F' ), $this->get_stop_position( $settings, 'color_1_stop' ) ],
				[ $this->sanitize_color( $settings['color_2'] ?? '#DD2476' ), $this->get_stop_position( $settings, 'color_2_stop' ) ],
			];
			if ( 'yes' === ( $settings['enable_color_3'] ?? '' ) && ! empty( $settings['color_3'] ) ) {
				$colors[] = [ $this->sanitize_color( $settings['color_3'] ), $this->get_stop_position( $settings, 'color_3_stop' ) ];
			}
			if ( 'yes' === ( $settings['enable_color_4'] ?? '' ) && ! empty( $settings['color_4'] ) ) {
				$colors[] = [ $this->sanitize_color( $settings['color_4'] ), $this->get_stop_position( $settings, 'color_4_stop' ) ];
			}
			if ( 'yes' === ( $settings['enable_color_5'] ?? '' ) && ! empty( $settings['color_5'] ) ) {
				$colors[] = [ $this->sanitize_color( $settings['color_5'] ), $this->get_stop_position( $settings, 'color_5_stop' ) ];
			}
		}

		$parts = [];
		foreach ( $colors as $entry ) {
			$parts[] = ( null === $entry[1] ) ? $entry[0] : sprintf( '%s %d%%', $entry[0], $entry[1] );
		}
		$color_string = implode( ', ', $parts );

		if ( 'radial' === $type ) {
			$shape    = isset( $settings['radial_shape'] ) && in_array( $settings['radial_shape'], [ 'circle', 'ellipse' ], true ) ? $settings['radial_shape'] : 'circle';
			$position = isset( $settings['radial_position'] ) ? sanitize_key( (string) $settings['radial_position'] ) : 'center';
			$positions = [
				'center'       => 'center',
				'top'          => 'center top',
				'bottom'       => 'center bottom',
				'left'         => 'left center',
				'right'        => 'right center',
				'top_left'     => 'left top',
				'top_right'    => 'right top',
				'bottom_left'  => 'left bottom',
				'bottom_right' => 'right bottom',
			];
			$position = $positions[ $position ] ?? 'center';
			return sprintf( 'radial-gradient(%s at %s, %s)', $shape, $position, $color_string );
		}

		if ( 'conic' === $type ) {
			// Conic gradient sweeps colors around a center point.
			// The angle is reused as the starting "from" angle.
			return sprintf( 'conic-gradient(from %ddeg, %s)', $angle, $color_string );
		}

		return sprintf( 'linear-gradient(%ddeg, %s)', $angle, $color_string );
	}
}
