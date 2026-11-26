<?php
/**
 * Defensive Elementor Global Colors discovery.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/** Discover available Elementor tokens without requiring Elementor. */
final class Elementor_Global_Colors {

	/** @var Brand_Gradient_Schema */
	private $schema;

	/** @param Brand_Gradient_Schema $schema Schema. */
	public function __construct( Brand_Gradient_Schema $schema ) {
		$this->schema = $schema;
	}

	/**
	 * Return global color metadata keyed by token ID.
	 *
	 * The four core tokens are always offered. Active-kit discovery is wrapped
	 * in guards and Throwable handling because Elementor may be absent, old,
	 * partially loaded, or running a changed Kits API.
	 *
	 * @return array
	 */
	public function all(): array {
		$colors = [
			'primary'   => $this->record( 'primary', __( 'Primary', 'lmscrafter-gradient-text-for-elementor' ), '' ),
			'secondary' => $this->record( 'secondary', __( 'Secondary', 'lmscrafter-gradient-text-for-elementor' ), '' ),
			'text'      => $this->record( 'text', __( 'Text', 'lmscrafter-gradient-text-for-elementor' ), '' ),
			'accent'    => $this->record( 'accent', __( 'Accent', 'lmscrafter-gradient-text-for-elementor' ), '' ),
		];

		try {
			if ( ! class_exists( '\\Elementor\\Plugin' ) || ! isset( \Elementor\Plugin::$instance ) ) {
				return $this->filter_colors( $colors );
			}

			$plugin = \Elementor\Plugin::$instance;
			if ( ! isset( $plugin->kits_manager ) || ! is_object( $plugin->kits_manager ) || ! method_exists( $plugin->kits_manager, 'get_active_kit' ) ) {
				return $this->filter_colors( $colors );
			}

			$kit = $plugin->kits_manager->get_active_kit();
			if ( ! is_object( $kit ) ) {
				return $this->filter_colors( $colors );
			}

			foreach ( [ 'system_colors', 'custom_colors' ] as $setting_key ) {
				$items = [];
				if ( method_exists( $kit, 'get_settings_for_display' ) ) {
					$items = $kit->get_settings_for_display( $setting_key );
				} elseif ( method_exists( $kit, 'get_settings' ) ) {
					$settings = $kit->get_settings( $setting_key );
					$items    = is_array( $settings ) ? $settings : [];
				}

				if ( ! is_array( $items ) ) {
					continue;
				}

				foreach ( $items as $item ) {
					if ( ! is_array( $item ) ) {
						continue;
					}
					$raw_id = $item['_id'] ?? ( $item['id'] ?? '' );
					if ( ! is_scalar( $raw_id ) ) {
						continue;
					}
					$id = $this->schema->sanitize_global_id( (string) $raw_id );
					if ( '' === $id ) {
						continue;
					}
					$raw_label = $item['title'] ?? ucfirst( str_replace( [ '-', '_' ], ' ', $id ) );
					$raw_color = $item['color'] ?? '';
					$label = sanitize_text_field( is_scalar( $raw_label ) ? (string) $raw_label : ucfirst( $id ) );
					$color = $this->schema->sanitize_solid_color( is_scalar( $raw_color ) ? (string) $raw_color : '' );
					$colors[ $id ] = $this->record( $id, $label, $color );
				}
			}
		} catch ( \Throwable $error ) {
			// Core tokens still work as CSS variables even when discovery fails.
		}

		return $this->filter_colors( $colors );
	}

	/**
	 * Apply and revalidate extension-provided token records.
	 *
	 * @param array $colors Known colors.
	 * @return array
	 */
	private function filter_colors( array $colors ): array {
		$filtered = apply_filters( 'lmsc_gte_elementor_global_colors', $colors );
		if ( ! is_array( $filtered ) ) {
			return $colors;
		}

		$clean = [];
		foreach ( $filtered as $key => $record ) {
			if ( ! is_array( $record ) ) {
				continue;
			}
			$raw_id = $record['id'] ?? $key;
			if ( ! is_scalar( $raw_id ) ) {
				continue;
			}
			$id = $this->schema->sanitize_global_id( (string) $raw_id );
			if ( '' === $id ) {
				continue;
			}
			$raw_label = $record['label'] ?? ucfirst( $id );
			$raw_color = $record['color'] ?? '';
			$label = sanitize_text_field( is_scalar( $raw_label ) ? (string) $raw_label : ucfirst( $id ) );
			$color = $this->schema->sanitize_solid_color( is_scalar( $raw_color ) ? (string) $raw_color : '' );
			$clean[ $id ] = $this->record( $id, $label, $color );
		}

		return $clean;
	}

	/** @param string $id ID. @param string $label Label. @param string $color Color. @return array */
	private function record( string $id, string $label, string $color ): array {
		return [
			'id'       => $id,
			'label'    => $label,
			'color'    => $color,
			'variable' => sprintf( 'var(--e-global-color-%s)', $id ),
		];
	}
}
