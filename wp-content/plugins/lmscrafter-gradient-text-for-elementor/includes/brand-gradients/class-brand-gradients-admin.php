<?php
/**
 * Capability- and nonce-protected Brand Gradients admin controller.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */

namespace LMSC_GTE\Brand_Gradients;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/** Owns the settings screen and all mutating/export endpoints. */
final class Brand_Gradients_Admin {

	const PAGE_SLUG   = 'lmsc-gte-brand-gradients';
	const CAPABILITY  = 'manage_options';
	const MAX_JSON_BYTES = 262144;

	/** @var Brand_Gradient_Repository */
	private $repository;

	/** @var Brand_Gradient_Schema */
	private $schema;

	/** @var Elementor_Global_Colors */
	private $global_colors;

	/** @var string */
	private $page_hook = '';

	/**
	 * @param Brand_Gradient_Repository $repository Repository.
	 * @param Brand_Gradient_Schema     $schema Schema.
	 * @param Elementor_Global_Colors   $global_colors Global color resolver.
	 */
	public function __construct( Brand_Gradient_Repository $repository, Brand_Gradient_Schema $schema, Elementor_Global_Colors $global_colors ) {
		$this->repository    = $repository;
		$this->schema        = $schema;
		$this->global_colors = $global_colors;
	}

	/** @return void */
	public function register_hooks() {
		add_action( 'admin_menu', [ $this, 'register_page' ] );
		add_action( 'admin_enqueue_scripts', [ $this, 'enqueue_assets' ] );
		add_action( 'admin_post_lmsc_gte_brand_gradient_save', [ $this, 'handle_save' ] );
		add_action( 'admin_post_lmsc_gte_brand_gradient_delete', [ $this, 'handle_delete' ] );
		add_action( 'admin_post_lmsc_gte_brand_gradients_import', [ $this, 'handle_import' ] );
		add_action( 'admin_post_lmsc_gte_brand_gradients_export', [ $this, 'handle_export' ] );
	}

	/** @return void */
	public function register_page() {
		$this->page_hook = (string) add_options_page(
			__( 'Brand Gradients', 'lmscrafter-gradient-text-for-elementor' ),
			__( 'Brand Gradients', 'lmscrafter-gradient-text-for-elementor' ),
			self::CAPABILITY,
			self::PAGE_SLUG,
			[ $this, 'render_page' ]
		);
	}

	/** @param string $hook Current admin page hook. @return void */
	public function enqueue_assets( string $hook ) {
		if ( $hook !== $this->page_hook ) {
			return;
		}

		$version = defined( 'LMSC_GTE_VERSION' ) ? LMSC_GTE_VERSION : '2.0.0';
		$base    = defined( 'LMSC_GTE_PLUGIN_URL' ) ? LMSC_GTE_PLUGIN_URL : plugin_dir_url( dirname( __DIR__, 2 ) . '/gradient-text-for-elementor.php' );
		wp_enqueue_style( 'lmsc-gte-brand-gradients-admin', $base . 'assets/css/brand-gradients-admin.css', [], $version );
		wp_enqueue_script( 'lmsc-gte-brand-gradients-admin', $base . 'assets/js/brand-gradients-admin.js', [], $version, true );
		wp_localize_script(
			'lmsc-gte-brand-gradients-admin',
			'lmscGteBrandGradients',
			[
				'minStops'       => Brand_Gradient_Schema::MIN_STOPS,
				'maxStops'       => Brand_Gradient_Schema::MAX_STOPS,
				'globalColors'   => array_values( $this->global_colors->all() ),
				'confirmDelete'  => __( 'Delete this saved gradient? Elementor content that references it will no longer be able to resolve the saved palette.', 'lmscrafter-gradient-text-for-elementor' ),
				'confirmReplace' => __( 'Replace every saved brand gradient on this site with the imported file?', 'lmscrafter-gradient-text-for-elementor' ),
				'stopLabel'      => __( 'Color stop', 'lmscrafter-gradient-text-for-elementor' ),
			]
		);
	}

	/** @return void */
	public function render_page() {
		$this->authorize();

		$gradients = $this->repository->all();
		$raw_edit_id = isset( $_GET['gradient'] ) ? wp_unslash( $_GET['gradient'] ) : ''; // phpcs:ignore WordPress.Security.NonceVerification.Recommended,WordPress.Security.ValidatedSanitizedInput.InputNotSanitized -- Read-only edit selector; scalar and canonical ID validation follow.
		$edit_id     = is_scalar( $raw_edit_id ) ? $this->schema->sanitize_id( (string) $raw_edit_id ) : '';
		$editing   = '' !== $edit_id ? $this->repository->get( $edit_id ) : null;
		$notice    = $this->pull_notice();
		$globals   = $this->global_colors->all();
		$schema    = $this->schema;
		$admin_url = admin_url( 'admin-post.php' );
		$page_url  = $this->page_url();

		if ( ! is_array( $editing ) ) {
			$editing = [
				'id'              => '',
				'name'            => '',
				'type'            => 'linear',
				'angle'           => 90,
				'radial_shape'    => 'circle',
				'center_position' => 'center',
				'stops'           => [
					[ 'source' => 'solid', 'color' => '#ff512f', 'position' => 0 ],
					[ 'source' => 'solid', 'color' => '#dd2476', 'position' => 100 ],
				],
			];
		}

		$view = __DIR__ . '/views/page-brand-gradients.php';
		if ( file_exists( $view ) ) {
			include $view;
		}
	}

	/** @return void */
	public function handle_save() {
		$this->authorize();
		check_admin_referer( 'lmsc_gte_brand_gradient_save' );

		$raw = isset( $_POST['gradient'] ) && is_array( $_POST['gradient'] )
			// phpcs:ignore WordPress.Security.ValidatedSanitizedInput.InputNotSanitized -- Nonce verified above; the complete nested document is validated by the schema.
			? wp_unslash( $_POST['gradient'] )
			: [];
		$raw_id = $raw['id'] ?? '';
		$id     = is_scalar( $raw_id ) ? $this->schema->sanitize_id( (string) $raw_id ) : '';

		try {
			$saved = $this->repository->save( $raw, $id );
			$this->set_notice( 'success', __( 'Brand gradient saved.', 'lmscrafter-gradient-text-for-elementor' ) );
			$this->redirect( [ 'gradient' => $saved['id'] ] );
		} catch ( \InvalidArgumentException $error ) {
			$this->set_notice( 'error', $error->getMessage() );
			$this->redirect( $id ? [ 'gradient' => $id ] : [] );
		}
	}

	/** @return void */
	public function handle_delete() {
		$this->authorize();
		check_admin_referer( 'lmsc_gte_brand_gradient_delete' );
		$raw_id = isset( $_POST['gradient_id'] ) ? wp_unslash( $_POST['gradient_id'] ) : ''; // phpcs:ignore WordPress.Security.ValidatedSanitizedInput.InputNotSanitized -- Nonce verified above; repository intentionally rejects non-canonical raw IDs.
		$id     = is_scalar( $raw_id ) ? (string) $raw_id : '';

		if ( $this->repository->delete( $id ) ) {
			$this->set_notice( 'success', __( 'Brand gradient deleted.', 'lmscrafter-gradient-text-for-elementor' ) );
		} else {
			$this->set_notice( 'error', __( 'That brand gradient no longer exists.', 'lmscrafter-gradient-text-for-elementor' ) );
		}
		$this->redirect();
	}

	/** @return void */
	public function handle_import() {
		$this->authorize();
		check_admin_referer( 'lmsc_gte_brand_gradients_import' );

		$raw_mode = isset( $_POST['import_mode'] ) ? wp_unslash( $_POST['import_mode'] ) : ''; // phpcs:ignore WordPress.Security.ValidatedSanitizedInput.InputNotSanitized -- Nonce verified above; only the exact replace token is accepted.
		$mode     = is_scalar( $raw_mode ) && 'replace' === (string) $raw_mode ? 'replace' : 'merge';
		$file = $_FILES['gradient_import'] ?? null; // phpcs:ignore WordPress.Security.ValidatedSanitizedInput.InputNotSanitized -- Upload metadata is type, size, origin, and content validated below.
		try {
			$file_error = is_array( $file ) && is_scalar( $file['error'] ?? null ) ? (int) $file['error'] : UPLOAD_ERR_NO_FILE;
			if ( ! is_array( $file ) || UPLOAD_ERR_OK !== $file_error ) {
				throw new \InvalidArgumentException( __( 'Choose a valid JSON export file.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$size = is_scalar( $file['size'] ?? null ) ? (int) $file['size'] : 0;
			$tmp  = is_scalar( $file['tmp_name'] ?? '' ) ? (string) $file['tmp_name'] : '';
			if ( 0 >= $size || self::MAX_JSON_BYTES < $size || '' === $tmp || ! is_uploaded_file( $tmp ) ) {
				throw new \InvalidArgumentException( __( 'The import file is empty, too large, or not a valid upload.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$actual_size = filesize( $tmp );
			if ( false === $actual_size || 0 >= $actual_size || self::MAX_JSON_BYTES < $actual_size ) {
				throw new \InvalidArgumentException( __( 'The import file is empty, too large, or not a valid upload.', 'lmscrafter-gradient-text-for-elementor' ) );
			}

			$json = file_get_contents( $tmp );
			if ( false === $json ) {
				throw new \InvalidArgumentException( __( 'The import file could not be read.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			if ( self::MAX_JSON_BYTES < strlen( $json ) ) {
				throw new \InvalidArgumentException( __( 'The import file is larger than the 256 KB limit.', 'lmscrafter-gradient-text-for-elementor' ) );
			}
			$document = json_decode( $json, true, 64, JSON_THROW_ON_ERROR );
			if ( ! is_array( $document ) ) {
				throw new \InvalidArgumentException( __( 'The import JSON must contain an object.', 'lmscrafter-gradient-text-for-elementor' ) );
			}

			$summary = $this->repository->import_document( $document, $mode );
			$this->set_notice(
				'success',
				sprintf(
					/* translators: 1: imported count, 2: total count. */
					__( 'Imported %1$d gradients. The library now contains %2$d.', 'lmscrafter-gradient-text-for-elementor' ),
					$summary['imported'],
					$summary['total']
				)
			);
		} catch ( \JsonException $error ) {
			$this->set_notice( 'error', __( 'The selected file is not valid JSON.', 'lmscrafter-gradient-text-for-elementor' ) );
		} catch ( \InvalidArgumentException $error ) {
			$this->set_notice( 'error', $error->getMessage() );
		}

		$this->redirect();
	}

	/** @return void */
	public function handle_export() {
		$this->authorize();
		check_admin_referer( 'lmsc_gte_brand_gradients_export' );

		$document = $this->repository->export_document();
		$filename = 'lmscrafter-brand-gradients-' . gmdate( 'Y-m-d' ) . '.json';
		nocache_headers();
		header( 'Content-Type: application/json; charset=utf-8' );
		header( 'Content-Disposition: attachment; filename="' . $filename . '"' );
		header( 'X-Content-Type-Options: nosniff' );
		echo wp_json_encode( $document, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped -- JSON download, not HTML.
		exit;
	}

	/** @return void */
	private function authorize() {
		if ( ! current_user_can( self::CAPABILITY ) ) {
			wp_die(
				esc_html__( 'You do not have permission to manage brand gradients.', 'lmscrafter-gradient-text-for-elementor' ),
				esc_html__( 'Access denied', 'lmscrafter-gradient-text-for-elementor' ),
				[ 'response' => 403 ]
			);
		}
	}

	/** @return string */
	private function page_url(): string {
		return admin_url( 'options-general.php?page=' . self::PAGE_SLUG );
	}

	/** @param array $args Query arguments. @return void */
	private function redirect( array $args = [] ) {
		$url = $args ? add_query_arg( $args, $this->page_url() ) : $this->page_url();
		wp_safe_redirect( $url );
		exit;
	}

	/** @param string $type success|error. @param string $message Notice message. @return void */
	private function set_notice( string $type, string $message ) {
		set_transient(
			'lmsc_gte_brand_gradients_notice_' . get_current_user_id(),
			[
				'type'    => 'success' === $type ? 'success' : 'error',
				'message' => sanitize_text_field( $message ),
			],
			MINUTE_IN_SECONDS
		);
	}

	/** @return array|null */
	private function pull_notice() {
		$key    = 'lmsc_gte_brand_gradients_notice_' . get_current_user_id();
		$notice = get_transient( $key );
		delete_transient( $key );
		return is_array( $notice ) ? $notice : null;
	}
}
