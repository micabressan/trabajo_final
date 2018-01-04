(function () {
  // Don't you just love prefixed stuff? No? Me neither.
  window.AudioContext = window.AudioContext ||
      window.webkitAudioContext ||
      window.mozAudioContext ||
      window.msAudioContext;

  navigator.getUserMedia = navigator.getUserMedia ||
      navigator.webkitGetUserMedia ||
      navigator.mozGetUserMedia ||
      navigator.msGetUserMedia;

  if (typeof window.AudioContext === 'undefined' ||
      typeof navigator.getUserMedia === 'undefined') {

    requestAnimationFrame(function() {
      document.body.classList.add('unsupported');
    });
    return;
  }