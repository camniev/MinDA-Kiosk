<?php
/**
 * Validation and CSS generation for saved brand gradients.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Keeps the persisted gradient shape small, deterministic, and safe for CSS.
 */
final class Brand_Gradient_Schema {

	/** Minimum and maximum number of supported color stops. */
	const MIN_STOPS = 2;
	const MAX_STOPS = 5;

	/**
	 * Sanitize and validate one gradient.
	 *
	 * @param array  $input Raw gradient data.
	 * @param string $id    Stable existing/imported ID.
	 * @return array
	 * @throws \InvalidArgumentException When required data is invalid.
	 */
	public function sanitize_gradient( array $input, string $id = '' ): array {
		$name = $this->sanitize_name( $input['name'] ?? '' );
		if ( '' === $name ) {
			throw new \InvalidArgumentException( esc_html__( 'Give the gradient a name.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		if ( isset( $input['type'] ) && ! is_scalar( $input['type'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient type must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$type = strtolower( (string) ( $input['type'] ?? 'linear' ) );
		if ( ! in_array( $type, [ 'linear', 'radial', 'conic' ], true ) ) {
			$type = 'linear';
		}

		if ( isset( $input['angle'] ) && ! is_scalar( $input['angle'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient angle must be a number.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$angle = is_numeric( $input['angle'] ?? null ) ? (float) $input['angle'] : 90.0;
		$angle = max( 0, min( 360, $angle ) );

		if ( isset( $input['radial_shape'] ) && ! is_scalar( $input['radial_shape'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Radial shape must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$radial_shape = strtolower( (string) ( $input['radial_shape'] ?? 'circle' ) );
		if ( ! in_array( $radial_shape, [ 'circle', 'ellipse' ], true ) ) {
			$radial_shape = 'circle';
		}

		if ( isset( $input['center_position'] ) && ! is_scalar( $input['center_position'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient center position must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$center_position = strtolower( preg_replace( '/\s+/', ' ', trim( (string) ( $input['center_position'] ?? 'center' ) ) ) );
		$allowed_centers = [
			'center',
			'top',
			'top right',
			'right',
			'bottom right',
			'bottom',
			'bottom left',
			'left',
			'top left',
		];
		if ( ! in_array( $center_position, $allowed_centers, true ) ) {
			$center_position = 'center';
		}

		$stops = $input['stops'] ?? [];
		if ( ! is_array( $stops ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient stops must be an array.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$stops = array_values( $stops );
		$count = count( $stops );
		if ( self::MIN_STOPS > $count || self::MAX_STOPS < $count ) {
			throw new \InvalidArgumentException(
				sprintf(
					/* translators: 1: minimum stops, 2: maximum stops. */
					esc_html__( 'A brand gradient must contain between %1$d and %2$d color stops.', 'lmscrafter-gradient-text-for-elementor' ),
					absint( self::MIN_STOPS ),
					absint( self::MAX_STOPS )
				)
			);
		}

		$clean_stops = [];
		foreach ( $stops as $index => $stop ) {
			if ( ! is_array( $stop ) ) {
				throw new \InvalidArgumentException( esc_html__( 'Each gradient stop must be an object.', 'lmscrafter-gradient-text-for-elementor' ) );
			}

			$position = $stop['position'] ?? null;
			if ( null !== $position && '' !== $position && ! is_scalar( $position ) ) {
				throw new \InvalidArgumentException( esc_html__( 'A gradient stop position must be a number.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			if ( '' === $position || null === $position || ! is_numeric( $position ) ) {
				$position = ( self::MIN_STOPS === $count ) ? $index * 100 : ( $index * 100 ) / ( $count - 1 );
			}
			$position = round( max( 0, min( 100, (float) $position ) ), 2 );

			$clean_stops[] = $this->sanitize_stop( $stop, $position, $index );
		}

		// CSS gradients are position-ordered. Retain submitted order for equal stops.
		usort(
			$clean_stops,
			static function ( array $left, array $right ): int {
				if ( $left['position'] === $right['position'] ) {
					return $left['_order'] <=> $right['_order'];
				}
				return $left['position'] <=> $right['position'];
			}
		);
		foreach ( $clean_stops as &$stop ) {
			unset( $stop['_order'] );
		}
		unset( $stop );

		$raw_id = '' !== $id ? $id : ( $input['id'] ?? '' );
		if ( ! is_scalar( $raw_id ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient ID must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		return [
			'id'              => $this->sanitize_id( (string) $raw_id ),
			'name'            => $name,
			'type'            => $type,
			'angle'           => $this->normalize_number( $angle ),
			'radial_shape'    => $radial_shape,
			'center_position' => $center_position,
			'stops'           => $clean_stops,
		];
	}

	/**
	 * Build a safe CSS image value from an already sanitized gradient.
	 *
	 * @param array $gradient Sanitized gradient.
	 * @return string
	 */
	public function build_css( array $gradient ): string {
		$raw_id = $gradient['id'] ?? '';
		if ( ! is_scalar( $raw_id ) ) {
			return '';
		}

		try {
			$gradient = $this->sanitize_gradient( $gradient, (string) $raw_id );
		} catch ( \InvalidArgumentException $error ) {
			return '';
		}

		$parts = [];
		foreach ( $gradient['stops'] as $stop ) {
			$parts[] = sprintf(
				'%s %s%%',
				$this->resolve_stop_color( $stop ),
				$this->format_number( (float) $stop['position'] )
			);
		}
		$stops = implode( ', ', $parts );

		if ( 'radial' === $gradient['type'] ) {
			return sprintf( 'radial-gradient(%s at %s, %s)', $gradient['radial_shape'], $gradient['center_position'], $stops );
		}

		if ( 'conic' === $gradient['type'] ) {
			return sprintf(
				'conic-gradient(from %sdeg at %s, %s)',
				$this->format_number( (float) $gradient['angle'] ),
				$gradient['center_position'],
				$stops
			);
		}

		return sprintf( 'linear-gradient(%sdeg, %s)', $this->format_number( (float) $gradient['angle'] ), $stops );
	}

	/**
	 * Convert one gradient to the setting keys used by the existing widgets.
	 *
	 * Global colors remain CSS variables. Callers should use the module's
	 * color sanitizer when consuming these values.
	 *
	 * @param array $gradient Sanitized gradient.
	 * @return array
	 */
	public function to_elementor_settings( array $gradient ): array {
		$raw_id = $gradient['id'] ?? '';
		if ( ! is_scalar( $raw_id ) ) {
			return [];
		}

		try {
			$gradient = $this->sanitize_gradient( $gradient, (string) $raw_id );
		} catch ( \InvalidArgumentException $error ) {
			return [];
		}

		$settings = [
			'gradient_source'    => 'brand',
			'brand_gradient'     => $gradient['id'],
			'brand_gradient_css' => $this->build_css( $gradient ),
			'gradient_type'      => $gradient['type'],
			'gradient_direction' => 'custom',
			'radial_shape'       => $gradient['radial_shape'],
			'radial_position'    => str_replace( ' ', '_', $gradient['center_position'] ),
			'center_position'    => $gradient['center_position'],
			'gradient_angle'     => [
				'size' => $gradient['angle'],
				'unit' => 'deg',
			],
			'enable_color_3'     => '',
			'enable_color_4'     => '',
			'enable_color_5'     => '',
		];

		foreach ( $gradient['stops'] as $index => $stop ) {
			$number = $index + 1;
			$settings[ 'color_' . $number ] = $this->resolve_stop_color( $stop );
			$settings[ 'color_' . $number . '_stop' ] = [
				'size' => $stop['position'],
				'unit' => '%',
			];
			if ( 2 < $number ) {
				$settings[ 'enable_color_' . $number ] = 'yes';
			}
		}

		return $settings;
	}

	/**
	 * Sanitize a color for a custom stop or a global-color fallback.
	 *
	 * @param string $color Raw CSS color.
	 * @return string Empty string when invalid.
	 */
	public function sanitize_solid_color( string $color ): string {
		$color = trim( $color );
		if ( preg_match( '/^#(?:[A-Fa-f0-9]{3}|[A-Fa-f0-9]{4}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$/', $color ) ) {
			return strtolower( $color );
		}

		// Functional notation with exact component counts. The grammar excludes
		// variables, strings, semicolons, braces, and other CSS functions.
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
			return preg_replace( '/\s+/', ' ', $color );
		}

		return '';
	}

	/**
	 * Normalize an Elementor global color token.
	 *
	 * Accepts either an ID ("primary") or Elementor's CSS variable syntax.
	 * No Elementor class is called here, so this remains safe when Elementor
	 * is inactive or still loading.
	 *
	 * @param string $token Token or variable.
	 * @return string Empty string when invalid.
	 */
	public function sanitize_global_id( string $token ): string {
		$token = trim( $token );
		if ( preg_match( '/^var\(\s*--e-global-color-([A-Za-z0-9_-]{1,64})\s*\)$/', $token, $matches ) ) {
			$token = $matches[1];
		} elseif ( preg_match( '/^globals\/colors\?id=([A-Za-z0-9_-]{1,64})$/', $token, $matches ) ) {
			// Elementor stores this token form in a control's `_globals` map.
			$token = $matches[1];
		}

		if ( ! preg_match( '/^[A-Za-z0-9_-]{1,64}$/', $token ) ) {
			return '';
		}

		return strtolower( $token );
	}

	/**
	 * Turn a global ID into Elementor's CSS variable with a safe fallback.
	 *
	 * @param string $global_id Global color ID.
	 * @param string $fallback  Solid fallback color.
	 * @return string
	 */
	public function global_color_variable( string $global_id, string $fallback = '' ): string {
		$global_id = $this->sanitize_global_id( $global_id );
		$fallback  = $this->sanitize_solid_color( $fallback );
		if ( '' === $global_id ) {
			return '';
		}

		return '' === $fallback
			? sprintf( 'var(--e-global-color-%s)', $global_id )
			: sprintf( 'var(--e-global-color-%s, %s)', $global_id, $fallback );
	}

	/**
	 * Sanitize a complete Elementor CSS variable, including an optional solid
	 * fallback that may itself use functional color notation.
	 *
	 * @param string $variable Raw CSS variable.
	 * @return string Empty string when invalid.
	 */
	public function sanitize_global_variable( string $variable ): string {
		$variable = trim( $variable );
		if ( 6 > strlen( $variable ) || 0 !== strpos( $variable, 'var(' ) || ')' !== substr( $variable, -1 ) ) {
			return '';
		}

		$inner = trim( substr( $variable, 4, -1 ) );
		if ( ! preg_match( '/^--e-global-color-([A-Za-z0-9_-]{1,64})(?:\s*,\s*(.+))?$/', $inner, $matches ) ) {
			return '';
		}

		$fallback = isset( $matches[2] ) ? $this->sanitize_solid_color( $matches[2] ) : '';
		if ( isset( $matches[2] ) && '' === $fallback ) {
			return '';
		}

		return $this->global_color_variable( $matches[1], $fallback );
	}

	/**
	 * Resolve the CSS-safe color for one persisted stop.
	 *
	 * @param array $stop Sanitized stop.
	 * @return string
	 */
	public function resolve_stop_color( array $stop ): string {
		if ( 'global' === ( $stop['source'] ?? 'solid' ) ) {
			return $this->global_color_variable(
				(string) ( $stop['global_id'] ?? '' ),
				(string) ( $stop['fallback'] ?? '' )
			);
		}

		return $this->sanitize_solid_color( (string) ( $stop['color'] ?? '' ) );
	}

	/**
	 * Sanitize an option/document ID.
	 *
	 * @param string $id Raw ID.
	 * @return string
	 */
	public function sanitize_id( string $id ): string {
		$id = strtolower( trim( $id ) );
		$id = preg_replace( '/[^a-z0-9_-]/', '', $id );
		return substr( (string) $id, 0, 64 );
	}

	/**
	 * @param array $stop    Raw stop.
	 * @param float $position Sanitized position.
	 * @param int   $index    Original order.
	 * @return array
	 * @throws \InvalidArgumentException On invalid color data.
	 */
	private function sanitize_stop( array $stop, float $position, int $index ): array {
		if ( isset( $stop['source'] ) && ! is_scalar( $stop['source'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'A gradient stop source must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$source = strtolower( (string) ( $stop['source'] ?? 'solid' ) );
		if ( 'global' === $source ) {
			$raw_global_id = $stop['global_id'] ?? ( $stop['color'] ?? '' );
			if ( ! is_scalar( $raw_global_id ) ) {
				throw new \InvalidArgumentException( esc_html__( 'An Elementor Global Color token must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$global_id = $this->sanitize_global_id( (string) $raw_global_id );
			if ( '' === $global_id ) {
				throw new \InvalidArgumentException( esc_html__( 'An Elementor Global Color stop has an invalid token.', 'lmscrafter-gradient-text-for-elementor' ) );
			}

			$raw_fallback = $stop['fallback'] ?? '#000000';
			if ( ! is_scalar( $raw_fallback ) ) {
				throw new \InvalidArgumentException( esc_html__( 'A Global Color fallback must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$fallback = $this->sanitize_solid_color( (string) $raw_fallback );
			if ( '' === $fallback ) {
				$fallback = '#000000';
			}

			return [
				'source'    => 'global',
				'color'     => sprintf( 'var(--e-global-color-%s)', $global_id ),
				'global_id' => $global_id,
				'fallback'  => $fallback,
				'position'  => $this->normalize_number( $position ),
				'_order'    => $index,
			];
		}

		$raw_color = $stop['color'] ?? '';
		if ( ! is_scalar( $raw_color ) ) {
			throw new \InvalidArgumentException( esc_html__( 'A gradient stop color must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$color = $this->sanitize_solid_color( (string) $raw_color );
		if ( '' === $color ) {
			throw new \InvalidArgumentException( esc_html__( 'A gradient stop contains an invalid color.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		return [
			'source'   => 'solid',
			'color'    => $color,
			'position' => $this->normalize_number( $position ),
			'_order'   => $index,
		];
	}

	/**
	 * @param mixed $name Raw name.
	 * @return string
	 */
	private function sanitize_name( $name ): string {
		$name = is_scalar( $name ) ? (string) $name : '';
		$name = function_exists( 'sanitize_text_field' )
			? sanitize_text_field( $name )
			: ( function_exists( 'wp_strip_all_tags' ) ? wp_strip_all_tags( $name ) : preg_replace( '/<[^>]*>/', '', $name ) );
		$name = trim( preg_replace( '/\s+/', ' ', $name ) );
		return function_exists( 'mb_substr' ) ? mb_substr( $name, 0, 80 ) : substr( $name, 0, 80 );
	}

	/** @param float $number Number. @return int|float */
	private function normalize_number( float $number ) {
		return floor( $number ) === $number ? (int) $number : $number;
	}

	/** @param float $number Number. @return string */
	private function format_number( float $number ): string {
		return rtrim( rtrim( number_format( $number, 2, '.', '' ), '0' ), '.' );
	}
}
