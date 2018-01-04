                //Note: remember to remove comments about backend query before going into north pole production network
                /*

                isElf = 'elf'
                if request.form['isElf'] != 'True':
                    isElf = 'reindeer'
                attribute_list = [x.encode('UTF8') for x in request.form['attributes'].split(',')]
                result = ldap_query('(|(&(gn=*'+request.form['name']+'*)(ou='+isElf+'))(&(sn=*'+request.form['name']+'*)(ou='+isElf+')))', attribute_list)

                #request.form is the dictionary containing post params sent by client-side
                #We only want to allow query elf/reindeer data

                */