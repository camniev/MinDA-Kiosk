/**
 * Shared gradient builder for Elementor's live editor templates.
 *
 * Frontend rendering remains authoritative in PHP. This small mirror keeps
 * visual stops, saved Brand Gradients, radial geometry, hover, and motion in
 * sync while controls are being edited.
 *
 * @package LMSC_GTE
 * @since   2.0.0
 */
( function ( window ) {
	'use strict';

	var directions = {
		to_top: 0,
		to_top_right: 45,
		to_right: 90,
		to_bottom_right: 135,
		to_bottom: 180,
		to_bottom_left: 225,
		to_left: 270,
		to_top_left: 315
	};

	var radialPositions = {
		center: 'center',
		top: 'center top',
		bottom: 'center bottom',
		left: 'left center',
		right: 'right center',
		top_left: 'left top',
		top_right: 'right top',
		bottom_left: 'left bottom',
		bottom_right: 'right bottom'
	};

	function clamp( value, min, max, fallback ) {
		value = Number( value );
		return Number.isFinite( value ) ? Math.min( max, Math.max( min, value ) ) : fallback;
	}

	function color( value, fallback ) {
		var number = '-?(?:\\d+(?:\\.\\d+)?|\\.\\d+)';
		var rgb = number + '%?';
		var alpha = '(?:0|1(?:\\.0+)?|0?\\.\\d+|(?:' + number + ')%)';
		var hue = number + '(?:deg|grad|rad|turn)?';
		var percent = number + '%';
		var functions = [
			new RegExp( '^rgb\\(\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*\\)$', 'i' ),
			new RegExp( '^rgba\\(\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + alpha + '\\s*\\)$', 'i' ),
			new RegExp( '^hsl\\(\\s*' + hue + '\\s*,\\s*' + percent + '\\s*,\\s*' + percent + '\\s*\\)$', 'i' ),
			new RegExp( '^hsla\\(\\s*' + hue + '\\s*,\\s*' + percent + '\\s*,\\s*' + percent + '\\s*,\\s*' + alpha + '\\s*\\)$', 'i' ),
			new RegExp( '^rgba?\\(\\s*' + rgb + '\\s+' + rgb + '\\s+' + rgb + '(?:\\s*\\/\\s*' + alpha + ')?\\s*\\)$', 'i' ),
			new RegExp( '^hsla?\\(\\s*' + hue + '\\s+' + percent + '\\s+' + percent + '(?:\\s*\\/\\s*' + alpha + ')?\\s*\\)$', 'i' )
		];

		value = String( value || '' ).trim();
		if ( /^#(?:[0-9a-f]{3}|[0-9a-f]{4}|[0-9a-f]{6}|[0-9a-f]{8})$/i.test( value ) || /^var\(--e-global-color-[a-z0-9_-]+\)$/i.test( value ) || functions.some( function ( pattern ) { return pattern.test( value ); } ) ) {
			return value;
		}
		return fallback || '#000000';
	}

	function escapeAttribute( value ) {
		return String( value || '' )
			.replace( /&/g, '&amp;' )
			.replace( /"/g, '&quot;' )
			.replace( /'/g, '&#039;' )
			.replace( /</g, '&lt;' )
			.replace( />/g, '&gt;' );
	}

	function sanitizeUrl( value ) {
		value = String( value || '' ).trim();
		if ( '' === value || /[\u0000-\u001F\u007F]/.test( value ) ) {
			return '';
		}

		if ( /^(?:https?:|mailto:|tel:|sms:)/i.test( value )
			|| /^(?:\/\/|\/(?!\/)|\.\.?\/|#|\?)/.test( value ) ) {
			return value;
		}

		return '';
	}

	function stopPosition( value ) {
		if ( value && 'object' === typeof value ) {
			value = value.size;
		}
		if ( '' === value || null === value || undefined === value ) {
			return '';
		}
		return ' ' + clamp( value, 0, 100, 0 ) + '%';
	}

	function getAngle( settings ) {
		if ( settings.gradient_direction && 'custom' !== settings.gradient_direction && Object.prototype.hasOwnProperty.call( directions, settings.gradient_direction ) ) {
			return directions[ settings.gradient_direction ];
		}
		return clamp( settings.gradient_angle && settings.gradient_angle.size, 0, 360, 90 );
	}

	function getColors( settings, presets ) {
		var colors = [];
		var source = settings.gradient_source || 'preset';

		if ( 'preset' === source ) {
			var preset = presets && presets[ settings.preset_gradient || 'sunset' ];
			return preset && Array.isArray( preset.colors ) ? preset.colors.slice( 0, 5 ) : [ '#FF512F', '#DD2476' ];
		}

		if ( 'visual' === source && Array.isArray( settings.visual_gradient_stops ) ) {
			settings.visual_gradient_stops.slice( 0, 5 ).forEach( function ( item ) {
				if ( item && 'object' === typeof item ) {
					colors.push( color( item.color, '#000000' ) + stopPosition( item.position ) );
				}
			} );
			return colors.length >= 2 ? colors : [ '#FF512F 0%', '#DD2476 100%' ];
		}

		colors.push( color( settings.color_1, '#FF512F' ) + stopPosition( settings.color_1_stop ) );
		colors.push( color( settings.color_2, '#DD2476' ) + stopPosition( settings.color_2_stop ) );
		[ 3, 4, 5 ].forEach( function ( index ) {
			if ( 'yes' === settings[ 'enable_color_' + index ] && settings[ 'color_' + index ] ) {
				colors.push( color( settings[ 'color_' + index ], '#000000' ) + stopPosition( settings[ 'color_' + index + '_stop' ] ) );
			}
		} );
		return colors;
	}

	function buildGradient( settings, presets, brandGradients ) {
		settings = settings || {};
		if ( 'brand' === settings.gradient_source && brandGradients && brandGradients[ settings.brand_gradient ] ) {
			return String( brandGradients[ settings.brand_gradient ] );
		}

		var type = [ 'linear', 'radial', 'conic' ].indexOf( settings.gradient_type ) >= 0 ? settings.gradient_type : 'linear';
		var colors = getColors( settings, presets ).join( ', ' );
		var angle = getAngle( settings );
		var responsiveAngle = 'var(--lmsc-gte-gradient-angle, ' + angle + 'deg)';

		if ( 'radial' === type ) {
			var shape = 'ellipse' === settings.radial_shape ? 'ellipse' : 'circle';
			var position = radialPositions[ settings.radial_position ] || 'center';
			return 'radial-gradient(' + shape + ' at ' + position + ', ' + colors + ')';
		}
		if ( 'conic' === type ) {
			return 'conic-gradient(from ' + responsiveAngle + ', ' + colors + ')';
		}
		return 'linear-gradient(' + responsiveAngle + ', ' + colors + ')';
	}

	function buildHoverGradient( settings, presets ) {
		var hover = Object.assign( {}, settings, {
			gradient_source: 'visual',
			visual_gradient_stops: [
				{ color: color( settings.hover_color_1, '#11998e' ), position: settings.hover_color_1_stop },
				{ color: color( settings.hover_color_2, '#38ef7d' ), position: settings.hover_color_2_stop }
			]
		} );
		return buildGradient( hover, presets, {} );
	}

	function buildClasses( settings, base ) {
		var classes = base;
		if ( 'yes' === settings.enable_hover ) {
			classes += ' lmsc-gte-has-hover';
		}
		if ( 'yes' === settings.enable_animation ) {
			var direction = [ 'horizontal', 'vertical', 'diagonal' ].indexOf( settings.animation_direction ) >= 0 ? settings.animation_direction : 'horizontal';
			classes += ' lmsc-gte-animated lmsc-gte-animated-' + direction;
			if ( 'yes' === ( settings.pause_on_interaction || 'yes' ) ) {
				classes += ' lmsc-gte-pause-on-interaction';
			}
		}
		if ( 'stroke' === settings.gradient_apply_to ) {
			classes += ' lmsc-gte-stroke-only';
		} else if ( 'both' === settings.gradient_apply_to ) {
			classes += ' lmsc-gte-stroke-both';
		}
		return classes;
	}

	function buildStyle( settings, gradient, presets ) {
		var fallback = color( settings.fallback_color, '#333333' );
		var style = 'background-image:' + gradient + ';--lmsc-gte-gradient:' + gradient + ';--lmsc-gte-fallback-color:' + fallback + ';';

		if ( 'yes' === settings.enable_hover ) {
			style += '--lmsc-gte-hover-gradient:' + buildHoverGradient( settings, presets ) + ';';
		}
		if ( 'yes' === settings.enable_animation ) {
			var speed = clamp( settings.animation_speed && settings.animation_speed.size, 1, 20, 5 );
			var easing = [ 'linear', 'ease', 'ease-in', 'ease-out', 'ease-in-out' ].indexOf( settings.animation_easing ) >= 0 ? settings.animation_easing : 'ease';
			var iterations = [ '1', '3', '5', 'infinite' ].indexOf( String( settings.animation_iterations ) ) >= 0 ? settings.animation_iterations : 'infinite';
			var playState = 'paused' === settings.animation_play_state ? 'paused' : 'running';
			style += '--lmsc-gte-animation-speed:' + speed + 's;--lmsc-gte-animation-easing:' + easing + ';--lmsc-gte-animation-iterations:' + iterations + ';--lmsc-gte-animation-play-state:' + playState + ';';
		}
		if ( 'stroke' === settings.gradient_apply_to || 'both' === settings.gradient_apply_to ) {
			style += '--lmsc-gte-stroke-width:' + clamp( settings.stroke_width && settings.stroke_width.size, 1, 10, 2 ) + 'px;';
		}
		return style;
	}

	window.LmscGtePreview = {
		buildGradient: buildGradient,
		buildClasses: buildClasses,
		buildStyle: buildStyle,
		clamp: clamp,
		color: color,
		escapeAttribute: escapeAttribute,
		sanitizeUrl: sanitizeUrl
	};
}( window ) );
