<?php
/**
 * Brand Gradients settings screen.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 *
 * @var array                       $gradients
 * @var array                       $editing
 * @var array|null                  $notice
 * @var array                       $globals
 * @var Brand_Gradient_Schema       $schema
 * @var string                      $admin_url
 * @var string                      $page_url
 */

use LMSC_GTE\Brand_Gradients\Brand_Gradient_Schema;

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

// This template is included inside Brand_Gradients_Admin::render_page(), so
// these variables remain method-local even though static analysis sees a file.
// phpcs:disable WordPress.NamingConventions.PrefixAllGlobals.NonPrefixedVariableFound
$is_editing = ! empty( $editing['id'] );
$centers    = [
	'center'       => __( 'Center', 'lmscrafter-gradient-text-for-elementor' ),
	'top'          => __( 'Top', 'lmscrafter-gradient-text-for-elementor' ),
	'top right'    => __( 'Top right', 'lmscrafter-gradient-text-for-elementor' ),
	'right'        => __( 'Right', 'lmscrafter-gradient-text-for-elementor' ),
	'bottom right' => __( 'Bottom right', 'lmscrafter-gradient-text-for-elementor' ),
	'bottom'       => __( 'Bottom', 'lmscrafter-gradient-text-for-elementor' ),
	'bottom left'  => __( 'Bottom left', 'lmscrafter-gradient-text-for-elementor' ),
	'left'         => __( 'Left', 'lmscrafter-gradient-text-for-elementor' ),
	'top left'     => __( 'Top left', 'lmscrafter-gradient-text-for-elementor' ),
];
?>
<div class="wrap lmsc-gte-brand-admin">
	<header class="lmsc-gte-brand-header">
		<div>
			<h1><?php esc_html_e( 'Brand Gradients', 'lmscrafter-gradient-text-for-elementor' ); ?></h1>
			<p><?php esc_html_e( 'Save reusable site palettes with precise stops and optional Elementor Global Color tokens.', 'lmscrafter-gradient-text-for-elementor' ); ?></p>
		</div>
		<div class="lmsc-gte-brand-header__actions">
			<a class="button" href="<?php echo esc_url( $page_url ); ?>"><?php esc_html_e( 'New gradient', 'lmscrafter-gradient-text-for-elementor' ); ?></a>
			<form method="post" action="<?php echo esc_url( $admin_url ); ?>">
				<input type="hidden" name="action" value="lmsc_gte_brand_gradients_export">
				<?php wp_nonce_field( 'lmsc_gte_brand_gradients_export' ); ?>
				<button class="button button-secondary" type="submit"><?php esc_html_e( 'Export JSON', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
			</form>
		</div>
	</header>

	<?php if ( is_array( $notice ) ) : ?>
		<div class="notice notice-<?php echo 'success' === ( $notice['type'] ?? '' ) ? 'success' : 'error'; ?> is-dismissible"><p><?php echo esc_html( $notice['message'] ?? '' ); ?></p></div>
	<?php endif; ?>

	<div class="lmsc-gte-brand-layout">
		<section class="lmsc-gte-brand-panel lmsc-gte-brand-editor" aria-labelledby="lmsc-gte-editor-heading">
			<h2 id="lmsc-gte-editor-heading"><?php echo $is_editing ? esc_html__( 'Edit gradient', 'lmscrafter-gradient-text-for-elementor' ) : esc_html__( 'Create gradient', 'lmscrafter-gradient-text-for-elementor' ); ?></h2>
			<div class="lmsc-gte-gradient-preview" data-gradient-preview style="background-image: <?php echo esc_attr( $schema->build_css( $editing ) ); ?>;" aria-hidden="true"></div>

			<form method="post" action="<?php echo esc_url( $admin_url ); ?>" data-gradient-form>
				<input type="hidden" name="action" value="lmsc_gte_brand_gradient_save">
				<input type="hidden" name="gradient[id]" value="<?php echo esc_attr( $editing['id'] ); ?>">
				<?php wp_nonce_field( 'lmsc_gte_brand_gradient_save' ); ?>

				<div class="lmsc-gte-field">
					<label for="lmsc-gte-gradient-name"><?php esc_html_e( 'Gradient name', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
					<input id="lmsc-gte-gradient-name" class="regular-text" type="text" maxlength="80" required name="gradient[name]" value="<?php echo esc_attr( $editing['name'] ); ?>" placeholder="<?php esc_attr_e( 'Example: Primary campaign', 'lmscrafter-gradient-text-for-elementor' ); ?>">
				</div>

				<div class="lmsc-gte-meta-grid">
					<div class="lmsc-gte-field">
						<label for="lmsc-gte-gradient-type"><?php esc_html_e( 'Type', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
						<select id="lmsc-gte-gradient-type" name="gradient[type]" data-gradient-type>
							<option value="linear" <?php selected( $editing['type'], 'linear' ); ?>><?php esc_html_e( 'Linear', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
							<option value="radial" <?php selected( $editing['type'], 'radial' ); ?>><?php esc_html_e( 'Radial', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
							<option value="conic" <?php selected( $editing['type'], 'conic' ); ?>><?php esc_html_e( 'Conic', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
						</select>
					</div>
					<div class="lmsc-gte-field" data-angle-field>
						<label for="lmsc-gte-gradient-angle"><?php esc_html_e( 'Angle (degrees)', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
						<input id="lmsc-gte-gradient-angle" type="number" min="0" max="360" step="1" name="gradient[angle]" value="<?php echo esc_attr( $editing['angle'] ); ?>" data-gradient-angle>
					</div>
					<div class="lmsc-gte-field" data-radial-shape-field>
						<label for="lmsc-gte-radial-shape"><?php esc_html_e( 'Radial shape', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
						<select id="lmsc-gte-radial-shape" name="gradient[radial_shape]" data-radial-shape>
							<option value="circle" <?php selected( $editing['radial_shape'], 'circle' ); ?>><?php esc_html_e( 'Circle', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
							<option value="ellipse" <?php selected( $editing['radial_shape'], 'ellipse' ); ?>><?php esc_html_e( 'Ellipse', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
						</select>
					</div>
					<div class="lmsc-gte-field" data-center-field>
						<label for="lmsc-gte-center-position"><?php esc_html_e( 'Center position', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
						<select id="lmsc-gte-center-position" name="gradient[center_position]" data-center-position>
							<?php foreach ( $centers as $center_value => $center_label ) : ?>
								<option value="<?php echo esc_attr( $center_value ); ?>" <?php selected( $editing['center_position'], $center_value ); ?>><?php echo esc_html( $center_label ); ?></option>
							<?php endforeach; ?>
						</select>
					</div>
				</div>

				<div class="lmsc-gte-stops-heading">
					<div>
						<h3><?php esc_html_e( 'Color stops', 'lmscrafter-gradient-text-for-elementor' ); ?></h3>
						<p><?php esc_html_e( 'Stops are saved in position order. Use two to five colors.', 'lmscrafter-gradient-text-for-elementor' ); ?></p>
					</div>
					<button type="button" class="button" data-add-stop><?php esc_html_e( 'Add color', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
				</div>

				<div class="lmsc-gte-stop-list" data-stop-list>
					<?php foreach ( $editing['stops'] as $index => $stop ) : ?>
						<?php
						$source    = 'global' === ( $stop['source'] ?? '' ) ? 'global' : 'solid';
						$solid     = 'solid' === $source ? ( $stop['color'] ?? '#000000' ) : ( $stop['fallback'] ?? '#000000' );
						$global_id = $stop['global_id'] ?? 'primary';
						$field_id  = 'lmsc-gte-stop-' . $index . '-';
						?>
						<div class="lmsc-gte-stop" data-stop>
							<div class="lmsc-gte-stop__topline">
								<strong data-stop-title><?php
									echo esc_html(
										sprintf(
											/* translators: %d: Color stop number. */
											__( 'Color stop %d', 'lmscrafter-gradient-text-for-elementor' ),
											$index + 1
										)
									);
									?></strong>
								<div class="lmsc-gte-stop__buttons">
									<button type="button" class="button-link" data-move-up aria-label="<?php esc_attr_e( 'Move stop up', 'lmscrafter-gradient-text-for-elementor' ); ?>">↑</button>
									<button type="button" class="button-link" data-move-down aria-label="<?php esc_attr_e( 'Move stop down', 'lmscrafter-gradient-text-for-elementor' ); ?>">↓</button>
									<button type="button" class="button-link-delete" data-remove-stop><?php esc_html_e( 'Remove', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
								</div>
							</div>
							<div class="lmsc-gte-stop__fields">
								<div class="lmsc-gte-field">
									<label for="<?php echo esc_attr( $field_id . 'source' ); ?>"><?php esc_html_e( 'Color source', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
									<select id="<?php echo esc_attr( $field_id . 'source' ); ?>" name="gradient[stops][<?php echo esc_attr( $index ); ?>][source]" data-stop-source>
										<option value="solid" <?php selected( $source, 'solid' ); ?>><?php esc_html_e( 'Solid color', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
										<option value="global" <?php selected( $source, 'global' ); ?>><?php esc_html_e( 'Elementor Global Color', 'lmscrafter-gradient-text-for-elementor' ); ?></option>
									</select>
								</div>
								<div class="lmsc-gte-field" data-solid-field>
									<label for="<?php echo esc_attr( $field_id . 'color' ); ?>"><?php esc_html_e( 'Color', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
									<input id="<?php echo esc_attr( $field_id . 'color' ); ?>" type="text" spellcheck="false" name="gradient[stops][<?php echo esc_attr( $index ); ?>][color]" value="<?php echo esc_attr( $solid ); ?>" data-stop-color>
								</div>
								<div class="lmsc-gte-field" data-global-field>
									<label for="<?php echo esc_attr( $field_id . 'global' ); ?>"><?php esc_html_e( 'Global token', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
									<input id="<?php echo esc_attr( $field_id . 'global' ); ?>" type="text" spellcheck="false" list="lmsc-gte-global-color-tokens" name="gradient[stops][<?php echo esc_attr( $index ); ?>][global_id]" value="<?php echo esc_attr( $global_id ); ?>" data-global-id>
								</div>
								<div class="lmsc-gte-field" data-global-field>
									<label for="<?php echo esc_attr( $field_id . 'fallback' ); ?>"><?php esc_html_e( 'Fallback color', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
									<input id="<?php echo esc_attr( $field_id . 'fallback' ); ?>" type="text" spellcheck="false" name="gradient[stops][<?php echo esc_attr( $index ); ?>][fallback]" value="<?php echo esc_attr( $stop['fallback'] ?? $solid ); ?>" data-global-fallback>
								</div>
								<div class="lmsc-gte-field lmsc-gte-position-field">
									<label for="<?php echo esc_attr( $field_id . 'position' ); ?>"><?php esc_html_e( 'Position (%)', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
									<input id="<?php echo esc_attr( $field_id . 'position' ); ?>" type="number" min="0" max="100" step="0.01" required name="gradient[stops][<?php echo esc_attr( $index ); ?>][position]" value="<?php echo esc_attr( $stop['position'] ); ?>" data-stop-position>
								</div>
								<span class="lmsc-gte-stop__swatch" data-stop-swatch aria-hidden="true"></span>
							</div>
						</div>
					<?php endforeach; ?>
				</div>

				<datalist id="lmsc-gte-global-color-tokens">
					<?php foreach ( $globals as $global ) : ?>
						<option value="<?php echo esc_attr( $global['id'] ); ?>"><?php echo esc_html( $global['label'] ); ?></option>
					<?php endforeach; ?>
				</datalist>

				<div class="lmsc-gte-form-actions">
					<button type="submit" class="button button-primary button-large"><?php echo $is_editing ? esc_html__( 'Update gradient', 'lmscrafter-gradient-text-for-elementor' ) : esc_html__( 'Save gradient', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
					<?php if ( $is_editing ) : ?><a class="button button-large" href="<?php echo esc_url( $page_url ); ?>"><?php esc_html_e( 'Cancel', 'lmscrafter-gradient-text-for-elementor' ); ?></a><?php endif; ?>
				</div>
			</form>
		</section>

		<aside class="lmsc-gte-brand-sidebar">
			<section class="lmsc-gte-brand-panel" aria-labelledby="lmsc-gte-library-heading">
				<h2 id="lmsc-gte-library-heading"><?php esc_html_e( 'Saved library', 'lmscrafter-gradient-text-for-elementor' ); ?> <span class="lmsc-gte-count"><?php echo esc_html( count( $gradients ) ); ?></span></h2>
				<?php if ( empty( $gradients ) ) : ?>
					<p class="lmsc-gte-empty"><?php esc_html_e( 'No saved brand gradients yet. Create your first palette on the left.', 'lmscrafter-gradient-text-for-elementor' ); ?></p>
				<?php else : ?>
					<div class="lmsc-gte-gradient-cards">
						<?php foreach ( $gradients as $gradient ) : ?>
							<article class="lmsc-gte-gradient-card">
								<div class="lmsc-gte-gradient-card__preview" style="background-image: <?php echo esc_attr( $schema->build_css( $gradient ) ); ?>;"></div>
								<div class="lmsc-gte-gradient-card__body">
									<div>
										<strong><?php echo esc_html( $gradient['name'] ); ?></strong>
										<span><?php echo esc_html( ucfirst( $gradient['type'] ) . ' · ' . count( $gradient['stops'] ) . ' ' . __( 'stops', 'lmscrafter-gradient-text-for-elementor' ) ); ?></span>
									</div>
									<div class="lmsc-gte-gradient-card__actions">
										<a class="button button-small" href="<?php echo esc_url( add_query_arg( 'gradient', $gradient['id'], $page_url ) ); ?>"><?php esc_html_e( 'Edit', 'lmscrafter-gradient-text-for-elementor' ); ?></a>
										<form method="post" action="<?php echo esc_url( $admin_url ); ?>" data-delete-gradient>
											<input type="hidden" name="action" value="lmsc_gte_brand_gradient_delete">
											<input type="hidden" name="gradient_id" value="<?php echo esc_attr( $gradient['id'] ); ?>">
											<?php wp_nonce_field( 'lmsc_gte_brand_gradient_delete' ); ?>
											<button type="submit" class="button-link-delete"><?php esc_html_e( 'Delete', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
										</form>
									</div>
								</div>
							</article>
						<?php endforeach; ?>
					</div>
				<?php endif; ?>
			</section>

			<section class="lmsc-gte-brand-panel lmsc-gte-import-panel" aria-labelledby="lmsc-gte-import-heading">
				<h2 id="lmsc-gte-import-heading"><?php esc_html_e( 'Import JSON', 'lmscrafter-gradient-text-for-elementor' ); ?></h2>
				<p><?php esc_html_e( 'Move a library between sites. Imports are fully validated before the option is changed.', 'lmscrafter-gradient-text-for-elementor' ); ?></p>
				<form method="post" enctype="multipart/form-data" action="<?php echo esc_url( $admin_url ); ?>" data-import-form>
					<input type="hidden" name="action" value="lmsc_gte_brand_gradients_import">
					<?php wp_nonce_field( 'lmsc_gte_brand_gradients_import' ); ?>
					<label for="lmsc-gte-gradient-import"><strong><?php esc_html_e( 'Export file', 'lmscrafter-gradient-text-for-elementor' ); ?></strong></label>
					<input id="lmsc-gte-gradient-import" type="file" name="gradient_import" accept="application/json,.json" required>
					<fieldset>
						<legend class="screen-reader-text"><?php esc_html_e( 'Import mode', 'lmscrafter-gradient-text-for-elementor' ); ?></legend>
						<label><input type="radio" name="import_mode" value="merge" checked> <?php esc_html_e( 'Merge with this site', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
						<label><input type="radio" name="import_mode" value="replace"> <?php esc_html_e( 'Replace this site library', 'lmscrafter-gradient-text-for-elementor' ); ?></label>
					</fieldset>
					<button type="submit" class="button"><?php esc_html_e( 'Import gradients', 'lmscrafter-gradient-text-for-elementor' ); ?></button>
				</form>
			</section>
		</aside>
	</div>
</div>
<?php // phpcs:enable WordPress.NamingConventions.PrefixAllGlobals.NonPrefixedVariableFound ?>
