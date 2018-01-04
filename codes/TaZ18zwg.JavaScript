(function() {
  'use strict';
  let tabsBlock = BemBlock.getBlocks('tabs')[0];

  let controlElements = tabsBlock.getElements('control');
  let currentControl = controlElements[0];

  let tabElements = tabsBlock.getElements('tab');
  let currentTab = tabElements[0];

  controlElements.forEach((element, index) =>
    element.addEventListener('click', () => {
      currentControl.setMod('active', false);
      currentTab.setMod('active', false);

      element.setMod('active');
      tabElements[index].setMod('active');

      currentControl = element;
      currentTab = tabElements[index];
    })
  );
})();