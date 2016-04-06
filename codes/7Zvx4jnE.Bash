qtitem.cc: In member function 'virtual QSGNode* QtGLVideoItem::updatePaintNode(QSGNode*, QQuickItem::UpdatePaintNodeData*)':
qtitem.cc:185:14: error: 'class QSGSimpleTextureNode' has no member named 'setOwnsTexture'
     texNode->setOwnsTexture (true);
              ^
make[4]: *** [libqtsink_la-qtitem.lo] Error 1
make[4]: se sale del directorio «/home/vanechipi/src/gstreamer/head/gst-plugins-bad/ext/qt»
make[3]: *** [all] Error 2
make[3]: se sale del directorio «/home/vanechipi/src/gstreamer/head/gst-plugins-bad/ext/qt»
make[2]: *** [qt] Error 2
make[2]: *** Se espera a que terminen otras tareas....
  CC       effects/libgstopengl_la-gstgleffectrgbtocurve.lo
  CC       effects/libgstopengl_la-gstgleffectsin.lo
  CC       effects/libgstopengl_la-gstgleffectxray.lo
  CC       effects/libgstopengl_la-gstgleffectglow.lo
  CC       effects/libgstopengl_la-gstgleffectblur.lo
  CC       effects/libgstopengl_la-gstgleffectsobel.lo
  CC       effects/libgstopengl_la-gstgleffectlaplacian.lo
  CC       libgstopengl_la-gstglcolorscale.lo
  CC       libgstopengl_la-gstglmixer.lo
  CC       libgstopengl_la-gstglvideomixer.lo
  CC       libgstopengl_la-gstglfiltershader.lo
  CC       libgstopengl_la-gstglfilterapp.lo
  CC       libgstopengl_la-gstglfilterglass.lo
  CC       libgstopengl_la-gstgldeinterlace.lo
  CC       libgstopengl_la-gstglviewconvert.lo
  CC       libgstopengl_la-gstglstereosplit.lo
  CC       libgstopengl_la-gstglstereomix.lo
  CC       libgstopengl_la-gltestsrc.lo
  CC       libgstopengl_la-gstgltestsrc.lo
  CC       libgstopengl_la-gstglmosaic.lo
  CC       libgstopengl_la-gstgldifferencematte.lo
  CC       libgstopengl_la-gstgloverlay.lo
  OBJCLD   libgstopengl.la
make[3]: se sale del directorio «/home/vanechipi/src/gstreamer/head/gst-plugins-bad/ext/gl»
make[2]: se sale del directorio «/home/vanechipi/src/gstreamer/head/gst-plugins-bad/ext»
make[1]: *** [all-recursive] Error 1
make[1]: se sale del directorio «/home/vanechipi/src/gstreamer/head/gst-plugins-bad»
make: *** [all] Error 2