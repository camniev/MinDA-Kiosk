<?php
/**
 * Uninstall handler for LMSCrafter Gradient Text for Elementor.
 *
 * Fires when the plugin is deleted via the WordPress admin.
 * Cleans up any data stored by the plugin.
 *
 * @package LMSC_GTE
 * @since   1.0.0
 */

// If uninstall not called from WordPress, exit.
if ( ! defined( 'WP_UNINSTALL_PLUGIN' ) ) {
	exit;
}

// Saved Brand Gradients live in one non-autoloaded option. Delete it only on
// explicit uninstall; ordinary deactivation must preserve the site library.
delete_option( 'lmsc_gte_brand_gradients' );
