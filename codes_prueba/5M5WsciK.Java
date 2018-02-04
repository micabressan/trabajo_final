class CustomViewWithButton extends ViewGroup {

    interface MyCustomViewListener {
        public void onButtonClick();
    }

    MyCustomViewListener listener;
    Button button;
    
    public CustomViewWithButton(Context context) {
        // init views
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                // do stuff on button click
                if(listener != null) listener.onButtonClick()
	    }
        })
    }

   public void setCustomViewListener(MyCustomViewListener listener) { this.listener = listener; }
}


/// in your activity:
myCustomViewWithButton.setCustomViewListener(new CustomViewWithButton.MyCustomViewListener() {
    public void onButtonClick() {  // do struff  }
});