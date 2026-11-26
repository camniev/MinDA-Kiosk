<?php
/**
 * Options API repository for site-level brand gradients.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/** Store and retrieve sanitized gradients without a custom table. */
final class Brand_Gradient_Repository {

	const OPTION_NAME  = 'lmsc_gte_brand_gradients';
	const FORMAT       = 'lmsc-gte-brand-gradients';
	const FORMAT_VERSION = 1;
	const MAX_GRADIENTS = 100;

	/** @var Brand_Gradient_Schema */
	private $schema;

	/** @param Brand_Gradient_Schema $schema Schema service. */
	public function __construct( Brand_Gradient_Schema $schema ) {
		$this->schema = $schema;
	}

	/** @return array[] Sorted gradient list. */
	public function all(): array {
		$document  = $this->read_document();
		$gradients = array_values( $document['gradients'] );
		usort(
			$gradients,
			static function ( array $left, array $right ): int {
				return strnatcasecmp( (string) $left['name'], (string) $right['name'] );
			}
		);
		return $gradients;
	}

	/** @param string $id Gradient ID. @return array|null */
	public function get( string $id ) {
		$id       = $this->schema->sanitize_id( $id );
		$document = $this->read_document();
		return $document['gradients'][ $id ] ?? null;
	}

	/**
	 * Create or update a gradient.
	 *
	 * @param array  $input Raw gradient.
	 * @param string $id    Existing ID when updating.
	 * @return array Saved gradient.
	 */
	public function save( array $input, string $id = '' ): array {
		$document = $this->read_document();
		$input_id = $input['id'] ?? '';
		if ( ! is_scalar( $input_id ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient ID must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$input_id = (string) $input_id;
		if ( '' !== $input_id && $input_id !== $this->schema->sanitize_id( $input_id ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient ID is not in its canonical form.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$raw_id = '' !== $id ? $id : $input_id;
		if ( $raw_id !== $this->schema->sanitize_id( $raw_id ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Gradient ID is not in its canonical form.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$id = $raw_id;
		if ( '' === $id ) {
			$id = $this->new_id( $document['gradients'] );
		}

		$is_update = isset( $document['gradients'][ $id ] );
		if ( ! $is_update && self::MAX_GRADIENTS <= count( $document['gradients'] ) ) {
			throw new \InvalidArgumentException( esc_html__( 'The site has reached the limit of 100 saved brand gradients.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$gradient = $this->schema->sanitize_gradient( $input, $id );
		$now      = gmdate( 'c' );
		$gradient['created_at'] = $is_update
			? (string) ( $document['gradients'][ $id ]['created_at'] ?? $now )
			: $now;
		$gradient['updated_at'] = $now;

		$document['gradients'][ $id ] = $gradient;
		$this->write_document( $document );

		do_action( $is_update ? 'lmsc_gte_brand_gradient_updated' : 'lmsc_gte_brand_gradient_created', $gradient ); // phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals.DynamicHooknameFound -- Both conditional hook names are plugin-prefixed literals.
		return $gradient;
	}

	/** @param mixed $id Raw gradient ID. @return bool Whether an item was deleted. */
	public function delete( $id ): bool {
		if ( ! is_scalar( $id ) ) {
			return false;
		}

		$id = (string) $id;
		if ( '' === $id || $id !== $this->schema->sanitize_id( $id ) ) {
			return false;
		}

		$document = $this->read_document();
		if ( ! isset( $document['gradients'][ $id ] ) ) {
			return false;
		}

		$deleted = $document['gradients'][ $id ];
		unset( $document['gradients'][ $id ] );
		$this->write_document( $document );
		do_action( 'lmsc_gte_brand_gradient_deleted', $deleted );
		return true;
	}

	/** @return array Elementor SELECT options keyed by stable gradient ID. */
	public function options(): array {
		$options = [];
		foreach ( $this->all() as $gradient ) {
			$options[ $gradient['id'] ] = $gradient['name'];
		}
		return $options;
	}

	/** @return array Portable JSON-ready document. */
	public function export_document(): array {
		return [
			'format'      => self::FORMAT,
			'version'     => self::FORMAT_VERSION,
			'exported_at' => gmdate( 'c' ),
			'gradients'   => $this->all(),
		];
	}

	/**
	 * Atomically import a validated document.
	 *
	 * Merge updates matching IDs and keeps other site gradients. Replace is
	 * an explicit destructive mode selected in the nonce-protected admin UI.
	 *
	 * @param array  $input Decoded JSON document.
	 * @param string $mode  merge|replace.
	 * @return array Import summary.
	 */
	public function import_document( array $input, string $mode = 'merge' ): array {
		if ( self::FORMAT !== ( $input['format'] ?? '' ) || ! isset( $input['version'] ) || ! is_int( $input['version'] ) || self::FORMAT_VERSION !== $input['version'] ) {
			throw new \InvalidArgumentException( esc_html__( 'This is not a supported Brand Gradients export file.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$incoming = $input['gradients'] ?? null;
		if ( ! is_array( $incoming ) || self::MAX_GRADIENTS < count( $incoming ) ) {
			throw new \InvalidArgumentException( esc_html__( 'The import must contain no more than 100 gradients.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$validated = [];
		$now       = gmdate( 'c' );
		foreach ( array_values( $incoming ) as $raw_gradient ) {
			if ( ! is_array( $raw_gradient ) ) {
				throw new \InvalidArgumentException( esc_html__( 'The import contains an invalid gradient record.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$raw_id = $raw_gradient['id'] ?? '';
			if ( ! is_string( $raw_id ) ) {
				throw new \InvalidArgumentException( esc_html__( 'Every imported gradient ID must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$id = $this->schema->sanitize_id( $raw_id );
			if ( '' !== $raw_id && $raw_id !== $id ) {
				throw new \InvalidArgumentException( esc_html__( 'An imported gradient ID is not in its canonical form.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			if ( '' === $id ) {
				$id = $this->new_id( $validated );
			}
			if ( isset( $validated[ $id ] ) ) {
				throw new \InvalidArgumentException( esc_html__( 'The import contains duplicate gradient IDs.', 'lmscrafter-gradient-text-for-elementor' ) );
			}

			$gradient = $this->schema->sanitize_gradient( $raw_gradient, $id );
			$raw_created_at = $raw_gradient['created_at'] ?? '';
			if ( ! is_scalar( $raw_created_at ) ) {
				throw new \InvalidArgumentException( esc_html__( 'An imported creation date must be a text value.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$gradient['created_at'] = $this->sanitize_iso_date( (string) $raw_created_at, $now );
			$gradient['updated_at'] = $now;
			$validated[ $id ]       = $gradient;
		}

		$mode     = 'replace' === $mode ? 'replace' : 'merge';
		$current  = $this->read_document();
		$existing = 'replace' === $mode ? [] : $current['gradients'];
		$merged   = array_replace( $existing, $validated );
		if ( self::MAX_GRADIENTS < count( $merged ) ) {
			throw new \InvalidArgumentException( esc_html__( 'Importing this file would exceed the 100-gradient site limit.', 'lmscrafter-gradient-text-for-elementor' ) );
		}

		$this->write_document(
			[
				'version'   => self::FORMAT_VERSION,
				'gradients' => $merged,
			]
		);

		$summary = [
			'imported' => count( $validated ),
			'mode'     => $mode,
			'total'    => count( $merged ),
		];
		do_action( 'lmsc_gte_brand_gradients_imported', $summary, $validated );
		return $summary;
	}

	/** @return array Canonical internal option document. */
	private function read_document(): array {
		$raw = get_option( self::OPTION_NAME, [] );
		if ( ! is_array( $raw ) ) {
			$raw = [];
		}

		$gradients = isset( $raw['gradients'] ) && is_array( $raw['gradients'] ) ? $raw['gradients'] : [];
		$clean     = [];
		foreach ( $gradients as $id => $gradient ) {
			if ( ! is_array( $gradient ) ) {
				continue;
			}
			$id = $this->schema->sanitize_id( (string) $id );
			if ( '' === $id ) {
				continue;
			}
			try {
				$validated = $this->schema->sanitize_gradient( $gradient, $id );
			} catch ( \InvalidArgumentException $error ) {
				continue;
			}
			$created_at = $gradient['created_at'] ?? '';
			$updated_at = $gradient['updated_at'] ?? '';
			$validated['created_at'] = $this->sanitize_iso_date( is_scalar( $created_at ) ? (string) $created_at : '', '' );
			$validated['updated_at'] = $this->sanitize_iso_date( is_scalar( $updated_at ) ? (string) $updated_at : '', '' );
			$clean[ $id ]            = $validated;
		}

		return [
			'version'   => self::FORMAT_VERSION,
			'gradients' => $clean,
		];
	}

	/** @param array $document Canonical internal option document. @return void */
	private function write_document( array $document ) {
		$payload = [
			'version'   => self::FORMAT_VERSION,
			'gradients' => $document['gradients'] ?? [],
		];

		if ( false === get_option( self::OPTION_NAME, false ) ) {
			add_option( self::OPTION_NAME, $payload, '', false );
			return;
		}
		update_option( self::OPTION_NAME, $payload, false );
	}

	/** @param array $reserved IDs already reserved by an import. @return string */
	private function new_id( array $reserved = [] ): string {
		do {
			$id = function_exists( 'wp_generate_uuid4' ) ? wp_generate_uuid4() : uniqid( 'gradient-', true );
			$id = $this->schema->sanitize_id( $id );
		} while ( '' === $id || isset( $reserved[ $id ] ) );
		return $id;
	}

	/** @param string $date Raw ISO date. @param string $fallback Fallback. @return string */
	private function sanitize_iso_date( string $date, string $fallback ): string {
		if ( '' !== $date && preg_match( '/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\+00:00|Z)$/', $date ) ) {
			return $date;
		}
		return $fallback;
	}
}
