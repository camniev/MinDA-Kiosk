<?php
/**
 * Brand Gradients module composition root.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/** Compose services once and expose the read-only integration service. */
final class Brand_Gradients_Module {

	/** @var self|null */
	private static $instance;

	/** @var Brand_Gradient_Integration */
	private $integration;

	/** @var Brand_Gradients_Admin */
	private $admin;

	/** @return self */
	public static function boot(): self {
		if ( self::$instance instanceof self ) {
			return self::$instance;
		}

		$schema       = new Brand_Gradient_Schema();
		$repository   = new Brand_Gradient_Repository( $schema );
		$global_colors = new Elementor_Global_Colors( $schema );
		$integration  = new Brand_Gradient_Integration( $repository, $schema );
		$admin        = new Brand_Gradients_Admin( $repository, $schema, $global_colors );

		self::$instance = new self( $integration, $admin );
		self::$instance->register_hooks();
		return self::$instance;
	}

	/** @param Brand_Gradient_Integration $integration Integration. @param Brand_Gradients_Admin $admin Admin. */
	private function __construct( Brand_Gradient_Integration $integration, Brand_Gradients_Admin $admin ) {
		$this->integration = $integration;
		$this->admin       = $admin;
	}

	/** @return Brand_Gradient_Integration */
	public function integration(): Brand_Gradient_Integration {
		return $this->integration;
	}

	/** @return void */
	private function register_hooks() {
		if ( function_exists( 'add_action' ) ) {
			foreach ( [
				'lmsc_gte_brand_gradient_created',
				'lmsc_gte_brand_gradient_updated',
				'lmsc_gte_brand_gradient_deleted',
				'lmsc_gte_brand_gradients_imported',
			] as $hook ) {
				add_action( $hook, [ $this, 'clear_elementor_css_cache' ] );
			}
		}

		if ( is_admin() ) {
			$this->admin->register_hooks();
		}
		do_action( 'lmsc_gte_brand_gradients_loaded', $this );
	}

	/**
	 * Invalidate generated Elementor CSS after a central palette mutation.
	 *
	 * Elementor is optional and its internal service shape can change, so every
	 * dependency boundary is guarded and a cache API failure cannot break CRUD.
	 *
	 * @return void
	 */
	public function clear_elementor_css_cache() {
		try {
			if ( ! class_exists( '\\Elementor\\Plugin' ) || ! isset( \Elementor\Plugin::$instance ) || ! is_object( \Elementor\Plugin::$instance ) ) {
				return;
			}

			$files_manager = \Elementor\Plugin::$instance->files_manager ?? null;
			if ( is_object( $files_manager ) && is_callable( [ $files_manager, 'clear_cache' ] ) ) {
				$files_manager->clear_cache();
			}
		} catch ( \Throwable $error ) {
			// Palette CRUD must remain available when Elementor is absent or changes internals.
		}
	}
}
