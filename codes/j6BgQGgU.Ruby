    create_table :osobas do |t|
      t.string :imie
      t.string :nazwisko
      t.string :email
      t.float :wykorzystane_godziny
      t.string :katedra
      t.string :tytul_naukowy
      t.integer :nr_indeksu
      t.string :kierunek_studiow
      t.string :specjalnosc
      t.string :discriminator

      t.timestamps
    end

    create_table :temats do |t|
      t.string :nazwa
      t.datetime :data_zgloszenia
      t.boolean :prawidlowy
      t.boolean :przeglosowany
      t.boolean :opublikowany
      t.boolean :wybrany
      t.boolean :zatw_katedra
      t.boolean :zatw_dziekan
      t.boolean :ukonczony
      t.boolean :nazwa_ang
      t.integer :rodzaj
      t.boolean :sprawdzony_asap

      t.timestamps
    end

    create_table :recenzjas do |t|
      t.text :odpowiada_tematowi
      t.text :ocena_kompozycji
      t.text :ocena_merytoryczna
      t.text :uwagi
      t.text :ujecie_problemu
      t.text :zrodla
      t.text :ocena_formalna
      t.text :wykorzystanie_pracy
      t.text :ocena_podsumowanie
      t.date :data_utworzenia
      t.float :ocena

      t.timestamps
    end

    add_column :osobas, :promotor_id, :integer
    add_column :recenzjas, :promotor_id, :integer
    add_column :recenzjas, :recenzent_id, :integer
    add_reference :recenzjas, :temat, foreign_key: true
    add_column :temats, :osoba_id, :integer
    add_column :osobas, :temat_id, :integer