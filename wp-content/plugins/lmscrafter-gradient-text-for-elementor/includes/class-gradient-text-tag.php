<?php
/**
 * Gradient Text Dynamic Tag for Elementor.
 *
 * Lets users drop gradient text into ANY Elementor field that
 * supports dynamic content (heading titles, button labels, post
 * titles, image captions, custom HTML widgets, etc.) without having
 * to drag a dedicated widget.
 *
 * Registered under the standard TEXT_CATEGORY so it appears in every
 * dynamic-tag picker that accepts strings.
 *
 * @package LMSC_GTE
 * @since   1.8.0
 */

namespace LMSC_GTE\Dynamic_Tags;

use Elementor\Controls_Manager;
use Elementor\Core\DynamicTags\Tag;
use Elementor\Modules\DynamicTags\Module as TagsModule;
use LMSC_GTE\Widgets\Gradient_Helper;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Gradient Text dynamic tag.
 *
 * @since 1.8.0
 */
class Gradient_Text_Tag extends Tag {

	use Gradient_Helper;

	/**
	 * Constructor — populate the preset cache the trait expects.
	 *
	 * @since 1.8.0
	 *
	 * @param array $data Tag data passed by Elementor.
	 */
	public function __construct( $data = [] ) {
		parent::__construct( $data );
		$this->presets = $this->get_preset_gradients();
	}

	/**
	 * Unique tag name.
	 *
	 * @return string
	 */
	public function get_name() {
		return 'lmsc-gte-gradient-text-tag';
	}

	/**
	 * Title shown in the dynamic-tag picker.
	 *
	 * @return string
	 */
	public function get_title() {
		return esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' );
	}

	/**
	 * Tag group — appears in the "Site" group inside Elementor's picker.
	 *
	 * @return string
	 */
	public function get_group() {
		return 'site';
	}

	/**
	 * Categories the tag is compatible with.
	 *
	 * TEXT_CATEGORY covers every plain-text Elementor field. The output
	 * of `render()` is HTML; widgets that escape with `esc_html()` will
	 * render the markup as text rather than apply the gradient. Heading,
	 * Text Editor, and HTML widgets all preserve markup, which is the
	 * majority of where this tag will be used.
	 *
	 * @return array
	 */
	public function get_categories() {
		return [
			TagsModule::TEXT_CATEGORY,
		];
	}

	/**
	 * Register the tag's controls.
	 *
	 * Mirrors the gradient subset of the widget controls — text, source,
	 * preset, type, angle, and up to five custom color stops. Animation
	 * and hover are intentionally omitted from the v1 of the tag because
	 * inline-style scoping inside an arbitrary parent widget is fragile;
	 * users who need those should drag a real widget instead.
	 *
	 * @return void
	 */
	protected function register_controls() {
		$this->add_control(
			'text',
			[
				'label'       => esc_html__( 'Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'default'     => esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
				'placeholder' => esc_html__( 'Type the gradient text here', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
			]
		);

		$this->add_control(
			'gradient_source',
			[
				'label'   => esc_html__( 'Gradient Source', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'preset',
				'options' => [
					'preset' => esc_html__( 'Preset Palette', 'lmscrafter-gradient-text-for-elementor' ),
					'visual' => esc_html__( 'Visual Builder', 'lmscrafter-gradient-text-for-elementor' ),
					'brand'  => esc_html__( 'Saved Brand Gradient', 'lmscrafter-gradient-text-for-elementor' ),
					'custom' => esc_html__( 'Classic Custom Colors', 'lmscrafter-gradient-text-for-elementor' ),
				],
			]
		);

		$preset_options = [];
		foreach ( $this->presets as $key => $preset ) {
			$preset_options[ $key ] = $preset['label'];
		}

		$this->add_control(
			'preset_gradient',
			[
				'label'     => esc_html__( 'Preset', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SELECT,
				'default'   => 'sunset',
				'options'   => $preset_options,
				'condition' => [ 'gradient_source' => 'preset' ],
			]
		);

		$this->add_control(
			'gradient_type',
			[
				'label'   => esc_html__( 'Gradient Type', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'linear',
				'options' => [
					'linear' => esc_html__( 'Linear', 'lmscrafter-gradient-text-for-elementor' ),
					'radial' => esc_html__( 'Radial', 'lmscrafter-gradient-text-for-elementor' ),
					'conic'  => esc_html__( 'Conic', 'lmscrafter-gradient-text-for-elementor' ),
				],
			]
		);

		// Dynamic tags are sanitized inside an arbitrary parent widget and do not
		// own a reliable Elementor wrapper for generated breakpoint CSS.
		$this->register_direction_controls( false );
		$this->register_modern_gradient_controls();

		$this->add_control(
			'fallback_color',
			[
				'label'       => esc_html__( 'Solid Fallback Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::COLOR,
				'default'     => '#333333',
				'description' => esc_html__( 'Used when gradient text clipping is unavailable.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'color_1',
			[
				'label'     => esc_html__( 'Color 1', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#FF512F',
				'condition' => [ 'gradient_source' => 'custom' ],
			]
		);

		$this->register_stop_control(
			'color_1_stop',
			esc_html__( 'Color 1 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[ 'gradient_source' => 'custom' ]
		);

		$this->add_control(
			'color_2',
			[
				'label'     => esc_html__( 'Color 2', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#DD2476',
				'condition' => [ 'gradient_source' => 'custom' ],
			]
		);

		$this->register_stop_control(
			'color_2_stop',
			esc_html__( 'Color 2 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[ 'gradient_source' => 'custom' ]
		);

		$this->add_control(
			'enable_color_3',
			[
				'label'        => esc_html__( 'Add Third Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'return_value' => 'yes',
				'default'      => '',
				'condition'    => [ 'gradient_source' => 'custom' ],
			]
		);

		$this->add_control(
			'color_3',
			[
				'label'     => esc_html__( 'Color 3', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#1BFFFF',
				'condition' => [
					'gradient_source' => 'custom',
					'enable_color_3'  => 'yes',
				],
			]
		);

		$this->register_stop_control(
			'color_3_stop',
			esc_html__( 'Color 3 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[
				'gradient_source' => 'custom',
				'enable_color_3'  => 'yes',
			]
		);

		$this->add_control(
			'enable_color_4',
			[
				'label'        => esc_html__( 'Add Fourth Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'return_value' => 'yes',
				'default'      => '',
				'condition'    => [
					'gradient_source' => 'custom',
					'enable_color_3'  => 'yes',
				],
			]
		);

		$this->add_control(
			'color_4',
			[
				'label'     => esc_html__( 'Color 4', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#7F00FF',
				'condition' => [
					'gradient_source' => 'custom',
					'enable_color_3'  => 'yes',
					'enable_color_4'  => 'yes',
				],
			]
		);

		$this->register_stop_control(
			'color_4_stop',
			esc_html__( 'Color 4 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[
				'gradient_source' => 'custom',
				'enable_color_3'  => 'yes',
				'enable_color_4'  => 'yes',
			]
		);

		$this->add_control(
			'enable_color_5',
			[
				'label'        => esc_html__( 'Add Fifth Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'return_value' => 'yes',
				'default'      => '',
				'condition'    => [
					'gradient_source' => 'custom',
					'enable_color_3'  => 'yes',
					'enable_color_4'  => 'yes',
				],
			]
		);

		$this->add_control(
			'color_5',
			[
				'label'     => esc_html__( 'Color 5', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#f5af19',
				'condition' => [
					'gradient_source' => 'custom',
					'enable_color_3'  => 'yes',
					'enable_color_4'  => 'yes',
					'enable_color_5'  => 'yes',
				],
			]
		);

		$this->register_stop_control(
			'color_5_stop',
			esc_html__( 'Color 5 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[
				'gradient_source' => 'custom',
				'enable_color_3'  => 'yes',
				'enable_color_4'  => 'yes',
				'enable_color_5'  => 'yes',
			]
		);
	}

	/**
	 * Render the resolved tag value.
	 *
	 * Outputs an inline <span> with the gradient applied via the same
	 * background-clip technique used by the widgets. The CSS @supports
	 * fallback in `assets/css/gradient-text.css` recovers this span on
	 * browsers without `background-clip: text`. The plugin registers a
	 * normal Elementor frontend enqueue and this render method adds a
	 * final safety-net enqueue for template contexts outside that flow.
	 *
	 * @return void
	 */
	public function render() {
		// Dynamic tags are not part of Elementor's widget dependency graph.
		// Enqueue explicitly as a final safety net for theme/template contexts
		// that render this tag outside the standard Elementor frontend hook.
		wp_enqueue_style(
			'lmsc-gte-gradient-text',
			LMSC_GTE_PLUGIN_URL . 'assets/css/gradient-text.css',
			[],
			LMSC_GTE_VERSION
		);

		$settings = $this->get_settings();
		$text     = isset( $settings['text'] ) ? (string) $settings['text'] : '';

		if ( '' === trim( $text ) ) {
			return;
		}

		// Dynamic-tag HTML is frequently sanitized again by the consuming widget.
		// WordPress preserves literal gradients but rejects gradient functions
		// containing nested var() calls, so use the resolved desktop angle and the
		// stored fallback for any Elementor Global Color on this surface.
		$gradient = $this->make_gradient_kses_safe( $this->build_gradient( $settings ) );

		$style = $this->build_gradient_style( $settings, $gradient );
		if ( function_exists( 'safecss_filter_attr' ) ) {
			$style = safecss_filter_attr( $style );
		}

		printf(
			'<span class="lmsc-gte-gradient-text lmsc-gte-dynamic-tag" style="%s">%s</span>',
			esc_attr( $style ),
			esc_html( $text )
		);
	}

	/**
	 * Convert validated Elementor Global Color variables to their solid fallback
	 * so arbitrary parent widgets do not remove the dynamic tag's gradient when
	 * they pass its HTML through WordPress KSES.
	 *
	 * @param string $gradient Validated gradient CSS.
	 * @return string KSES-stable literal gradient.
	 */
	private function make_gradient_kses_safe( string $gradient ): string {
		$fallback_gradient = 'linear-gradient(90deg, #FF512F, #DD2476)';
		$offset            = 0;

		while ( false !== ( $start = strpos( $gradient, 'var(', $offset ) ) ) {
			$depth = 0;
			$end   = null;
			$length = strlen( $gradient );
			for ( $index = $start; $index < $length; $index++ ) {
				if ( '(' === $gradient[ $index ] ) {
					$depth++;
				} elseif ( ')' === $gradient[ $index ] ) {
					$depth--;
					if ( 0 === $depth ) {
						$end = $index;
						break;
					}
				}
			}

			if ( null === $end ) {
				return $fallback_gradient;
			}

			$token = substr( $gradient, $start, $end - $start + 1 );
			$inner = trim( substr( $token, 4, -1 ) );
			if ( ! preg_match( '/^--e-global-color-[a-z0-9_-]+(?:\s*,\s*(.+))?$/is', $inner, $matches ) ) {
				return $fallback_gradient;
			}

			$solid = isset( $matches[1] ) ? $this->sanitize_color( trim( $matches[1] ) ) : '#000000';
			$gradient = substr_replace( $gradient, $solid, $start, strlen( $token ) );
			$offset   = $start + strlen( $solid );
		}

		return preg_match( '/^(?:linear|radial|conic)-gradient\([^;{}]+\)$/', $gradient )
			? $gradient
			: $fallback_gradient;
	}
}
