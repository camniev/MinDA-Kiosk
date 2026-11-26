<?php
/**
 * Gradient Text Widget for Elementor.
 *
 * Provides a heading-style widget with gradient text support,
 * including preset palettes, custom colors, and hover effects.
 *
 * @package LMSC_GTE
 * @since   1.0.0
 */

namespace LMSC_GTE\Widgets;

use Elementor\Widget_Base;
use Elementor\Controls_Manager;
use Elementor\Group_Control_Typography;
use Elementor\Group_Control_Text_Shadow;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Gradient Text Widget.
 *
 * A heading widget that renders text with CSS gradient effects.
 * Supports preset gradient palettes, custom multi-color gradients,
 * linear and radial types, hover effects, and full typography control.
 *
 * @since 1.0.0
 */
class Gradient_Text_Widget extends Widget_Base {

	use Gradient_Helper;

	/**
	 * Widget constructor.
	 *
	 * @since 1.0.0
	 *
	 * @param array      $data Widget data. Default empty array.
	 * @param array|null $args Widget arguments. Default null.
	 */
	public function __construct( $data = [], $args = null ) {
		parent::__construct( $data, $args );
		$this->presets = $this->get_preset_gradients();
	}

	/**
	 * Get widget name.
	 *
	 * @since 1.0.0
	 *
	 * @return string Widget name.
	 */
	public function get_name() {
		return 'lmsc-gte-gradient-text';
	}

	/**
	 * Get widget title.
	 *
	 * @since 1.0.0
	 *
	 * @return string Widget title.
	 */
	public function get_title() {
		return esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' );
	}

	/**
	 * Get widget icon.
	 *
	 * @since 1.0.0
	 *
	 * @return string Widget icon CSS class.
	 */
	public function get_icon() {
		return 'eicon-heading';
	}

	/**
	 * Get widget categories.
	 *
	 * @since 1.0.0
	 *
	 * @return array Widget categories.
	 */
	public function get_categories() {
		return [ 'gradient-text', 'basic' ];
	}

	/**
	 * Get widget search keywords.
	 *
	 * @since 1.0.0
	 *
	 * @return array Widget keywords.
	 */
	public function get_keywords() {
		return [ 'gradient', 'text', 'heading', 'title', 'color', 'rainbow' ];
	}

	/**
	 * Get style dependencies.
	 *
	 * @since 1.0.0
	 *
	 * @return array Style handle dependencies.
	 */
	public function get_style_depends() {
		return [ 'lmsc-gte-gradient-text' ];
	}

	/**
	 * Register widget controls.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	protected function register_controls() {
		$this->register_content_controls();
		$this->register_gradient_controls();
		$this->register_highlight_effect_controls();
		$this->register_typography_controls();
	}

	/**
	 * Register content tab controls.
	 *
	 * Adds text input, HTML tag selector, responsive alignment,
	 * and optional link controls.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	private function register_content_controls() {
		$this->start_controls_section(
			'section_content',
			[
				'label' => esc_html__( 'Content', 'lmscrafter-gradient-text-for-elementor' ),
				'tab'   => Controls_Manager::TAB_CONTENT,
			]
		);

		$this->add_control(
			'enable_highlight',
			[
				'label'        => esc_html__( 'Highlight Specific Words', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
				'return_value' => 'yes',
				'default'      => '',
				'description'  => esc_html__( 'Apply gradient to specific words instead of the entire text.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'highlight_mode',
			[
				'label'       => esc_html__( 'Highlight Layout', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::SELECT,
				'default'     => 'legacy',
				'options'     => [
					'legacy'   => esc_html__( 'One Highlighted Phrase', 'lmscrafter-gradient-text-for-elementor' ),
					'segments' => esc_html__( 'Multiple Highlighted Phrases', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'condition'   => [ 'enable_highlight' => 'yes' ],
				'description' => esc_html__( 'Use ordered segments to highlight several phrases in one heading.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$segment_repeater = new \Elementor\Repeater();
		$segment_repeater->add_control(
			'segment_type',
			[
				'label'   => esc_html__( 'Segment Style', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'plain',
				'options' => [
					'plain'    => esc_html__( 'Plain Text', 'lmscrafter-gradient-text-for-elementor' ),
					'gradient' => esc_html__( 'Gradient Highlight', 'lmscrafter-gradient-text-for-elementor' ),
				],
			]
		);
		$segment_repeater->add_control(
			'segment_text',
			[
				'label'       => esc_html__( 'Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'default'     => esc_html__( 'Text', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
			]
		);
		$segment_repeater->add_control(
			'append_space',
			[
				'label'        => esc_html__( 'Space After', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'return_value' => 'yes',
				'default'      => 'yes',
			]
		);

		$this->add_control(
			'highlight_segments',
			[
				'label'       => esc_html__( 'Text Segments', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::REPEATER,
				'fields'      => $segment_repeater->get_controls(),
				'default'     => [
					[ 'segment_type' => 'plain', 'segment_text' => esc_html__( 'Build', 'lmscrafter-gradient-text-for-elementor' ), 'append_space' => 'yes' ],
					[ 'segment_type' => 'gradient', 'segment_text' => esc_html__( 'beautiful', 'lmscrafter-gradient-text-for-elementor' ), 'append_space' => 'yes' ],
					[ 'segment_type' => 'plain', 'segment_text' => esc_html__( 'pages with', 'lmscrafter-gradient-text-for-elementor' ), 'append_space' => 'yes' ],
					[ 'segment_type' => 'gradient', 'segment_text' => esc_html__( 'brand gradients', 'lmscrafter-gradient-text-for-elementor' ), 'append_space' => '' ],
				],
					'title_field' => '{{ segment_type }}: {{ segment_text }}',
				'condition'   => [
					'enable_highlight' => 'yes',
					'highlight_mode'   => 'segments',
				],
			]
		);

		// Original full-text field (shown when highlight is OFF).
		$this->add_control(
			'text',
			[
				'label'       => esc_html__( 'Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXTAREA,
				'default'     => esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
				'placeholder' => esc_html__( 'Enter your text here', 'lmscrafter-gradient-text-for-elementor' ),
				'dynamic'     => [ 'active' => true ],
				'condition'   => [
					'enable_highlight' => '',
				],
			]
		);

		// 3-field layout (shown when highlight is ON).
		$this->add_control(
			'before_text',
			[
				'label'       => esc_html__( 'Before Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'default'     => esc_html__( 'Get latest Learndash', 'lmscrafter-gradient-text-for-elementor' ),
				'placeholder' => esc_html__( 'Text before gradient...', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
				'dynamic'     => [ 'active' => true ],
				'condition'   => [
					'enable_highlight' => 'yes',
					'highlight_mode'   => 'legacy',
				],
			]
		);

		$this->add_control(
			'gradient_words',
			[
				'label'       => esc_html__( 'Gradient Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'default'     => esc_html__( 'Dashboard', 'lmscrafter-gradient-text-for-elementor' ),
				'placeholder' => esc_html__( 'Word(s) to make gradient...', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
				'dynamic'     => [ 'active' => true ],
				'condition'   => [
					'enable_highlight' => 'yes',
					'highlight_mode'   => 'legacy',
				],
				'description' => esc_html__( 'These words will get the gradient color.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'after_text',
			[
				'label'       => esc_html__( 'After Text', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'default'     => esc_html__( 'pro Free', 'lmscrafter-gradient-text-for-elementor' ),
				'placeholder' => esc_html__( 'Text after gradient...', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
				'dynamic'     => [ 'active' => true ],
				'condition'   => [
					'enable_highlight' => 'yes',
					'highlight_mode'   => 'legacy',
				],
			]
		);

		$this->add_control(
			'base_text_color',
			[
				'label'       => esc_html__( 'Base Text Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::COLOR,
				'default'     => '#333333',
				'condition'   => [
					'enable_highlight' => 'yes',
				],
				'description' => esc_html__( 'Color for the non-gradient text.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'html_tag',
			[
				'label'   => esc_html__( 'HTML Tag', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'h2',
				'options' => [
					'h1'   => 'H1',
					'h2'   => 'H2',
					'h3'   => 'H3',
					'h4'   => 'H4',
					'h5'   => 'H5',
					'h6'   => 'H6',
					'p'    => 'p',
					'span' => 'span',
					'div'  => 'div',
				],
			]
		);

		$this->add_responsive_control(
			'text_align',
			[
				'label'     => esc_html__( 'Alignment', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::CHOOSE,
				'options'   => [
					'left'   => [
						'title' => esc_html__( 'Left', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-left',
					],
					'center' => [
						'title' => esc_html__( 'Center', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-center',
					],
					'right'  => [
						'title' => esc_html__( 'Right', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-right',
					],
				],
				'default'   => 'center',
				'selectors' => [
					'{{WRAPPER}} .lmsc-gte-gradient-text-wrapper' => 'text-align: {{VALUE}};',
				],
			]
		);

		$this->add_control(
			'link',
			[
				'label'       => esc_html__( 'Link', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::URL,
				'placeholder' => esc_html__( 'https://your-link.com', 'lmscrafter-gradient-text-for-elementor' ),
				'dynamic'     => [ 'active' => true ],
			]
		);

		$this->add_control(
			'accessible_label',
			[
				'label'       => esc_html__( 'Accessible Label', 'lmscrafter-gradient-text-for-elementor' ),
				'type'        => Controls_Manager::TEXT,
				'placeholder' => esc_html__( 'Optional screen-reader label', 'lmscrafter-gradient-text-for-elementor' ),
				'label_block' => true,
				'description' => esc_html__( 'Leave empty to use the visible text. Add a label only when the visible stylized wording needs clarification.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->end_controls_section();
	}

	/**
	 * Register gradient style controls.
	 *
	 * Adds gradient source (preset/custom), type (linear/radial),
	 * angle slider, color pickers, and hover gradient controls.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	private function register_gradient_controls() {
		$this->start_controls_section(
			'section_gradient',
			[
				'label' => esc_html__( 'Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'tab'   => Controls_Manager::TAB_STYLE,
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
				'condition' => [
					'gradient_source' => 'preset',
				],
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

		$this->register_direction_controls();
		$this->register_modern_gradient_controls();

		$this->add_control(
			'color_1',
			[
				'label'     => esc_html__( 'Color 1', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#FF512F',
				'condition' => [
					'gradient_source' => 'custom',
				],
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
				'condition' => [
					'gradient_source' => 'custom',
				],
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
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
				'return_value' => 'yes',
				'default'      => '',
				'condition'    => [
					'gradient_source' => 'custom',
				],
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
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
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
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
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

		// Animation controls.
		$this->add_control(
			'heading_animation',
			[
				'label'     => esc_html__( 'Gradient Animation', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::HEADING,
				'separator' => 'before',
			]
		);

		$this->add_control(
			'enable_animation',
			[
				'label'        => esc_html__( 'Enable Animation', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
				'return_value' => 'yes',
				'default'      => '',
			]
		);

		$this->add_control(
			'animation_speed',
			[
				'label'     => esc_html__( 'Animation Speed (seconds)', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SLIDER,
				'default'   => [
					'size' => 5,
				],
				'range'     => [
					'px' => [
						'min'  => 1,
						'max'  => 20,
						'step' => 1,
					],
				],
				'condition' => [
					'enable_animation' => 'yes',
				],
			]
		);

		$this->add_responsive_control(
			'animation_direction',
			[
				'label'     => esc_html__( 'Animation Direction', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SELECT,
				'default'   => 'horizontal',
				'options'   => [
					'horizontal' => esc_html__( 'Horizontal', 'lmscrafter-gradient-text-for-elementor' ),
					'vertical'   => esc_html__( 'Vertical', 'lmscrafter-gradient-text-for-elementor' ),
					'diagonal'   => esc_html__( 'Diagonal', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'selectors_dictionary' => [
					'horizontal' => 'lmsc-gte-gradient-flow-horizontal',
					'vertical'   => 'lmsc-gte-gradient-flow-vertical',
					'diagonal'   => 'lmsc-gte-gradient-flow-diagonal',
				],
				'selectors' => [
					'{{WRAPPER}}' => '--lmsc-gte-animation-name: {{VALUE}};',
				],
				'condition' => [
					'enable_animation' => 'yes',
				],
			]
		);

		$this->add_control(
			'animation_easing',
			[
				'label'     => esc_html__( 'Easing', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SELECT,
				'default'   => 'ease',
				'options'   => [
					'linear'      => esc_html__( 'Linear', 'lmscrafter-gradient-text-for-elementor' ),
					'ease'        => esc_html__( 'Ease', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-in'     => esc_html__( 'Ease In', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-out'    => esc_html__( 'Ease Out', 'lmscrafter-gradient-text-for-elementor' ),
					'ease-in-out' => esc_html__( 'Ease In-Out', 'lmscrafter-gradient-text-for-elementor' ),
				],
				'condition' => [
					'enable_animation' => 'yes',
				],
			]
		);

		$this->register_accessibility_controls( '{{WRAPPER}} .lmsc-gte-gradient-text' );

		// Text stroke controls.
		$this->add_control(
			'heading_stroke',
			[
				'label'     => esc_html__( 'Text Stroke', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::HEADING,
				'separator' => 'before',
			]
		);

		$this->add_control(
			'gradient_apply_to',
			[
				'label'   => esc_html__( 'Apply Gradient To', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'fill',
				'options' => [
					'fill'   => esc_html__( 'Fill', 'lmscrafter-gradient-text-for-elementor' ),
					'stroke' => esc_html__( 'Stroke (Outline)', 'lmscrafter-gradient-text-for-elementor' ),
					'both'   => esc_html__( 'Fill & Stroke', 'lmscrafter-gradient-text-for-elementor' ),
				],
			]
		);

		$this->add_control(
			'stroke_width',
			[
				'label'     => esc_html__( 'Stroke Width', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SLIDER,
				'default'   => [
					'size' => 2,
				],
				'range'     => [
					'px' => [
						'min'  => 1,
						'max'  => 10,
						'step' => 1,
					],
				],
				'condition' => [
					'gradient_apply_to' => [ 'stroke', 'both' ],
				],
			]
		);

		// Hover controls.
		$this->add_control(
			'heading_hover',
			[
				'label'     => esc_html__( 'Hover Gradient', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::HEADING,
				'separator' => 'before',
			]
		);

		$this->add_control(
			'enable_hover',
			[
				'label'        => esc_html__( 'Enable Hover Effect', 'lmscrafter-gradient-text-for-elementor' ),
				'type'         => Controls_Manager::SWITCHER,
				'label_on'     => esc_html__( 'Yes', 'lmscrafter-gradient-text-for-elementor' ),
				'label_off'    => esc_html__( 'No', 'lmscrafter-gradient-text-for-elementor' ),
				'return_value' => 'yes',
				'default'      => '',
			]
		);

		$this->add_control(
			'hover_color_1',
			[
				'label'     => esc_html__( 'Hover Color 1', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#11998e',
				'condition' => [
					'enable_hover' => 'yes',
				],
			]
		);

		$this->register_stop_control(
			'hover_color_1_stop',
			esc_html__( 'Hover Color 1 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[ 'enable_hover' => 'yes' ]
		);

		$this->add_control(
			'hover_color_2',
			[
				'label'     => esc_html__( 'Hover Color 2', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#38ef7d',
				'condition' => [
					'enable_hover' => 'yes',
				],
			]
		);

		$this->register_stop_control(
			'hover_color_2_stop',
			esc_html__( 'Hover Color 2 Position', 'lmscrafter-gradient-text-for-elementor' ),
			[ 'enable_hover' => 'yes' ]
		);

		$this->end_controls_section();
	}

	/**
	 * Register highlight effect style controls.
	 *
	 * Adds controls for the gradient pill, underline, marker,
	 * and glow effects on highlighted text.
	 *
	 * @since 1.4.0
	 *
	 * @return void
	 */
	private function register_highlight_effect_controls() {
		$this->start_controls_section(
			'section_highlight_effect',
			[
				'label'     => esc_html__( 'Highlight Effect', 'lmscrafter-gradient-text-for-elementor' ),
				'tab'       => Controls_Manager::TAB_STYLE,
				'condition' => [
					'enable_highlight' => 'yes',
				],
			]
		);

		$this->add_control(
			'highlight_style',
			[
				'label'   => esc_html__( 'Highlight Style', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::SELECT,
				'default' => 'none',
				'options' => [
					'none'      => esc_html__( 'None (Gradient Text Only)', 'lmscrafter-gradient-text-for-elementor' ),
					'pill'      => esc_html__( 'Pill', 'lmscrafter-gradient-text-for-elementor' ),
					'underline' => esc_html__( 'Underline', 'lmscrafter-gradient-text-for-elementor' ),
					'marker'    => esc_html__( 'Marker', 'lmscrafter-gradient-text-for-elementor' ),
					'glow'      => esc_html__( 'Glow', 'lmscrafter-gradient-text-for-elementor' ),
				],
			]
		);

		$this->add_control(
			'highlight_text_color',
			[
				'label'     => esc_html__( 'Highlighted Text Color', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::COLOR,
				'default'   => '#FFFFFF',
				'condition' => [
					'highlight_style!' => 'none',
				],
				'description' => esc_html__( 'Text color inside the highlight effect.', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);

		$this->add_control(
			'highlight_padding',
			[
				'label'     => esc_html__( 'Padding', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SLIDER,
				'default'   => [
					'size' => 8,
				],
				'range'     => [
					'px' => [
						'min'  => 0,
						'max'  => 30,
						'step' => 1,
					],
				],
				'condition' => [
					'highlight_style' => [ 'pill', 'marker' ],
				],
			]
		);

		$this->add_control(
			'highlight_border_radius',
			[
				'label'     => esc_html__( 'Border Radius', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SLIDER,
				'default'   => [
					'size' => 6,
				],
				'range'     => [
					'px' => [
						'min'  => 0,
						'max'  => 50,
						'step' => 1,
					],
				],
				'condition' => [
					'highlight_style' => [ 'pill', 'marker' ],
				],
			]
		);

		$this->add_control(
			'underline_height',
			[
				'label'     => esc_html__( 'Underline Height', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::SLIDER,
				'default'   => [
					'size' => 4,
				],
				'range'     => [
					'px' => [
						'min'  => 1,
						'max'  => 20,
						'step' => 1,
					],
				],
				'condition' => [
					'highlight_style' => 'underline',
				],
			]
		);

		$this->end_controls_section();
	}

	/**
	 * Register typography style controls.
	 *
	 * Adds Elementor typography group control and text shadow control.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	private function register_typography_controls() {
		$this->start_controls_section(
			'section_typography',
			[
				'label' => esc_html__( 'Typography', 'lmscrafter-gradient-text-for-elementor' ),
				'tab'   => Controls_Manager::TAB_STYLE,
			]
		);

		$this->add_group_control(
			Group_Control_Typography::get_type(),
			[
				'name'     => 'text_typography',
				'selector' => '{{WRAPPER}} .lmsc-gte-gradient-text',
			]
		);

		$this->add_group_control(
			Group_Control_Text_Shadow::get_type(),
			[
				'name'     => 'text_shadow',
				'selector' => '{{WRAPPER}} .lmsc-gte-gradient-text-wrapper',
			]
		);

		$this->end_controls_section();
	}

	/**
	 * Build the gradient span HTML for the highlighted words.
	 *
	 * @since 1.4.0
	 *
	 * @param string $gradient_words The text to apply gradient to.
	 * @param array  $settings       Widget settings array.
	 * @param string $gradient       CSS gradient value.
	 * @return string HTML span with gradient applied.
	 */
	private function build_gradient_span( $gradient_words, $settings, $gradient ) {
		$highlight_style = isset( $settings['highlight_style'] ) ? $settings['highlight_style'] : 'none';
		$fallback_color  = $this->sanitize_color( $settings['fallback_color'] ?? '#333333' );

		if ( 'none' === $highlight_style ) {
			// Gradient text only — no decoration.
			$span_style = sprintf(
				'background-image:%1$s;--lmsc-gte-gradient:%1$s;--lmsc-gte-fallback-color:%2$s;color:%2$s;display:inline;',
				$gradient,
				$fallback_color
			);
			return sprintf(
				'<span class="lmsc-gte-highlight lmsc-gte-hl-gradient-text" style="%s">%s</span>',
				esc_attr( $span_style ),
				esc_html( $gradient_words )
			);
		}

		// Effects: pill, underline, marker, glow.
		$hl_text_color = isset( $settings['highlight_text_color'] ) ? $this->sanitize_color( $settings['highlight_text_color'] ) : '#FFFFFF';

		if ( 'pill' === $highlight_style ) {
			$padding = isset( $settings['highlight_padding']['size'] ) ? min( 30, max( 0, (int) $settings['highlight_padding']['size'] ) ) : 8;
			$radius  = isset( $settings['highlight_border_radius']['size'] ) ? min( 50, max( 0, (int) $settings['highlight_border_radius']['size'] ) ) : 6;
			$span_style = sprintf(
				'background: %s; color: %s; -webkit-text-fill-color: %s; -webkit-background-clip: padding-box; background-clip: padding-box; padding: 2px %dpx; border-radius: %dpx; box-decoration-break: clone; -webkit-box-decoration-break: clone; display: inline;',
				$gradient, $hl_text_color, $hl_text_color, $padding, $radius
			);
			$span_class = 'lmsc-gte-highlight lmsc-gte-hl-pill';

		} elseif ( 'underline' === $highlight_style ) {
			$ul_height = isset( $settings['underline_height']['size'] ) ? min( 20, max( 1, (int) $settings['underline_height']['size'] ) ) : 4;
			$span_style = sprintf(
				'background-image:%1$s;--lmsc-gte-gradient:%1$s;--lmsc-gte-fallback-color:%2$s;color:%2$s;display:inline;position:relative;padding-bottom:2px;--lmsc-gte-hl-gradient:%1$s;--lmsc-gte-hl-underline-height:%3$dpx;',
				$gradient,
				$fallback_color,
				$ul_height
			);
			$span_class = 'lmsc-gte-highlight lmsc-gte-hl-underline';

		} elseif ( 'marker' === $highlight_style ) {
			$padding = isset( $settings['highlight_padding']['size'] ) ? min( 30, max( 0, (int) $settings['highlight_padding']['size'] ) ) : 8;
			$radius  = isset( $settings['highlight_border_radius']['size'] ) ? min( 50, max( 0, (int) $settings['highlight_border_radius']['size'] ) ) : 6;
			$span_style = sprintf(
				'background: %s; color: %s; -webkit-text-fill-color: %s; -webkit-background-clip: padding-box; background-clip: padding-box; padding: 2px %dpx; border-radius: %dpx; box-decoration-break: clone; -webkit-box-decoration-break: clone; display: inline-block; transform: skewX(-2deg);',
				$gradient, $hl_text_color, $hl_text_color, $padding, $radius
			);
			$span_class = 'lmsc-gte-highlight lmsc-gte-hl-marker';

		} elseif ( 'glow' === $highlight_style ) {
			$span_style = sprintf(
				'background-image:%1$s;--lmsc-gte-gradient:%1$s;--lmsc-gte-fallback-color:%2$s;color:%2$s;display:inline;filter:drop-shadow(0 0 8px rgba(255,100,200,.5)) drop-shadow(0 0 20px rgba(120,100,255,.3));',
				$gradient,
				$fallback_color
			);
			$span_class = 'lmsc-gte-highlight lmsc-gte-hl-glow';

		} else {
			// Fallback.
			$span_style = sprintf(
				'background-image:%1$s;--lmsc-gte-gradient:%1$s;--lmsc-gte-fallback-color:%2$s;color:%2$s;display:inline;',
				$gradient,
				$fallback_color
			);
			$span_class = 'lmsc-gte-highlight lmsc-gte-hl-gradient-text';
		}

		return sprintf(
			'<span class="%s" style="%s">%s</span>',
			esc_attr( $span_class ),
			esc_attr( $span_style ),
			esc_html( $gradient_words )
		);
	}

	/**
	 * Render ordered plain/gradient segments for multi-highlight headings.
	 *
	 * @since 2.0.0
	 *
	 * @param array  $segments Ordered repeater rows.
	 * @param array  $settings Widget settings.
	 * @param string $gradient CSS gradient value.
	 * @return string Escaped HTML.
	 */
	private function build_segmented_highlight_html( array $segments, array $settings, string $gradient ): string {
		$output = '';

		foreach ( $segments as $segment ) {
			if ( ! is_array( $segment ) ) {
				continue;
			}

			$text = isset( $segment['segment_text'] ) ? (string) $segment['segment_text'] : '';
			if ( '' === $text ) {
				continue;
			}

			if ( 'gradient' === ( $segment['segment_type'] ?? 'plain' ) ) {
				$output .= $this->build_gradient_span( $text, $settings, $gradient );
			} else {
				$output .= esc_html( $text );
			}

			if ( 'yes' === ( $segment['append_space'] ?? '' ) ) {
				$output .= ' ';
			}
		}

		return rtrim( $output );
	}

	/**
	 * Render widget output on the frontend.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	protected function render() {
		$settings = $this->get_settings_for_display();
		$tag      = isset( $settings['html_tag'] ) ? (string) $settings['html_tag'] : 'h2';
		$gradient = $this->make_gradient_angle_responsive( $this->build_gradient( $settings ), $settings );

		// Whitelist allowed HTML tags.
		$allowed_tags = [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'span', 'div' ];
		if ( ! in_array( $tag, $allowed_tags, true ) ) {
			$tag = 'h2';
		}

		$is_partial = ( 'yes' === ( $settings['enable_highlight'] ?? '' ) );
		$classes    = $this->build_gradient_classes( $settings, 'lmsc-gte-gradient-text' );
		$style      = $this->build_gradient_style( $settings, $gradient );

		if ( $is_partial ) {
			$base_color = isset( $settings['base_text_color'] ) ? $this->sanitize_color( $settings['base_text_color'] ) : '#333333';
			$classes   .= ' lmsc-gte-partial-mode';
			$style     .= sprintf( 'color:%s;', $base_color );

			if ( 'segments' === ( $settings['highlight_mode'] ?? 'legacy' ) ) {
				$segments    = isset( $settings['highlight_segments'] ) && is_array( $settings['highlight_segments'] ) ? $settings['highlight_segments'] : [];
				$text_output = $this->build_segmented_highlight_html( $segments, $settings, $gradient );
			} else {
				$before_text    = isset( $settings['before_text'] ) ? (string) $settings['before_text'] : '';
				$gradient_words = isset( $settings['gradient_words'] ) ? (string) $settings['gradient_words'] : '';
				$after_text     = isset( $settings['after_text'] ) ? (string) $settings['after_text'] : '';

				$text_output = '';
				if ( '' !== $before_text ) {
					$text_output .= esc_html( $before_text ) . ' ';
				}
				if ( '' !== $gradient_words ) {
					$text_output .= $this->build_gradient_span( $gradient_words, $settings, $gradient );
				}
				if ( '' !== $after_text ) {
					$text_output .= ' ' . esc_html( $after_text );
				}
			}

			if ( '' === trim( wp_strip_all_tags( $text_output ) ) ) {
				return;
			}

		} else {
			$text = isset( $settings['text'] ) ? (string) $settings['text'] : '';

			if ( '' === trim( $text ) ) {
				return;
			}

			$text_output = esc_html( $text );
		}

		// Link handling.
		$has_link = ! empty( $settings['link']['url'] );
		$label    = isset( $settings['accessible_label'] ) ? sanitize_text_field( (string) $settings['accessible_label'] ) : '';

		echo '<div class="lmsc-gte-gradient-text-wrapper">';

		if ( $has_link ) {
			$this->add_link_attributes( 'link', $settings['link'] );
			if ( '' !== $label ) {
				$this->add_render_attribute( 'link', 'aria-label', $label );
			}
			$link_attrs = $this->get_render_attribute_string( 'link' );

			printf(
				'<%1$s class="lmsc-gte-gradient-text-wrapper-tag"><a %2$s class="%3$s" style="%4$s">%5$s</a></%1$s>',
				esc_attr( $tag ),
				$link_attrs, // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped -- Elementor handles link attribute escaping.
				esc_attr( $classes ),
				esc_attr( $style ),
				$text_output // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped -- Content escaped in build_gradient_span().
			);
		} else {
			$aria_attribute = '' !== $label ? sprintf( ' aria-label="%s"', esc_attr( $label ) ) : '';
			printf(
				'<%1$s class="%2$s" style="%3$s"%5$s>%4$s</%1$s>',
				esc_attr( $tag ),
				esc_attr( $classes ),
				esc_attr( $style ),
				$text_output, // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped -- Content escaped in build_gradient_span().
				$aria_attribute // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped -- Attribute value escaped above.
			);
		}

		echo '</div>';
	}

	/**
	 * Render widget output in the Elementor editor via JS template.
	 *
	 * @since 1.0.0
	 *
	 * @return void
	 */
	protected function content_template() {
		?>
		<#
		var preview = window.LmscGtePreview;
		var allowedTags = [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'span', 'div' ];
		var tag = allowedTags.indexOf( settings.html_tag ) >= 0 ? settings.html_tag : 'h2';
		var isPartial = ( 'yes' === settings.enable_highlight );
		var classes = 'lmsc-gte-gradient-text';
		var style = '';
		var textOutput = '';
		var linkUrl = preview && preview.sanitizeUrl ? preview.sanitizeUrl( settings.link && settings.link.url ) : '';
		var hasLink = Boolean( linkUrl );
		var accessibleLabel = settings.accessible_label || '';

		if ( preview ) {
			var presets = <?php echo wp_json_encode( $this->get_preset_gradients() ); ?>;
			var brandGradients = <?php echo wp_json_encode( $this->get_brand_gradient_editor_css() ); ?>;
			var previewSettings = Object.assign( {}, settings, {
				visual_gradient_stops: settings.visual_gradient_stops,
				brand_gradient: settings.brand_gradient,
				radial_shape: settings.radial_shape,
				radial_position: settings.radial_position
			} );
			var gradient = preview.buildGradient( previewSettings, presets, brandGradients );
			classes = preview.buildClasses( previewSettings, classes );
			style = preview.buildStyle( previewSettings, gradient, presets );

			var makeHighlightSpan = function( text ) {
				var highlightStyle = settings.highlight_style || 'none';
				var fallbackColor = preview.color( settings.fallback_color, '#333333' );
				var textColor = preview.color( settings.highlight_text_color, '#FFFFFF' );
				var spanClass = 'lmsc-gte-highlight lmsc-gte-hl-gradient-text';
				var spanStyle = 'background-image:' + gradient + ';--lmsc-gte-gradient:' + gradient + ';--lmsc-gte-fallback-color:' + fallbackColor + ';color:' + fallbackColor + ';display:inline;';

				if ( 'pill' === highlightStyle || 'marker' === highlightStyle ) {
					var padding = preview.clamp( settings.highlight_padding && settings.highlight_padding.size, 0, 30, 8 );
					var radius = preview.clamp( settings.highlight_border_radius && settings.highlight_border_radius.size, 0, 50, 6 );
					spanClass = 'lmsc-gte-highlight lmsc-gte-hl-' + highlightStyle;
					spanStyle = 'background:' + gradient + ';color:' + textColor + ';-webkit-text-fill-color:' + textColor + ';-webkit-background-clip:padding-box;background-clip:padding-box;padding:2px ' + padding + 'px;border-radius:' + radius + 'px;box-decoration-break:clone;-webkit-box-decoration-break:clone;display:' + ( 'marker' === highlightStyle ? 'inline-block;transform:skewX(-2deg);' : 'inline;' );
				} else if ( 'underline' === highlightStyle ) {
					var underlineHeight = preview.clamp( settings.underline_height && settings.underline_height.size, 1, 20, 4 );
					spanClass = 'lmsc-gte-highlight lmsc-gte-hl-underline';
					spanStyle += 'position:relative;padding-bottom:2px;--lmsc-gte-hl-gradient:' + gradient + ';--lmsc-gte-hl-underline-height:' + underlineHeight + 'px;';
				} else if ( 'glow' === highlightStyle ) {
					spanClass = 'lmsc-gte-highlight lmsc-gte-hl-glow';
					spanStyle += 'filter:drop-shadow(0 0 8px rgba(255,100,200,.5)) drop-shadow(0 0 20px rgba(120,100,255,.3));';
				}

				return '<span class="' + preview.escapeAttribute( spanClass ) + '" style="' + preview.escapeAttribute( spanStyle ) + '">' + _.escape( text ) + '</span>';
			};

			if ( isPartial ) {
				classes += ' lmsc-gte-partial-mode';
				style += 'color:' + preview.color( settings.base_text_color, '#333333' ) + ';';

				if ( 'segments' === settings.highlight_mode ) {
					( Array.isArray( settings.highlight_segments ) ? settings.highlight_segments : [] ).forEach( function( segment ) {
						if ( ! segment || ! segment.segment_text ) {
							return;
						}
						textOutput += 'gradient' === segment.segment_type ? makeHighlightSpan( segment.segment_text ) : _.escape( segment.segment_text );
						if ( 'yes' === segment.append_space ) {
							textOutput += ' ';
						}
					} );
					textOutput = textOutput.replace( /\s+$/, '' );
				} else {
					var beforeText = settings.before_text || '';
					var gradientWords = settings.gradient_words || '';
					var afterText = settings.after_text || '';
					textOutput = ( beforeText ? _.escape( beforeText ) + ' ' : '' ) + ( gradientWords ? makeHighlightSpan( gradientWords ) : '' ) + ( afterText ? ' ' + _.escape( afterText ) : '' );
				}
			} else {
				textOutput = _.escape( settings.text || 'Gradient Text' );
			}
		} else {
			// Keep the editor readable if the preview helper is unavailable.
			// Frontend rendering remains authoritative and fully styled in PHP.
			if ( isPartial && 'segments' === settings.highlight_mode ) {
					( Array.isArray( settings.highlight_segments ) ? settings.highlight_segments : [] ).forEach( function( segment ) {
					if ( ! segment || ! segment.segment_text ) {
						return;
					}
					textOutput += _.escape( segment.segment_text );
					if ( 'yes' === segment.append_space ) {
						textOutput += ' ';
					}
				} );
				textOutput = textOutput.replace( /\s+$/, '' );
			} else if ( isPartial ) {
				textOutput = [ settings.before_text, settings.gradient_words, settings.after_text ]
					.filter( function( value ) { return Boolean( value ); } )
					.map( function( value ) { return _.escape( value ); } )
					.join( ' ' );
			} else {
				textOutput = _.escape( settings.text || 'Gradient Text' );
			}
		}
		#>

		<div class="lmsc-gte-gradient-text-wrapper">
			<# if ( hasLink ) { #>
				<{{{ tag }}} class="lmsc-gte-gradient-text-wrapper-tag">
					<a href="{{ linkUrl }}" class="{{ classes }}" style="{{ style }}"<# if ( accessibleLabel ) { #> aria-label="{{ accessibleLabel }}"<# } #>>
						{{{ textOutput }}}
					</a>
				</{{{ tag }}}>
			<# } else { #>
				<{{{ tag }}} class="{{ classes }}" style="{{ style }}"<# if ( accessibleLabel ) { #> aria-label="{{ accessibleLabel }}"<# } #>>
					{{{ textOutput }}}
				</{{{ tag }}}>
			<# } #>
		</div>
		<?php
	}

	/**
	 * Render plain text output for SEO and accessibility.
	 *
	 * Outputs clean text without gradient markup so that search engines,
	 * RSS feeds, and screen readers can parse the content.
	 *
	 * @since 1.6.0
	 *
	 * @return void
	 */
	public function render_plain_content() {
		$settings   = $this->get_settings_for_display();
		$is_partial = ( 'yes' === ( $settings['enable_highlight'] ?? '' ) );

		if ( $is_partial ) {
			if ( 'segments' === ( $settings['highlight_mode'] ?? 'legacy' ) ) {
				$plain = '';
				foreach ( (array) ( $settings['highlight_segments'] ?? [] ) as $segment ) {
					if ( ! is_array( $segment ) || empty( $segment['segment_text'] ) ) {
						continue;
					}
					$plain .= (string) $segment['segment_text'];
					if ( 'yes' === ( $segment['append_space'] ?? '' ) ) {
						$plain .= ' ';
					}
				}
				echo esc_html( rtrim( $plain ) );
			} else {
				$before = isset( $settings['before_text'] ) ? (string) $settings['before_text'] : '';
				$words  = isset( $settings['gradient_words'] ) ? (string) $settings['gradient_words'] : '';
				$after  = isset( $settings['after_text'] ) ? (string) $settings['after_text'] : '';
				echo esc_html( trim( $before . ' ' . $words . ' ' . $after ) );
			}
		} else {
			echo esc_html( (string) ( $settings['text'] ?? '' ) );
		}
	}
}
