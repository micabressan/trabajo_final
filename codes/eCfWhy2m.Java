
class Random {

   int an_int_59;
   int an_int_60;
   int an_int_61;
   int an_int_62;


   boolean boolean_method46() {
      return this.int_method18() >= 0;
   }

   void void_method47(long var1) {
      this.void_method27(this.long_method48() ^ var1);
   }

   void void_method27(long var1) {
      this.an_int_59 = (int)(var1 >>> 32);
      this.an_int_60 = this.an_int_61 = this.an_int_62 = (int)var1;

      for(int var3 = 0; var3 != 64; ++var3) {
         this.int_method18();
      }

   }

   long long_method48() {
      return (long)this.int_method18() << 32 | (long)this.int_method18() & 0xFFFFFFFFL;
   }

   int int_method18() {
      int var1 = this.an_int_60;
      int var2 = this.an_int_59 - (var1 << 23 | var1 >>> 9);
      int var3 = this.an_int_61;
      this.an_int_59 = var1 ^= var3 << 16 | var3 >>> 16;
      int var4 = this.an_int_62;
      this.an_int_60 = var3 + (var4 << 11 | var4 >>> 21);
      this.an_int_61 = var4 + var2;
      return this.an_int_62 = var1 + var1;
   }
}