// Event handlers for hover, mouseleave & mousemove & on-click
// The page must define a `#actionmap-info-box` div with `.d-none`
exports.handleMapMouseEvents = (jQueryTargets, hoverHtmlProvider, clickCallback) => {
  const infoBox = $('#actionmap-info-box');

  // Pointer Enter is used to handle touch screen support AND hover
  jQueryTargets.on('pointerenter', (e) => {
    infoBox.html(hoverHtmlProvider($(e.currentTarget)));
    infoBox.css('display', 'block');
  });

  // Focus is used when a keyboard user tabs through the map.
  jQueryTargets.on('focus', (e) => {
    const elem = $(e.currentTarget);
    infoBox.html(hoverHtmlProvider(elem));
    infoBox.css('display', 'block');
    // Position near the focused element instead of cursor
    const offset = elem.offset();
    infoBox.css('top', offset.top - infoBox.height() - 10);
    infoBox.css('left', offset.left + elem.width() / 2 - infoBox.width() / 2);
  });

  // Remove the state/county infobox
  // Blur applies when a user tabs out of a region.
  jQueryTargets.mouseleave(() => infoBox.css('display', 'none'));
  jQueryTargets.on('blur', () => { infoBox.css('display', 'none'); });

  $(document).on('mousemove', (elem) => {
    infoBox.css('top', elem.pageY - infoBox.height() - 30);
    infoBox.css('left', elem.pageX - infoBox.width() / 2);
  });

  jQueryTargets.click((e) => {
    clickCallback($(e.currentTarget));
  });

  // Allow the click handler to be triggered via a keyboard.
  jQueryTargets.on('keydown', (e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      clickCallback($(e.currentTarget));
    }
  });
};

exports.zeroPad = (number, numZeros) => {
  let s = String(number);
  while (s.length < (numZeros || 1)) { s = `0${s}`; }
  return s;
};
