 private class FilterAdapter extends BaseAdapter {

        private List<FilterModel> filterList;

        FilterAdapter(List<FilterModel> mList) {

            filterList = mList;
        }


        public void addFilterData(List<FilterModel> fList) {

            filterList = fList;
            notifyDataSetChanged();

            for (int i = 0; i < filterList.size(); i++) {

                Utility.showLog(TAG, "ID :" + filterList.get(i).getFilterID());
                Utility.showLog(TAG, "Name:" + filterList.get(i).getFilterName());
                Utility.showLog(TAG, "Selected :" + filterList.get(i).isSelected());
            }
        }


        class ViewHolder {

            private TextView tvName;
            private CheckBox cbFilterSelected;
        }

        @Override
        public int getCount() {
            // TODO Auto-generated method stub
            return filterList.size();
        }

        @Override
        public Object getItem(int position) {
            // TODO Auto-generated method stub
            return filterList.get(position);
        }

        @Override
        public long getItemId(int position) {
            // TODO Auto-generated method stub
            return 0;
        }

        @Override
        public View getView(final int position, View convertView, ViewGroup parent) {
            // TODO Auto-generated method stub


            ViewHolder holder = null;

            final FilterModel model = filterList.get(position);

            if (convertView == null) {

                holder = new ViewHolder();

                convertView = getLayoutInflater().inflate(
                        R.layout.filter_result_row, parent, false);

                holder.tvName = (TextView) convertView.findViewById(R.id.tvFilterResult);
                holder.cbFilterSelected = (CheckBox) convertView.findViewById(R.id.cbFilterResult);

                holder.cbFilterSelected.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                    @Override
                    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {


                        if (selected_filter_position == 0) {

                            // Category

                            int pos = (Integer) buttonView.getTag();
                            FilterModel categoryModel = categoryList.get(pos);

                            if (isChecked) {

                                if (!selectedCategory.contains(model.getFilterID())) {

                                    selectedCategory.add(model.getFilterID());
                                    model.setSelected(true);
                                    categoryModel.setSelected(true);
                                }

                            } else {

                                if (selectedCategory.contains(model.getFilterID())) {

                                    selectedCategory.remove(model.getFilterID());
                                    categoryModel.setSelected(false);

                                    model.setSelected(false);
                                    categoryModel.setSelected(false);

                                }

                            }

                        } else if (selected_filter_position == 1) {

                            // Brand

                            int pos = (Integer) buttonView.getTag();
                            FilterModel brandModel = brandList.get(pos);

                            Utility.showLog("Clicked Position :", position + "");
                            Utility.showLog("CB TAG Position :", pos + "");

                            if (isChecked) {

                                if (!selectedBrand.contains(model.getFilterID())) {

                                    selectedBrand.add(model.getFilterID());

                                    brandModel.setSelected(true);
                                    model.setSelected(true);
                                }

                            } else {

                                if (selectedBrand.contains(model.getFilterID())) {

                                    selectedBrand.remove(model.getFilterID());
                                    brandModel.setSelected(false);
                                    model.setSelected(false);
                                    Utility.showLog(TAG, filterList.get(pos).isSelected() + "");
                                }
                            }

                    }
                });

                convertView.setTag(holder);

            } else
                holder = (ViewHolder) convertView.getTag();

            holder.cbFilterSelected.setTag(position);
            holder.tvName.setText(getSpannableText(model.getFilterName() + " ", getString(R.string.total_filter_text, model.getTotalProducts())));
            holder.cbFilterSelected.setChecked(model.isSelected());


            return convertView;
        }

    }

// Filter Option ListView Item Click Listener Calls following method

    private void updateResultAdapter(int position) {

        if (position == 0)
            resultAdapter.addFilterData(categoryList);
        else if (position == 1)
            resultAdapter.addFilterData(brandList);
        else if (position == 2)
            resultAdapter.addFilterData(modelList);
        else if (position == 3)
            resultAdapter.addFilterData(sizeList);
        else if (position == 4)
            resultAdapter.addFilterData(genderList);
        else if (position == 6)
            resultAdapter.addFilterData(conditionList);
        else if (position == 7)
            resultAdapter.addFilterData(promotionList);


    }