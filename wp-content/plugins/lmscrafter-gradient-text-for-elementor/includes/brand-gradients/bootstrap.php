<?php
/**
 * Saved Brand Gradients bootstrap and public helper API.
 *
 * Integration from the plugin entrypoint:
 *
 * require_once LMSC_GTE_PLUGIN_DIR . 'includes/brand-gradients/bootstrap.php';
 * \LMSC_GTE\Brand_Gradients\bootstrap();
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients {
	if ( ! defined( 'ABSPATH' ) ) {
		exit;
	}

	require_once __DIR__ . '/class-brand-gradient-schema.php';
	require_once __DIR__ . '/class-brand-gradient-repository.php';
	require_once __DIR__ . '/class-brand-gradient-integration.php';
	require_once __DIR__ . '/class-elementor-global-colors.php';
	require_once __DIR__ . '/class-brand-gradients-admin.php';
	require_once __DIR__ . '/class-brand-gradients-module.php';

	/** @return Brand_Gradients_Module */
	function bootstrap(): Brand_Gradients_Module {
		return Brand_Gradients_Module::boot();
	}
}

namespace {
	if ( ! function_exists( 'lmsc_gte_get_brand_gradient_options' ) ) {
		/** @return array Elementor select options keyed by gradient ID. */
		function lmsc_gte_get_brand_gradient_options(): array {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->get_options();
		}
	}

	if ( ! function_exists( 'lmsc_gte_get_brand_gradient' ) ) {
		/** @param string $id Gradient ID. @return array|null */
		function lmsc_gte_get_brand_gradient( string $id ) {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->get_gradient( $id );
		}
	}

	if ( ! function_exists( 'lmsc_gte_get_brand_gradients_for_editor' ) ) {
		/** @return array Keyed structured gradients with prebuilt CSS values. */
		function lmsc_gte_get_brand_gradients_for_editor(): array {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->get_for_editor();
		}
	}

	if ( ! function_exists( 'lmsc_gte_get_brand_gradient_css' ) ) {
		/** @param string $id Gradient ID. @return string Safe CSS image value. */
		function lmsc_gte_get_brand_gradient_css( string $id ): string {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->get_css( $id );
		}
	}

	if ( ! function_exists( 'lmsc_gte_brand_gradient_to_elementor_settings' ) ) {
		/** @param string $id Gradient ID. @return array Existing widget setting map. */
		function lmsc_gte_brand_gradient_to_elementor_settings( string $id ): array {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->to_elementor_settings( $id );
		}
	}

	if ( ! function_exists( 'lmsc_gte_sanitize_brand_color' ) ) {
		/** @param string $color Solid color or Elementor global variable. @return string */
		function lmsc_gte_sanitize_brand_color( string $color ): string {
			return \LMSC_GTE\Brand_Gradients\bootstrap()->integration()->sanitize_color( $color );
		}
	}
}
