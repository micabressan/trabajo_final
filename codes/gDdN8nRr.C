/*
 * Copyright(c) 2014-2015 Algo Systems, LLC.  All rights reserved.
 *
 * Algo Systems CONFIDENTIAL -- This is an unpublished work of Algo Systems, LLC.,
 * and is fully protected under copyright and trade secret laws.  You may not view,
 * use, disclose, copy, or distribute this file or any information herein except
 * pursuant to a valid written license from Algo Systems.
 */

#include "algocli-defs.h"
#include "cmds.h"

char *final_cmd;
command_t *ccmd = (command_t *)NULL;
command_t *command = (command_t *)NULL;

char *format_doc(int spcount, const char *text){
  int doclen = (spcount + strlen(text));
  char *t = calloc((doclen + 1), sizeof(char));
  int i;

  if (t == NULL)
	fprintf(stderr, "ERROR: not enough memory\n");

  for (i = 0; i < spcount ; i++){
	t[i] = ' ';
  }

  strncat(t, text, doclen);
  return (char*)t;
}

void cmd_ref(){
  int i, j = 0;
  int length = 0;
  int longest = 0;
  int reqspc = 0;
  char *line = rl_line_buffer;
  command_t *command;

  printf("Possible commands for `%s` are:\n\n", line);	

  command = find_last_command(strdup(line));  

  while (command->subcmd[j].name != (char *)NULL){
	length =  strlen(command->subcmd[j].name);
	if ( length > longest )
		longest = length;
	j++;
  }

  for (i = 0 ; ; i++){
	if (command->subcmd[i].name == (char*)NULL)
	    break;
        length = strlen(command->subcmd[i].name);
	reqspc = ((longest - length) + longest);
	printf("\t%s %s%s\n",command->name, command->subcmd[i].name,
		format_doc(reqspc, command->subcmd[i].doc));
        }

  printf("\n");	
}

int algoauth(){
  pam_handle_t* pamh;
  struct pam_conv pamc;
  pamc.conv = &misc_conv;
  pamc.appdata_ptr = NULL;
  pam_start ("algocli", getenv ("USER"), &pamc, &pamh);
  printf("\nPlease re-authenticate as user %s\n", 
	 getenv("USER"));

  if (pam_authenticate (pamh, 0) != PAM_SUCCESS){
	fprintf (stderr, "User verification failed!\n");
	return FALSE;
  }else{
	return TRUE;
  }

  pam_end (pamh, 0);
}

char *stripwhite(char *string){
  register char *s, *t;

  for (s = string; whitespace(*s); s++)

  if (*s == 0)
      return (s);
  t = s + strlen (s) - 1;
  while (t > s && whitespace(*t))
    t--;
  *++t = '\0';

  return s;
}

int execute_command(char *line){
  register int i;
  //command_t *command;
  char **params = calloc(100, sizeof(char*));
  char **cmdlist = calloc(500, sizeof(char*));
  char *cmd;
  int counter = 1;
  int pcounter = 0;
  int index = 0;
  char *commstr = "";
// char *final_cmd;
  cmdlist[0] = strtok(line, " ");
  while ((cmd = strtok(NULL, " "))){
	if (cmd){
//	   printf("cmd[%d] = %s\n",counter,cmd);
	   cmdlist[counter] = cmd;
	   counter++;
	}
	final_cmd = cmd; 
 }
//	printf("%s\n",final_cmd);
 command = find_command(cmdlist[0]);

if (command && cmdlist[1] && (strcmp(command->name, "help") == 0)){
	params[0] = cmdlist[1];
	return ((*(command->func)) (params));
 }

 if (command){
     for ( i = 1 ; i < counter ; i++ ){
         while ((command->subcmd != (command_t *)NULL) &&
		 (commstr = command->subcmd[index].name)){

	       if (strcmp(commstr, cmdlist[i]) == 0){
	          command = &command->subcmd[index];
	          index = 0;
	          break;
	       }
         index++;
         }

	      if (command->subcmd == (command_t *)NULL){
			params[pcounter] = cmdlist[i+1];
			pcounter++;
		}
     }
 }
else{
      func_help(cmdlist);
      return (-1);
 }

 return ((*(command->func)) (params));
}

command_t *find_command(char *name){
  register int i;

  for (i = 0; commands[i].name; i++)
    if (strcmp (name, commands[i].name) == 0)
      return (&commands[i]);

  return ((command_t *)NULL);
}

command_t *find_last_command(char *line){
  command_t *command;
  char *buf[70];
  char *cmd;
  char *commstr = "";
  register int counter = 1;
  register int i;
  int index = 0;

  buf[0] = strtok(line, " ");

  while ((cmd = strtok(NULL, " "))){
         if (cmd){
             buf[counter] = cmd;
             counter++;
        }
  }

  if (buf[0])
      command = find_command(buf[0]);

  if (command){
     for ( i = 1 ; i < counter ; i++ ){
         while ((command->subcmd != (command_t *)NULL) &&
                 (commstr = command->subcmd[index].name)){

               if (strcmp(commstr, buf[i]) == 0){
                  command = &command->subcmd[index];
                  index = 0;
                  break;
               }
         index++;
         }
     }
	return command;
 }

  return (command_t *)NULL;
}

void initialize_readline(char *progname){
  rl_readline_name = progname;
  rl_attempted_completion_function = 
		(rl_completion_func_t*) &algocli_completion;
}

char **algocli_completion(char *text, int start, 
			  int end __attribute__((unused))){

   char **matches;
   matches = (char **)NULL;

   if (start == 0 ){
	matches = rl_completion_matches(text, &algoclibase_generator);
	rl_attempted_completion_over = 1;
   }else{
	char *buffer = malloc(70 * sizeof(char*));
	buffer = strdup(rl_line_buffer);
	ccmd = find_last_command(buffer);
        matches= rl_completion_matches(text, &algoclisub_generator);
	rl_attempted_completion_over = 1;
  }

  return (matches);
}

char *algoclibase_generator(char *text, int state){
  static int list_index, len;
  char *name;

  if (!state){
      list_index = 0;
      len = strlen(text);
    }

  while ((name = commands[list_index].name)){
      list_index++;
      if (strncmp(name, text, len) == 0){
        return (strdup(name));
      }

    }

  return ((char *)NULL);
}

char *algoclisub_generator(char *text, int state){
  static int list_index, len;
  char *name;

  if (!state){
      list_index = 0;
      len = strlen(text);
  }

  while (ccmd && (ccmd->subcmd != (command_t *)NULL) 
         && (name = ccmd->subcmd[list_index].name)){
	list_index++;
	if ((strncmp(name, text, len) == 0)){
             return (strdup(name));
	}
    }

  return ((char *)NULL);
}

int func_exit(){
  exit(0);
}

int func_nfs_share(char **arg){
  return 0;
}

int func_nfs_enable(){
  return nfs_enable();
}

int func_nfs_disable(){
  return nfs_disable();
}

int func_system_set(){
  cmd_ref();
  return 0;
}

int func_system_set_motd(){
  return system_set_motd();
}

int func_system_reboot(){
  return algo_reboot();
}

int func_system_shutdown(){
  return algo_shutdown();
}


int func_accessctrl(char **arg){
  cmd_ref();
  return 0;
}

int func_bp(char **arg){
  cmd_ref();
  return 0;
}

int func_syshealth(char **arg){
  cmd_ref();
  return (0);
}

int func_config(char **arg){
  cmd_ref();
  return (0);
}

int func_disk(char **arg){
  cmd_ref();
  return (0);
}

int func_fs(char **arg){
  cmd_ref();
  return (0);
}

int func_repl(char **arg){
  cmd_ref();
  return (0);
}

int func_net(char **arg){
  cmd_ref();
  return (0);
}

int func_nfs(char **arg){
  cmd_ref();
  return (0);
}

int func_cifs(char **arg){
  cmd_ref();
  return (0);
}

int func_snapshot(char **arg){
  cmd_ref();
  return (0);
}

int func_system(char **arg){
  cmd_ref();
  return (0);
}

int func_user(char **arg){
  cmd_ref();
  return (0);
}

int func_vtl(char **arg){
  cmd_ref();
  return (0);
}

int func_log(char **arg){
  cmd_ref();
  return (0);
}

int func_log_list(char **arg){
   printf("Place LOG LIST help/usage here\n");
   return (0);
}

int func_log_view(char **arg){
  printf("Place LOG VIEW help/usage here\n");
  return (0);
}

int func_log_watch(char **arg){
  printf("Place LOG WATCH help/usage here\n");
  return (0);
}

int func_bp_create(char **arg){
  return bp_create(arg[0]);
}

int func_bp_delete(char **arg){
  if (algoauth()){
      return bp_delete(arg[0]);
  }
}

int func_bp_rename(char **arg){
  return bp_rename(arg[0], arg[1]);
}

int func_bp_quota(char **arg){
  cmd_ref();
  return 0;
}

int func_bp_quota_set(char **arg){
  return bp_quota_set(arg[0], arg[1]);
}

int func_bp_list(char **arg){
  printf("Place BP LIST help/usage here\n");
  return (0);
}

int func_fs_quota(char **arg){
  cmd_ref();
  return (0);
}

int func_fs_quota_enable(char **arg){
  return fs_quota_enable();;
}

int func_fs_quota_disable(char **arg){
  return fs_quota_disable();
}

int func_fs_quota_status(char **arg){
  return fs_quota_status();
}

int func_accessctrl_ssh_disable(char **arg){
  return accessctrl_ssh_disable();
}

int func_accessctrl_ssh_enable(char **arg){
  return accessctrl_ssh_enable();
}

int func_accessctrl_ftp_enable(char **arg){
  return accessctrl_ftp_enable();
}

int func_accessctrl_ftp_disable(char **arg){
  return accessctrl_ftp_disable();
}

int func_accessctrl_web_enable(char **arg){
  return accessctrl_web_enable();
}

int func_accessctrl_web_disable(char **arg){
  return accessctrl_web_disable();;
}

int func_accessctrl_ssh(char **arg){
    cmd_ref();
    return (0);
}

int func_accessctrl_ftp(char **arg){
  cmd_ref();
  return (0);
}

int func_accessctrl_ssh_set(char **arg){
  cmd_ref();
  return (0);
}

int func_accessctrl_ssh_set_port(char **arg){
	
	long port_num;
        int i, stringLength = strlen(final_cmd);

        for(i = 0; i < stringLength; i++)
        {
                if(isdigit(final_cmd[i]) == 0)
                        break;
        }

        if(i == stringLength){
		port_num = strtol(final_cmd, (char **)NULL, 10);
        	printf("The port number is %ld\n", port_num);
	}
        else
                printf("please enter a valid port number\n");
        
        return (0);
}   	

int func_accessctrl_ssh_add(char **arg) {
  cmd_ref();
  return 0;
}

int func_accessctrl_ssh_del(char **arg) {
  cmd_ref();
  return 0;
}

int func_accessctrl_ssh_add_allowedhost(char **arg) {
  return 0;
}

int func_accessctrl_ssh_del_allowedhost(char **arg) {
  return 0;
}

int func_accessctrl_ftp_set(char **arg){
  cmd_ref();
  return (0);
}

int func_accessctrl_ftp_set_port(char **arg){
  printf("Place accessctrl ftp set port help here/usage\n");
  return (0);
}

int func_accessctrl_web_set(char **arg){
  cmd_ref();
  return (0);
}

int func_accessctrl_web_set_http_port(char **arg){
  printf("Place accessctrl web http port help/usage here\n");
  return (0);
}

int func_accessctrl_web_set_https_port(char **arg){
  printf("Place accessctrl web https port help/usage here\n");
  return (0);
}

int func_accessctrl_web_set_http_session(char **arg){
  printf("Place accessctrl web set http session-timeout help/usage here\n");
  return (0);
}

int func_accessctrl_web(char **arg){
  cmd_ref();
  return (0);
}

int func_help(char **arg){
  int i;
  int j = 0;
  int length = 0;
  int longest = 0;
  int reqspc = 0;
  int printed = 0;

  while (commands[j].name != (char *)NULL){
        length =  strlen(commands[j].name);
        if ( length > longest )
                longest = length;
        j++;
  }

  printf("\n");
  for (i = 0; commands[i].name; i++)
    {
      if (arg[0] == (char *)NULL
	  || (strcmp (arg[0], commands[i].name) == 0)){
	  length =  strlen(commands[i].name);
          reqspc = ((longest - length) + longest);
          printf("%s%s.\n", commands[i].name,
		 format_doc(reqspc, commands[i].doc));
          printed++;
        }
    }
  printf("\n");

  if (!printed){
      printf("No such command `%s'. Supported AlgoOS commands are:\n", arg[0]);
      for (i = 0; commands[i].name; i++)
        {
          if (printed == 1)
            {
              printed = 0;
              printf ("\n");
            }

          printf("%s\t", commands[i].name);
          printed++;
        }

      if (printed)
        printf("\n");
    }
  return(0);
}