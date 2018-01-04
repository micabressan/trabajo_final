@Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_context_menu, menu);
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
        int position = info.position;

        switch (item.getItemId()) {
            case R.id.editItem:
                myCustomAlertDialog(productList.get(position));
                break;
            case R.id.deleteItem:
                AppDatabase db = Room.databaseBuilder(getApplicationContext(), AppDatabase.class, "DietAppDB").allowMainThreadQueries().fallbackToDestructiveMigration().build();
                db.productDao().delete(productList.get(position));
                productList.remove(position);
                customAdapter.notifyDataSetChanged();
                Snackbar.make(findViewById(android.R.id.content), "Product removed!!", Snackbar.LENGTH_LONG).show();
                break;
        }

        return super.onContextItemSelected(item);
    }

    public void myCustomAlertDialog(final Product product) {
        final Dialog myDialog = new Dialog(ProductsActivity.this);
        myDialog.setContentView(R.layout.item_element_edit);

        EditText editName = (EditText) myDialog.findViewById(R.id.editName);
        EditText editProteins = (EditText) myDialog.findViewById(R.id.editProteins);
        EditText editCarbos = (EditText) myDialog.findViewById(R.id.editCarbos);
        EditText editFats = (EditText) myDialog.findViewById(R.id.editFats);
        EditText editCalories = (EditText) myDialog.findViewById(R.id.editCalories);

        Button editCancelButton = (Button) myDialog.findViewById(R.id.editCancelButton);
        editCancelButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                myDialog.dismiss();
            }
        });

        Button editAcceptButton = (Button) myDialog.findViewById(R.id.editAcceptButton);
        editAcceptButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                String name = ((EditText) myDialog.findViewById(R.id.editName)).getText().toString();
                String proteins = ((EditText) myDialog.findViewById(R.id.editProteins)).getText().toString();
                String carbos = ((EditText) myDialog.findViewById(R.id.editCarbos)).getText().toString();
                String fats = ((EditText) myDialog.findViewById(R.id.editFats)).getText().toString();
                String calories = ((EditText) myDialog.findViewById(R.id.editCalories)).getText().toString();

                product.setName(name);
                product.setProtein(Double.parseDouble(proteins.replaceAll(",",".")));
                product.setCarbo(Double.parseDouble(carbos.replaceAll(",",".")));
                product.setFat(Double.parseDouble(fats.replaceAll(",",".")));
                product.setCalories(Integer.parseInt(calories));

                AppDatabase db = Room.databaseBuilder(getApplicationContext(), AppDatabase.class, "DietAppDB").allowMainThreadQueries().fallbackToDestructiveMigration().build();
                db.productDao().update(product);
                productList = db.productDao().getAll();
                customAdapter.notifyDataSetChanged();
                myDialog.dismiss();
            }
        });


        editName.setText(product.getName());
        editProteins.setText(product.getProtein() + "");
        editCarbos.setText(String.format(Locale.ROOT, "%.1f", product.getCarbo()));
        editFats.setText(product.getFat() + "");
        editCalories.setText(product.getCalories() + "");
        //myDialog.setTitle("My custom dialog");
        myDialog.show();
    }