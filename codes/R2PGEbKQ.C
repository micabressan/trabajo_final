#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    
    int banyakJenis, banyakPotong[5], i;
    char jenisPotong[5];
    // int h_dada = 2500, h_paha = 2000, h_sayap = 1500;
    int h_satuan[5];
    // int j_harga[5];
    int j_bayar = 0;
    int pajak = 0;
    
    // table
    printf("GEROBAK FRIED CHICKEN\n");
    printf("---------------------------------------\n");
    printf("Kode           Jenis           Harga   \n");
    printf("---------------------------------------\n");
    printf(" D             Dada            Rp. 2500\n");
    printf(" P             Paha            Rp. 2000\n");
    printf(" S             Sayap           Rp. 1500\n");
    printf("---------------------------------------\n");
    
    // input banyak jenis
    printf("\nBanyak Jenis : "); scanf("%d", &banyakJenis);
    printf("\n");

    // optimalisasi banyak jenis
    while (!scanf("%d", &banyakJenis)) {

        printf("Input tidak valid!\n");
        printf("ulangi : "); scanf("%d", &banyakJenis);
        
        // flush buffer
        while (getchar() != '\n');

    }
    
    // input looping
    for (i = 0; i < banyakJenis; i++) {
        printf("Jenis ke - %d\n", i + 1);
        
        // flush buffer
        while (getchar() != '\n');
        
        // input jenis potong
        printf("Jenis Potong [D/P/S]           : "); scanf("%c", &jenisPotong[i]);

        // optimalisasi jenis potong
        while ((jenisPotong[i] != 'D') && (jenisPotong[i] != 'P') && (jenisPotong[i] != 'S') && (jenisPotong[i] != 'd') && (jenisPotong[i] != 'p') && (jenisPotong[i] != 's')) {
            
            // flush buffer
            while (getchar() != '\n');

            printf("\n");
            printf("Pilihan input diluar stok!\n");
            jenisPotong[i] = '\0';
            printf("Jenis Potong [D/P/S]           : "); scanf("%c", &jenisPotong[i]);

            }
        }

    
    printf("\n\n");
    return 0;
}