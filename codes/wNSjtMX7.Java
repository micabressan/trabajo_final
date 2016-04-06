private View getDatePicker(final int childPosition, View convertView, ViewGroup parent) {
        if (null == convertView) {
            convertView = layoutInflater.inflate(R.layout.report_date_picker, parent, false);
        }

        return convertView;
    }