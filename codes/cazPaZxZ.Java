    @Override
    protected void onWindowVisibilityChanged(int visibility) {
        super.onWindowVisibilityChanged(visibility);
        if (visibility == VISIBLE) {
            presenter.onResume();
        } else {
            presenter.onPause();
        }
    }