<style type="text/css">
    html {
  font-family: "Calibri", "Trebuchet MS", "Helvetica", sans-serif;
  background-color: #F3F3F3;
}

.white-popup {
  position: relative;
  background: #FFF;
  padding: 25px;
  width: auto;
  max-width: 400px;
  margin: 0 auto;
}

img {
  width: 100px;
  height: 100px;
  float: left;
  margin-right: 15px;
}

.mfp-newspaper .mfp-with-anim {
  opacity: 0;
  -webkit-transition: all 0.2s ease-in-out;
  transition: all 0.5s;
  transform: scale(0) rotate(500deg);
}
.mfp-newspaper.mfp-bg {
  opacity: 0;
  transition: all 0.5s;
}
.mfp-newspaper.mfp-ready .mfp-with-anim {
  opacity: 1;
  transform: scale(1) rotate(0deg);
}
.mfp-newspaper.mfp-ready.mfp-bg {
  opacity: 0.8;
}
.mfp-newspaper.mfp-removing .mfp-with-anim {
  transform: scale(0) rotate(500deg);
  opacity: 0;
}
.mfp-newspaper.mfp-removing.mfp-bg {
  opacity: 0;
}

</style>