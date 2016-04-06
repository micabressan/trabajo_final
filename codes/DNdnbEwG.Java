public static GLAutoDrawable createDummyDrawable(GLAutoDrawable drawable){
        final AbstractGraphicsDevice device = null;
        final GLCapabilitiesImmutable capas = drawable.getChosenGLCapabilities();
        final GLCapabilitiesChooser chooser = null;
        final GLAutoDrawable sharedDrawble = drawable.getFactory().createDummyAutoDrawable(device, true, capas, chooser);
        return sharedDrawble;