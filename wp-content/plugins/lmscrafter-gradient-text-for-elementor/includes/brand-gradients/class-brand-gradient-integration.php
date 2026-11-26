<?php
/**
 * Public integration helpers for Elementor widgets and extensions.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/** Stable read-only API for widget code. */
final class Brand_Gradient_Integration {

	/** @var Brand_Gradient_Repository */
	private $repository;

	/** @var Brand_Gradient_Schema */
	private $schema;

	/** @param Brand_Gradient_Repository $repository Repository. @param Brand_Gradient_Schema $schema Schema. */
	public function __construct( Brand_Gradient_Repository $repository, Brand_Gradient_Schema $schema ) {
		$this->repository = $repository;
		$this->schema     = $schema;
	}

	/** @return array Options suitable for Elementor Controls_Manager::SELECT. */
	public function get_options(): array {
		$options = $this->repository->options();
		$filtered = apply_filters( 'lmsc_gte_brand_gradient_options', $options, $this->repository->all() );
		if ( ! is_array( $filtered ) ) {
			return $options;
		}

		$clean = [];
		foreach ( $filtered as $id => $label ) {
			$id = $this->schema->sanitize_id( (string) $id );
			if ( '' === $id || ! is_scalar( $label ) ) {
				continue;
			}
			$clean[ $id ] = sanitize_text_field( (string) $label );
		}
		return $clean;
	}

	/**
	 * Return a keyed, JSON-ready map for Elementor content templates.
	 *
	 * Each record contains the sanitized structured data plus a prebuilt CSS
	 * value, so editor JavaScript does not need to duplicate validation rules.
	 *
	 * @return array
	 */
	public function get_for_editor(): array {
		$records = [];
		foreach ( $this->repository->all() as $gradient ) {
			$gradient['css']          = $this->schema->build_css( $gradient );
			$records[ $gradient['id'] ] = $gradient;
		}
		$filtered = apply_filters( 'lmsc_gte_brand_gradients_for_editor', $records );
		if ( ! is_array( $filtered ) ) {
			return $records;
		}

		$clean = [];
		foreach ( $filtered as $id => $gradient ) {
			if ( ! is_array( $gradient ) ) {
				continue;
			}
			$raw_id = $gradient['id'] ?? $id;
			if ( ! is_scalar( $raw_id ) ) {
				continue;
			}
			$id = $this->schema->sanitize_id( (string) $raw_id );
			if ( '' === $id ) {
				continue;
			}
			try {
				$gradient = $this->schema->sanitize_gradient( $gradient, $id );
			} catch ( \InvalidArgumentException $error ) {
				continue;
			}
			$gradient['css'] = $this->schema->build_css( $gradient );
			$clean[ $id ]    = $gradient;
		}
		return $clean;
	}

	/** @param string $id Gradient ID. @return array|null */
	public function get_gradient( string $id ) {
		$gradient = $this->repository->get( $id );
		$gradient = apply_filters( 'lmsc_gte_brand_gradient', $gradient, $id );
		if ( ! is_array( $gradient ) ) {
			return null;
		}

		try {
			return $this->schema->sanitize_gradient( $gradient, $id );
		} catch ( \InvalidArgumentException $error ) {
			return null;
		}
	}

	/** @param string $id Gradient ID. @return string Safe CSS image value. */
	public function get_css( string $id ): string {
		$gradient = $this->get_gradient( $id );
		return is_array( $gradient ) ? $this->schema->build_css( $gradient ) : '';
	}

	/** @param string $id Gradient ID. @return array Existing-widget setting map. */
	public function to_elementor_settings( string $id ): array {
		$gradient = $this->get_gradient( $id );
		return is_array( $gradient ) ? $this->schema->to_elementor_settings( $gradient ) : [];
	}

	/**
	 * Sanitize a solid color or Elementor global variable for rendering.
	 *
	 * This is intentionally independent of Elementor classes.
	 *
	 * @param string $color Raw color.
	 * @return string Empty string for invalid input.
	 */
	public function sanitize_color( string $color ): string {
		$solid = $this->schema->sanitize_solid_color( $color );
		if ( '' !== $solid ) {
			return $solid;
		}

		return $this->schema->sanitize_global_variable( $color );
	}
}
