(function () {
	'use strict';

	var config = window.lmscGteBrandGradients || {};
	var minStops = Number(config.minStops || 2);
	var maxStops = Number(config.maxStops || 5);
	var form = document.querySelector('[data-gradient-form]');

	if (!form) {
		return;
	}

	var list = form.querySelector('[data-stop-list]');
	var preview = document.querySelector('[data-gradient-preview]');
	var typeField = form.querySelector('[data-gradient-type]');
	var angleField = form.querySelector('[data-gradient-angle]');
	var radialShape = form.querySelector('[data-radial-shape]');
	var centerPosition = form.querySelector('[data-center-position]');
	var addButton = form.querySelector('[data-add-stop]');

	function rows() {
		return Array.prototype.slice.call(list.querySelectorAll('[data-stop]'));
	}

	function validSolidColor(value) {
		value = String(value || '').trim();
		if (/^#(?:[a-f\d]{3}|[a-f\d]{4}|[a-f\d]{6}|[a-f\d]{8})$/i.test(value)) {
			return value;
		}

		var number = '-?(?:\\d+(?:\\.\\d+)?|\\.\\d+)';
		var rgb = number + '%?';
		var alpha = '(?:0|1(?:\\.0+)?|0?\\.\\d+|(?:' + number + ')%)';
		var hue = number + '(?:deg|grad|rad|turn)?';
		var percent = number + '%';
		var patterns = [
			'^rgb\\(\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*\\)$',
			'^rgba\\(\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + rgb + '\\s*,\\s*' + alpha + '\\s*\\)$',
			'^hsl\\(\\s*' + hue + '\\s*,\\s*' + percent + '\\s*,\\s*' + percent + '\\s*\\)$',
			'^hsla\\(\\s*' + hue + '\\s*,\\s*' + percent + '\\s*,\\s*' + percent + '\\s*,\\s*' + alpha + '\\s*\\)$',
			'^rgba?\\(\\s*' + rgb + '\\s+' + rgb + '\\s+' + rgb + '(?:\\s*\\/\\s*' + alpha + ')?\\s*\\)$',
			'^hsla?\\(\\s*' + hue + '\\s+' + percent + '\\s+' + percent + '(?:\\s*\\/\\s*' + alpha + ')?\\s*\\)$'
		];
		if (patterns.some(function (pattern) { return new RegExp(pattern, 'i').test(value); })) {
			return value;
		}
		return '#000000';
	}

	function globalColorId(value) {
		value = String(value || '').trim();
		var match = value.match(/^var\(\s*--e-global-color-([A-Za-z0-9_-]{1,64})\s*\)$/);
		if (!match) {
			match = value.match(/^globals\/colors\?id=([A-Za-z0-9_-]{1,64})$/);
		}
		if (!match) {
			match = value.match(/^([A-Za-z0-9_-]{1,64})$/);
		}
		return match ? match[1].toLowerCase() : '';
	}

	function stopColor(row) {
		var source = row.querySelector('[data-stop-source]').value;
		if (source === 'global') {
			var token = globalColorId(row.querySelector('[data-global-id]').value);
			var fallback = validSolidColor(row.querySelector('[data-global-fallback]').value);
			return token ? 'var(--e-global-color-' + token + ', ' + fallback + ')' : fallback;
		}
		return validSolidColor(row.querySelector('[data-stop-color]').value);
	}

	function toggleSource(row) {
		var global = row.querySelector('[data-stop-source]').value === 'global';
		Array.prototype.forEach.call(row.querySelectorAll('[data-global-field]'), function (field) {
			field.hidden = !global;
		});
		var solid = row.querySelector('[data-solid-field]');
		if (solid) {
			solid.hidden = global;
		}
		var swatch = row.querySelector('[data-stop-swatch]');
		if (swatch) {
			swatch.style.backgroundColor = stopColor(row);
		}
	}

	function renumber() {
		var current = rows();
		current.forEach(function (row, index) {
			var title = row.querySelector('[data-stop-title]');
			if (title) {
				title.textContent = String(config.stopLabel || 'Color stop') + ' ' + (index + 1);
			}
			Array.prototype.forEach.call(row.querySelectorAll('[name]'), function (field) {
				field.name = field.name.replace(/gradient\[stops\]\[\d+\]/, 'gradient[stops][' + index + ']');
			});
			[
				['[data-stop-source]', 'source'],
				['[data-stop-color]', 'color'],
				['[data-global-id]', 'global'],
				['[data-global-fallback]', 'fallback'],
				['[data-stop-position]', 'position']
			].forEach(function (definition) {
				var field = row.querySelector(definition[0]);
				if (!field) {
					return;
				}
				field.id = 'lmsc-gte-stop-' + index + '-' + definition[1];
				var label = field.parentElement.querySelector('label');
				if (label) {
					label.htmlFor = field.id;
				}
			});
			var up = row.querySelector('[data-move-up]');
			var down = row.querySelector('[data-move-down]');
			var remove = row.querySelector('[data-remove-stop]');
			if (up) {
				up.disabled = index === 0;
			}
			if (down) {
				down.disabled = index === current.length - 1;
			}
			if (remove) {
				remove.disabled = current.length <= minStops;
			}
			toggleSource(row);
		});
		addButton.disabled = current.length >= maxStops;
	}

	function buildPreview() {
		var stops = rows().map(function (row, index) {
			var positionField = row.querySelector('[data-stop-position]');
			var position = Number(positionField.value);
			if (!Number.isFinite(position)) {
				position = rows().length === 1 ? 0 : (index * 100) / (rows().length - 1);
			}
			return {
				color: stopColor(row),
				position: Math.max(0, Math.min(100, position)),
				order: index
			};
		}).sort(function (left, right) {
			return left.position === right.position ? left.order - right.order : left.position - right.position;
		});

		var stopString = stops.map(function (stop) {
			return stop.color + ' ' + stop.position + '%';
		}).join(', ');
		var type = typeField.value;
		var angle = Math.max(0, Math.min(360, Number(angleField.value) || 0));
		var center = centerPosition.value;
		var image;

		if (type === 'radial') {
			image = 'radial-gradient(' + radialShape.value + ' at ' + center + ', ' + stopString + ')';
		} else if (type === 'conic') {
			image = 'conic-gradient(from ' + angle + 'deg at ' + center + ', ' + stopString + ')';
		} else {
			image = 'linear-gradient(' + angle + 'deg, ' + stopString + ')';
		}
		preview.style.backgroundImage = image;
	}

	function toggleMetadata() {
		var type = typeField.value;
		var angleWrapper = form.querySelector('[data-angle-field]');
		var radialWrapper = form.querySelector('[data-radial-shape-field]');
		var centerWrapper = form.querySelector('[data-center-field]');
		angleWrapper.hidden = type === 'radial';
		radialWrapper.hidden = type !== 'radial';
		centerWrapper.hidden = type === 'linear';
	}

	function addStop() {
		var current = rows();
		if (!current.length || current.length >= maxStops) {
			return;
		}

		var clone = current[current.length - 1].cloneNode(true);
		clone.querySelector('[data-stop-source]').value = 'solid';
		clone.querySelector('[data-stop-color]').value = '#6c5ce7';
		clone.querySelector('[data-global-id]').value = 'primary';
		clone.querySelector('[data-global-fallback]').value = '#6c5ce7';
		clone.querySelector('[data-stop-position]').value = '100';

		var previousLast = current[current.length - 1].querySelector('[data-stop-position]');
		if (Number(previousLast.value) >= 100) {
			previousLast.value = String(Math.round(((current.length - 1) * 100 / current.length) * 100) / 100);
		}

		list.appendChild(clone);
		renumber();
		buildPreview();
	}

	addButton.addEventListener('click', addStop);

	list.addEventListener('click', function (event) {
		var row = event.target.closest('[data-stop]');
		if (!row) {
			return;
		}

		if (event.target.closest('[data-remove-stop]')) {
			if (rows().length > minStops) {
				row.remove();
			}
		} else if (event.target.closest('[data-move-up]') && row.previousElementSibling) {
			list.insertBefore(row, row.previousElementSibling);
		} else if (event.target.closest('[data-move-down]') && row.nextElementSibling) {
			list.insertBefore(row.nextElementSibling, row);
		} else {
			return;
		}

		renumber();
		buildPreview();
	});

	form.addEventListener('input', function (event) {
		var row = event.target.closest('[data-stop]');
		if (row) {
			toggleSource(row);
		}
		toggleMetadata();
		buildPreview();
	});

	form.addEventListener('change', function (event) {
		var row = event.target.closest('[data-stop]');
		if (row) {
			toggleSource(row);
		}
		toggleMetadata();
		buildPreview();
	});

	Array.prototype.forEach.call(document.querySelectorAll('[data-delete-gradient]'), function (deleteForm) {
		deleteForm.addEventListener('submit', function (event) {
			if (!window.confirm(String(config.confirmDelete || 'Delete this gradient?'))) {
				event.preventDefault();
			}
		});
	});

	var importForm = document.querySelector('[data-import-form]');
	if (importForm) {
		importForm.addEventListener('submit', function (event) {
			var replace = importForm.querySelector('input[name="import_mode"]:checked');
			if (replace && replace.value === 'replace' && !window.confirm(String(config.confirmReplace || 'Replace all gradients?'))) {
				event.preventDefault();
			}
		});
	}

	renumber();
	toggleMetadata();
	buildPreview();
}());
