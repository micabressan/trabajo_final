==7090== Memcheck, a memory error detector
==7090== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
==7090== Using Valgrind-3.10.0.SVN and LibVEX; rerun with -h for copyright info
==7090== Command: ./htest
==7090== 
Error for key "l": 
The specified entry already exists.
==7090== Thread 2:
==7090== Invalid read of size 1
==7090==    at 0x402B43: rehash (hashmap.c:665)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8c60 is 16 bytes after a block of size 61,440 alloc'd
==7090==    at 0x4C2CE8E: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x402CAD: resize (hashmap.c:690)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== Invalid read of size 4
==7090==    at 0x402DF6: probe (hashmap.c:719)
==7090==    by 0x402B8E: rehash (hashmap.c:668)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d54 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x40241B: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d40 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x402421: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d48 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x402429: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d50 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x402431: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d58 is 24 bytes before a block of size 40 alloc'd
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x402439: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d60 is 16 bytes before a block of size 40 alloc'd
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== Invalid read of size 8
==7090==    at 0x402441: copy_entry (hashmap.c:544)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d68 is 8 bytes before a block of size 40 alloc'd
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== Invalid write of size 4
==7090==    at 0x40244D: copy_entry (hashmap.c:545)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d58 is 24 bytes before a block of size 40 alloc'd
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== Invalid write of size 1
==7090==    at 0x402458: copy_entry (hashmap.c:546)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d50 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== Invalid write of size 8
==7090==    at 0x402464: copy_entry (hashmap.c:547)
==7090==    by 0x402BC3: rehash (hashmap.c:676)
==7090==    by 0x402361: check_size (hashmap.c:525)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090==  Address 0x55a8d60 is 16 bytes before a block of size 40 alloc'd
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
Error for key "E": 
The specified entry already exists.
Destroying hashmap!
==7090== Thread 1:
==7090== Jump to the invalid address stated on the next line
==7090==    at 0x0: ???
==7090==    by 0x401405: hashmap_destroy (hashmap.c:153)
==7090==    by 0x400DEC: main (htest.c:37)
==7090==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==7090== 
==7090== 
==7090== Process terminating with default action of signal 11 (SIGSEGV)
==7090==  Bad permissions for mapped region at address 0x0
==7090==    at 0x0: ???
==7090==    by 0x401405: hashmap_destroy (hashmap.c:153)
==7090==    by 0x400DEC: main (htest.c:37)
==7090== 
==7090== HEAP SUMMARY:
==7090==     in use at exit: 3,735,637 bytes in 92,199 blocks
==7090==   total heap usage: 92,408 allocs, 209 frees, 16,747,023 bytes allocated
==7090== 
==7090== 120 bytes in 3 blocks are definitely lost in loss record 1 of 7
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x40130D: hashmap_create (hashmap.c:129)
==7090==    by 0x400CF8: main (htest.c:19)
==7090== 
==7090== 7,061 bytes in 276 blocks are definitely lost in loss record 3 of 7
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x400F04: tfun (htest.c:52)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== 3,596,720 bytes in 89,918 blocks are definitely lost in loss record 7 of 7
==7090==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7090==    by 0x4029AC: init_single_lock (hashmap.c:632)
==7090==    by 0x4028DA: init_entries (hashmap.c:619)
==7090==    by 0x402CF7: resize (hashmap.c:697)
==7090==    by 0x402302: check_size (hashmap.c:517)
==7090==    by 0x401E7B: adjust_size (hashmap.c:453)
==7090==    by 0x401980: hashmap_insert (hashmap.c:304)
==7090==    by 0x400FB4: tfun (htest.c:58)
==7090==    by 0x4E3F181: start_thread (pthread_create.c:312)
==7090==    by 0x514F47C: clone (clone.S:111)
==7090== 
==7090== LEAK SUMMARY:
==7090==    definitely lost: 3,603,901 bytes in 90,197 blocks
==7090==    indirectly lost: 0 bytes in 0 blocks
==7090==      possibly lost: 0 bytes in 0 blocks
==7090==    still reachable: 131,736 bytes in 2,002 blocks
==7090==         suppressed: 0 bytes in 0 blocks
==7090== Reachable blocks (those to which a pointer was found) are not shown.
==7090== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==7090== 
==7090== For counts of detected and suppressed errors, rerun with: -v
==7090== ERROR SUMMARY: 5730 errors from 15 contexts (suppressed: 0 from 0)