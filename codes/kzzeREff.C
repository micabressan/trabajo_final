c = buffered_fgetc(temp_seq_buffer, &idx, &r, database);
    while((!feof(database) || (feof(database) && idx < r))){

        if(c == '>'){
            
            while(c != '\n') c = buffered_fgetc(temp_seq_buffer, &idx, &r, database);  //Skip ID
                

            while(c != '>' && (!feof(database) || (feof(database) && idx < r))){ //Until next id
                c = buffered_fgetc(temp_seq_buffer, &idx, &r, database);
                c = toupper(c);
                if(c == 'A' || c == 'C' || c == 'G' || c == 'T'){
                    curr_kmer[word_size] = (unsigned char) c;
                    if(word_size < custom_kmer) ++word_size;
                    ++current_len;
                    
                }else{ //It can be anything (including N, Y, X ...)

                    if(c != '\n' && c != '>'){
                        word_size = 0;
                        
                        ++current_len;
                    } 
                }
                if(word_size == custom_kmer){
                    
                    // Overlapping
                    memmove(&curr_kmer[0], &curr_kmer[1], custom_kmer-1);
                    --word_size;
                }
            }
            word_size = 0;
            
        }else{
            c = buffered_fgetc(temp_seq_buffer, &idx, &r, database);    
        }
        
    }