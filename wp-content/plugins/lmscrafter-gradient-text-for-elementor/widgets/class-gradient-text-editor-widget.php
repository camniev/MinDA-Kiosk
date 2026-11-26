<?php
/**
 * Gradient Text Editor Widget for Elementor.
 *
 * Provides a WYSIWYG text editor widget with gradient text support,
 * allowing users to apply gradients to rich text content including
 * paragraphs, lists, and inline formatting.
 *
 * @package LMSC_GTE
 * @since   1.2.0
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
 * Gradient Text Editor Widget.
 *
 * A rich text editor widget that applies CSS gradient effects
 * to WYSIWYG content. Supports all the same gradient options
 * as the heading widget, plus rich text formatting.
 *
 * @since 1.2.0
 */
class Gradient_Text_Editor_Widget extends Widget_Base {

	use Gradient_Helper;

	/**
	 * Widget constructor.
	 *
	 * @since 1.2.0
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
	 * @since 1.2.0
	 *
	 * @return string Widget name.
	 */
	public function get_name() {
		return 'lmsc-gte-gradient-text-editor';
	}

	/**
	 * Get widget title.
	 *
	 * @since 1.2.0
	 *
	 * @return string Widget title.
	 */
	public function get_title() {
		return esc_html__( 'Gradient Text Editor', 'lmscrafter-gradient-text-for-elementor' );
	}

	/**
	 * Get widget icon.
	 *
	 * @since 1.2.0
	 *
	 * @return string Widget icon CSS class.
	 */
	public function get_icon() {
		return 'eicon-text';
	}

	/**
	 * Get widget categories.
	 *
	 * @since 1.2.0
	 *
	 * @return array Widget categories.
	 */
	public function get_categories() {
		return [ 'gradient-text', 'basic' ];
	}

	/**
	 * Get widget search keywords.
	 *
	 * @since 1.2.0
	 *
	 * @return array Widget keywords.
	 */
	public function get_keywords() {
		return [ 'gradient', 'text', 'editor', 'paragraph', 'content', 'wysiwyg', 'color' ];
	}

	/**
	 * Get style dependencies.
	 *
	 * @since 1.2.0
	 *
	 * @return array Style handle dependencies.
	 */
	public function get_style_depends() {
		return [ 'lmsc-gte-gradient-text' ];
	}

	/**
	 * Register widget controls.
	 *
	 * @since 1.2.0
	 *
	 * @return void
	 */
	protected function register_controls() {
		$this->register_content_controls();
		$this->register_gradient_controls();
		$this->register_typography_controls();
	}

	/**
	 * Register content tab controls.
	 *
	 * Adds WYSIWYG text editor and responsive alignment controls.
	 *
	 * @since 1.2.0
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
			'editor_content',
			[
				'label'   => esc_html__( 'Text Editor', 'lmscrafter-gradient-text-for-elementor' ),
				'type'    => Controls_Manager::WYSIWYG,
				'default' => '<p>' . esc_html__( 'Add your gradient text here. You can use bold, italic, lists, and any other formatting.', 'lmscrafter-gradient-text-for-elementor' ) . '</p>',
				'dynamic' => [ 'active' => true ],
			]
		);

		$this->add_responsive_control(
			'text_align',
			[
				'label'     => esc_html__( 'Alignment', 'lmscrafter-gradient-text-for-elementor' ),
				'type'      => Controls_Manager::CHOOSE,
				'options'   => [
					'left'    => [
						'title' => esc_html__( 'Left', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-left',
					],
					'center'  => [
						'title' => esc_html__( 'Center', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-center',
					],
					'right'   => [
						'title' => esc_html__( 'Right', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-right',
					],
					'justify' => [
						'title' => esc_html__( 'Justify', 'lmscrafter-gradient-text-for-elementor' ),
						'icon'  => 'eicon-text-align-justify',
					],
				],
				'default'   => 'left',
				'selectors' => [
					'{{WRAPPER}} .lmsc-gte-gradient-editor' => 'text-align: {{VALUE}};',
				],
			]
		);

		$this->end_controls_section();
	}

	/**
	 * Register gradient style controls.
	 *
	 * @since 1.2.0
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

		$this->register_accessibility_controls( '{{WRAPPER}} .lmsc-gte-gradient-editor' );

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
	 * Register typography style controls.
	 *
	 * @since 1.2.0
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
				'name'     => 'editor_typography',
				'selector' => '{{WRAPPER}} .lmsc-gte-gradient-editor',
			]
		);

		$this->add_group_control(
			Group_Control_Text_Shadow::get_type(),
			[
				'name'     => 'text_shadow',
				'selector' => '{{WRAPPER}} .lmsc-gte-gradient-editor',
			]
		);

		$this->end_controls_section();
	}

	/**
	 * Render widget output on the frontend.
	 *
	 * Uses `wp_kses_post` to sanitize WYSIWYG content while
	 * preserving safe HTML tags and attributes.
	 *
	 * @since 1.2.0
	 *
	 * @return void
	 */
	protected function render() {
		$settings = $this->get_settings_for_display();
		$content  = $settings['editor_content'];

		if ( empty( $content ) ) {
			return;
		}

		$gradient = $this->make_gradient_angle_responsive( $this->build_gradient( $settings ), $settings );
		$classes  = $this->build_gradient_classes( $settings, 'lmsc-gte-gradient-editor' );
		$style    = $this->build_gradient_style( $settings, $gradient );

		printf(
			'<div class="%s" style="%s">%s</div>',
			esc_attr( $classes ),
			esc_attr( $style ),
			wp_kses_post( $content )
		);
	}

	/**
	 * Render widget output in the Elementor editor via JS template.
	 *
	 * @since 1.2.0
	 *
	 * @return void
	 */
	protected function content_template() {
		?>
		<#
		var preview = window.LmscGtePreview;
		var classes = 'lmsc-gte-gradient-editor';
		var style = '';
		var content = settings.editor_content || '';

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
		}
		#>

		<div class="{{ classes }}" style="{{ style }}">
			{{{ content }}}
		</div>
		<?php
	}

	/**
	 * Render plain text output for SEO and accessibility.
	 *
	 * Outputs clean text stripped of gradient markup so that search engines,
	 * RSS feeds, and screen readers can parse the content.
	 *
	 * @since 1.6.0
	 *
	 * @return void
	 */
	public function render_plain_content() {
		$settings = $this->get_settings_for_display();
		$content  = $settings['editor_content'];

		if ( ! empty( $content ) ) {
			echo wp_kses_post( $content );
		}
	}
}
